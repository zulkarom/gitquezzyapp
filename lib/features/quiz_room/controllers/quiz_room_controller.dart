import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ta_plus/core/api/quiz_room_api.dart';
import 'package:flutter_ta_plus/features/quiz_room/bloc/quiz_room_bloc.dart';
import '../../../core/models/entities.dart';
import '../../../global.dart';
import '../../reusable/widgets/flutter_toast.dart';

class QuizRoomController {
  late BuildContext context;
  QuizRoomController({required this.context});

  //get student profile
  StudentItem studentProfile = Global.storageService.getStudentProfile();

  //get databse instance
  final db = FirebaseFirestore.instance;
  late String docId;
  late String adminToken;
  late LevelItem levelItem;
  late var listener;
  void init() {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    // This is the doc_id obtained from the previous page
    docId = data["doc_id"];
    adminToken = data["adminToken"];
    levelItem = data["levelItem"];

    // print(docId);
    context
        .read<QuizRoomBloc>()
        .add(TriggerAdminToken(adminToken, docId, levelItem));
    _invitedFriendSnapShots();
  }

  // Define a function to load list of friends.
  Future<void> asynLoadListSearchFriends(String search, String docId) async {
    SearchRequestEntity searchRequestEntity = SearchRequestEntity();
    searchRequestEntity.search = search;
    searchRequestEntity.token = studentProfile.token;

    // Step 1: Check if the document already exists in the "playerlist" subcollection

    var result = await QuizRoomAPI.qzrSearchFriend(params: searchRequestEntity);
    if (result.code == 200) {
      List<StudentItem> tempFriend = <StudentItem>[];
      for (var item in result.data!) {
        QuerySnapshot checkFriend = await db
            .collection("quizRooms")
            .doc(docId)
            .collection("playerlist")
            .where("student_token", isEqualTo: item.token)
            .get();
        if (checkFriend.docs.isEmpty) {
          {
            tempFriend.add(item);
          }
        }
        // print('${jsonEncode(result.data!)}');
      }
      if (context.mounted) {
        context
            .read<QuizRoomBloc>()
            .add(TriggerSearchMyFriendEvents(tempFriend));
      }
    } else {
      toastInfo(msg: 'Internet error');
    }
  }

  // Define a function to store or remove temporary friend invitation based on sendInvitation or removePlayer
  Future<bool> _invitationTemp(
      String studentToken, String roomDocId, String type) async {
    final data = PlayerRoom(
      studentToken: studentToken,
      roomDocId: roomDocId,
      createdTime: Timestamp.now(),
    );

    // Step 1: Check if the document already exists in the "playerRoom" subcollection
    QuerySnapshot querySnapshot = await db
        .collectionGroup("playerRoom")
        .where("room_doc_id", isEqualTo: roomDocId)
        .where("student_token", isEqualTo: studentToken)
        .get();

    if (querySnapshot.docs.isEmpty && type == "send") {
      //Add playerRoom into firestore and get docId for playerRoom
      var docId = await db
          .collection("playerRoom")
          .withConverter(
              fromFirestore: PlayerRoom.fromFirestore,
              toFirestore: (PlayerRoom playerRoom, options) =>
                  playerRoom.toFirestore())
          .add(data);

      if (docId.id.isNotEmpty) {
        return true;
      }
    } else {
      var document = querySnapshot.docs[0];
      await document.reference.delete();
      return true;
    }
    return false;
  }

  Future<bool> _invitationTemp2(
      String studentToken, String roomDocId, String type) async {
    // var nav = Navigator.of(context);
    if (Global.storageService.getUserToken().isNotEmpty) {
      final playerRoomItem = PlayerRoomItem();
      playerRoomItem.studentToken = studentToken;
      playerRoomItem.roomDocId = roomDocId;
      var result;

      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          maskType: EasyLoadingMaskType.clear,
          dismissOnTap: true);
      if (type == "send") {
        result = await QuizRoomAPI.saveInvitation(params: playerRoomItem);
      } else {
        result = await QuizRoomAPI.removeInvitation(params: playerRoomItem);
      }

      if (result.code == 200) {
        try {
          // Perform any necessary operations for a successful creation
          // ...
          if (studentToken == studentProfile.token && type == "remove") {
            toastInfo(msg: "You have been removed from this lobby");
          }
          EasyLoading.dismiss();

          return true; // Return true to indicate successful creation
        } catch (e) {
          toastInfo(msg: "Error ${e.toString()}");
        }
      } else {
        EasyLoading.dismiss();
        toastInfo(msg: "unknown error");
      }
    }

