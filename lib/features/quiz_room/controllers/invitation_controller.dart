import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/api/quiz_room_api.dart';
import '../../../core/models/entities.dart';
import '../../../global.dart';
import '../../../routes/routes.dart';
import '../../reusable/widgets/flutter_toast.dart';
import '../bloc/quiz_room_bloc.dart';

class InvitationController {
  late BuildContext context;
  InvitationController({required this.context});

  //get student profile
  StudentItem studentProfile = Global.storageService.getStudentProfile();

  //get databse instance
  final db = FirebaseFirestore.instance;

  // Define a function to load list of invitation.
  Future<void> asynLoadInvitationList() async {
    if (context.mounted) {
      context.read<QuizRoomBloc>().add(const TriggerLoadingMyInvitationEvent());
    }
    // context.read<PlayerRoomBloc>().add(const TriggerLoadingMyPlayerRoomEvent());
    PlayerRoomRequestEntity playerRoomRequestEntity = PlayerRoomRequestEntity();
    //post student token
    playerRoomRequestEntity.id = studentProfile.token;
    print(playerRoomRequestEntity.id);
    var result = await QuizRoomAPI.listRoomId(playerRoomRequestEntity);
    if (result.code == 200) {
      List<Room> tempRoomList = <Room>[];
      for (var data in result.data!) {
        final quizRoomRef = db
            .collection("quizRooms")
            .doc(data.roomDocId)
            .withConverter(
                fromFirestore: Room.fromFirestore,
                toFirestore: (Room room, options) => room.toFirestore());

        quizRoomRef.get().then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            // The document exists in the database
            Room room = documentSnapshot.data() as Room;
            tempRoomList.add(room);
            // print(room
            //     .toMap()); // Assuming toMap() is a method in your Room class to convert it to a Map
          } else {
            print('Document does not exist on the database');
          }

          if (context.mounted) {
            // print('tempRoomList');
            // print(tempRoomList);
            context
                .read<QuizRoomBloc>()
                .add(TriggerLoadedMyInvitationEvent(tempRoomList));

            Future.delayed(const Duration(milliseconds: 10), () {
              context
                  .read<QuizRoomBloc>()
                  .add(const TriggerDoneLoadingMyInvitationEvent());
            });
          }
        }).catchError((error) => print("Error getting document: $error"));
      }
      //save data to shared storage
    }
  }

  // Define a function to join lobby
  Future<void> joinLobby(Room room) async {
    QuerySnapshot querySnapshot;
    var nav = Navigator.of(context);
    try {
      querySnapshot = await db
          .collection("quizRooms")
          .doc(room.roomDocId)
          .collection("playerlist")
          .where("student_token", isEqualTo: studentProfile.token)
          .get();
    } catch (e) {
      toastInfo(msg: "Error updating player status: $e");
      return;
    }

// Assuming there is at most one document in the query result
    if (querySnapshot.docs.isNotEmpty) {
      var doc = querySnapshot.docs.first;
      // Assuming you have a field called 'status' in your document
      await doc.reference.update({'status': 20, 'source': 'joinLobby'});
      nav.pushNamed(AppRoutes.QZ_ROOM, arguments: {
        "doc_id": room.roomDocId,
        "subjectItem": room.subjectItem,
        "topicItem": room.topicItem,
        "levelItem": room.levelItem,
        "adminToken": room.student_token,
      });
    } else {
      // Handle the case where no matching document is found
      toastInfo(msg: "Player not found in the specified quiz room.");
    }
  }
}