    return false; // Return false to indicate failed creation
  }

  // Define a function to send invitation to the friends.
  Future<void> sendInvitation(StudentItem playerItem, String docIdN) async {
    // var state = context.read<QuizRoomBloc>().state;

    final content = Player(
      docId: '',
      studentToken: playerItem.token,
      name: playerItem.name,
      avatar: playerItem.avatar,
      entryTime: Timestamp.now(),
      status: 10,
      isAdmin: 0,
      totalQuestion: 0,
      totalMark: 0,
    );

    // Step 1: Check if the document already exists in the "playerlist" subcollection
    QuerySnapshot querySnapshot = await db
        .collection("quizRooms")
        .doc(docIdN)
        .collection("playerlist")
        .where("student_token", isEqualTo: content.studentToken)
        .get();

    // Step 2: Determine whether to add a new document or update an existing one
    if (querySnapshot.docs.isEmpty) {
      // If the document doesn't exist, add a new one
      final docReference = await db
          .collection("quizRooms")
          .doc(docIdN)
          .collection("playerlist")
          .withConverter(
              fromFirestore: Player.fromFirestore,
              toFirestore: (Player player, options) => player.toFirestore())
          .add(content);
      if (docReference.id.isNotEmpty) {
        if (context.mounted) {
          context
              .read<QuizRoomBloc>()
              .add(TriggerInviteFriendEvent(playerItem));
        }
        _invitationTemp2(content.studentToken!, docIdN, 'send');
      }

      //Create a new document or update existing document for student with quizRooms.

      //Create a new Player instance with the assigned docId
      // final playerWithDocId = content.copyWith(docId: docReference.id);
    } else {
      // print("testtttt answerrrr else");
      // If the document already exists, update it (you can update all matching documents if needed)
      // for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      //   await doc.reference.update({
      //     "item_id": content.itemId,
      //     "is_answer": content.isAnswer,
      //   });
      // }
    }
    // var quizRoomRes = db
    // .collection("quizRooms")
    // .doc(docIdN)
    // .collection("playerlist")
    // .withConverter(
    //     fromFirestore: Player.fromFirestore,
    //     toFirestore: (Player ply, options) => ply.toFirestore())
    // .orderBy("entry_time", descending: true);

    // print(answerRes.data()!.avatar);

    // listener = quizRoomRes.snapshots().listen(handleSnapshot, onError: (error) {
    //   toastInfo(msg: 'Listen failed $error');
    // });
  }

  // Define a private function to listen to list of friends changes
  Future<void> _invitedFriendSnapShots() async {
    if (context.mounted) {
      context.read<QuizRoomBloc>().add(const TriggerClearInvitedFriendList());
    }

    var friend = db
        .collection("quizRooms")
        .doc(docId)
        .collection("playerlist")
        .withConverter(
            fromFirestore: Player.fromFirestore,
            toFirestore: (Player ply, options) => ply.toFirestore())
        .orderBy("entry_time", descending: false);

    listener = friend.snapshots().listen(handleSnapshot, onError: (error) {
      toastInfo(msg: 'Listen failed $error');
    });
  }

  // Define a function to handle Firestore snapshot updates
  void handleSnapshot(QuerySnapshot event) {
    // print('receiving trigger from firebase');
    List<Player> tempPlyList = <Player>[];
    for (var change in event.docChanges) {
      // print(change.type);
      switch (change.type) {
        case DocumentChangeType.added:
          if (kDebugMode) {
            // print('added ---: ${change.doc.data()}');
          }
          if (change.doc.data() != null) {
            tempPlyList.add(change.doc.data() as Player? ?? Player());
            // Use Player() or a default Player constructor

            if (kDebugMode) {
              //  print('added');
            }
          }
          break;
        case DocumentChangeType.modified:
          // if (kDebugMode) {
          print('modified ---: ${change.doc.data()}');
          if (change.doc.data() != null) {
            //Find and update player status
            if (context.mounted) {
              var source = change.doc['source'] as String?;
              print(source);
              if (source == 'joinLobby') {
                // Handle modification from joinLobby
                print("source:joinLobby");

                context.read<QuizRoomBloc>().add(
                    TriggerStatusInvitedFriend(change.doc.data() as Player));
              } else if (source == 'playQuiz') {
                // Handle modification from playQuiz
                toastInfo(msg: "source:playQuiz");

                context
                    .read<QuizRoomBloc>()
                    .add(TriggerPlayQuiz(change.doc.data() as Player));
              } else if (source == 'changeAdmin') {
                // Handle modification from changeAdmin

                context
                    .read<QuizRoomBloc>()
                    .add(TriggerChangeAdmin(change.doc.data() as Player));
              } else {
                print("source:Error");
                toastInfo(msg: "Error occurs");
                // Handle modification from unknown source
              }
            }
          } else {
            print("data not exist");
          }

          if (kDebugMode) {
            // Optionally print a message indicating the removal.
            // print('Document removed: ${change.doc.id}');
          }
          //   break;
          // }
          break;
        case DocumentChangeType.removed:
          print('removed ---: ${change.doc.data()}');
          if (change.doc.data() != null) {
            // Find and remove the corresponding document from your list
            if (context.mounted) {
              context
                  .read<QuizRoomBloc>()
                  .add(TriggerRemoveInvitedFriend(change.doc.data() as Player));
            }
          }

          if (kDebugMode) {
            // Optionally print a message indicating the removal.
            // print('Document removed: ${change.doc.id}');
          }
          break;
      }
    }
    for (var element in tempPlyList) {
      if (kDebugMode) {
        // print('${element.name}');
      }
      if (context.mounted) {
        context.read<QuizRoomBloc>().add(TriggerInvitedFriendList(element));
      }
    }
  }

  // Define a function to remove player
  Future<void> removePlayer(String studentToken) async {
    QuerySnapshot querySnapshot;
    print(studentToken);

    try {
      querySnapshot = await db
          .collection("quizRooms")
          .doc(docId)
          .collection("playerlist")
          .where("student_token", isEqualTo: studentToken)
          .get();
    } catch (e) {
      toastInfo(msg: "Error removing player: $e");
      return;
    }

    for (var doc in querySnapshot.docs) {
      doc.reference.delete();

      _invitationTemp2(studentToken, docId, 'remove');
    }
  }

  // Define a function to change admin when leader leave the lobby
  Future<void> changeAdmin() async {
    try {
      final quizRoomRef = db.collection("quizRooms").doc(docId);

      QuerySnapshot newAdminQuery = await db
          .collection("quizRooms")
          .doc(docId)
          .collection("playerlist")
          .where("status", isEqualTo: 20)
          .where("is_admin", isEqualTo: 0)
          .where("student_token", isNotEqualTo: studentProfile.token)
          .get();

// Filter the results in Dart based on "entry_time"
      List<QueryDocumentSnapshot> matchingDocs = newAdminQuery.docs;

// Sort the documents based on "entry_time"
      matchingDocs.sort((a, b) => a['entry_time'].compareTo(b['entry_time']));

      if (matchingDocs.isNotEmpty) {
        QuerySnapshot oldAdminQuery = await db
            .collection("quizRooms")
            .doc(docId)
            .collection("playerlist")
            .where("student_token", isEqualTo: studentProfile.token)
            .where("is_admin", isEqualTo: 1)
            .limit(1)
            .get();

        if (oldAdminQuery.docs.isNotEmpty) {
          // Update the quiz room with the new admin's student_token
          await quizRoomRef
              .update({'student_token': matchingDocs.first['student_token']});
          print(matchingDocs.first['student_token']);
          // Ensure that the update is successful before proceeding to delete
          if (await quizRoomRef
              .get()
              .then((documentSnapshot) => documentSnapshot.exists)) {
            // Get the reference to the new admin document
            DocumentReference documentNewAdmin = matchingDocs.first.reference;

            // Update the is_admin field
            await documentNewAdmin
                .update({'is_admin': 1, 'source': 'changeAdmin'});
            // Check if the update was successful before deleting the old admin
            DocumentSnapshot newAdminSnapshot = await documentNewAdmin.get();
            if (newAdminSnapshot.exists) {
              // Attempt to delete the old admin document
              await oldAdminQuery.docs.first.reference.delete();
              print('Old admin deleted successfully.');
            } else {
              print('Error updating new admin.');
            }
          } else {
            print('Error: Update was not successful.');
          }
        }
      } else {
        if (await quizRoomRef
            .get()
            .then((documentSnapshot) => documentSnapshot.exists)) {
          await quizRoomRef.delete();
          print("deleted");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  // Future<bool> playQuiz() async {
  //   try {
  //     final quizRoomRef = db.collection("quizRooms").doc(docId).withConverter(
  //           fromFirestore: Room.fromFirestore,
  //           toFirestore: (Room room, options) => room.toFirestore(),
  //         );

  //     DocumentSnapshot documentSnapshot = await quizRoomRef.get();

  //     if (documentSnapshot.exists) {
  //       // The document exists in the database
  //       await documentSnapshot.reference.update({'status': 20});

  //       // Update player status
  //       QuerySnapshot querySnapshot = await db
  //           .collection("quizRooms")
  //           .doc(docId)
  //           .collection("playerlist")
  //           .where("status", isEqualTo: 20)
  //           .get();

  //       if (querySnapshot.docs.isNotEmpty) {
  //         //update subcollection playerlist status
  //         for (var player in querySnapshot.docs) {
  //           await player.reference.update({'status': 30}); // 30 : in progress
  //         }
  //       } else {
  //         // Handle the case where no matching document is found
  //         toastInfo(msg: "Player not found in the specified quiz room.");
  //       }

  //       return true; // Indicate success
  //     } else {
  //       toastInfo(msg: 'Document does not exist on the database');
  //       return false; // Indicate failure
  //     }
  //   } catch (e) {
  //     toastInfo(msg: "Error updating room status: $e");
  //     return false; // Indicate failure
  //   }
  // }

  Future<void> playQuiz(LevelItem levelItem) async {
    // QuerySnapshot querySnapshot;
    var nav = Navigator.of(context);
    try {
      final quizRoomRef = db.collection("quizRooms").doc(docId).withConverter(
            fromFirestore: Room.fromFirestore,
            toFirestore: (Room room, options) => room.toFirestore(),
          );

      quizRoomRef.get().then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          // The document exists in the database
          await documentSnapshot.reference.update({'status': 20});
          //Update player status
          QuerySnapshot querySnapshot = await db
              .collection("quizRooms")
              .doc(docId)
              .collection("playerlist")
              .where("status", isEqualTo: 20)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            for (var player in querySnapshot.docs) {
              await player.reference.update(
                  {'status': 30, 'source': 'playQuiz'}); // 30 : in progress

              // Example query to retrieve data from answerList subcollection
              // QuerySnapshot answer = await player.reference
              //     .collection('answer')
              //     .withConverter(
              //         fromFirestore: Ans.fromFirestore,
              //         toFirestore: (Ans ans, options) => ans.toFirestore())
              //     .where('student_token',
              //         isEqualTo: studentProfile.token) //the one trying to chat
              //     .where('level_id', isEqualTo: levelItem.id)
              //     .get();

              // if (answer.docs.isEmpty) {
              //   //never had a answer
              //   var ansData = Ans(
              //     studentToken: studentProfile.token,
              //     levelId: levelItem.id,
              //     name: studentProfile.name,
              //     avatar: studentProfile.avatar,
              //     topicId: level.topic_id,
              //   );
              //   //Add answer into firestore and get docId for answer
              //   await player.reference
              //       .collection("answer")
              //       .withConverter(
              //           fromFirestore: Ans.fromFirestore,
              //           toFirestore: (Ans ans, options) => ans.toFirestore())
              //       .add(ansData);
              // }

              // // Loop through answerList
              // for (QueryDocumentSnapshot answerDoc in answerListSnapshot.docs) {
              //   print('Answer ID: ${answerDoc.id}');
              //   print('Question: ${answerDoc['question']}');
              //   print('Answer: ${answerDoc['answer']}');
              //   print('Timestamp: ${answerDoc['timestamp']}');
              // }

              // print(player.data());
            }
          } else {
            // Handle the case where no matching document is found
            toastInfo(msg: "Player not found in the specified quiz room.");
          }
        } else {
          toastInfo(msg: 'Document does not exist on the database');
        }
      }).catchError((error) => print("Error getting document: $error"));
    } catch (e) {
      toastInfo(msg: "Error updating room status: $e");
      return;
    }
  }
}
