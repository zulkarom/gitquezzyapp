import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/features/quiz_room/bloc/quiz_room_bloc.dart';
import '../../../core/models/entities.dart';
import '../../../global.dart';
import '../../features/reusable/widgets/flutter_toast.dart';

class GlobalController {
  late BuildContext context;
  GlobalController({required this.context});

  //get student profile
  StudentItem studentProfile = Global.storageService.getStudentProfile();

  //get databse instance
  final db = FirebaseFirestore.instance;
  late String docId;
  late var listener;
  void init() {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    // This is the doc_id obtained from the previous page
    docId = data["doc_id"];
    // print(docId);
    _invitedFriendSnapShots();
  }

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
        .orderBy("entry_time", descending: true);

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
          if (kDebugMode) {
            // print('modified ---: ${change.doc.data()}');
          }
          break;
        case DocumentChangeType.removed:
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
    if (kDebugMode) {
      // print('the length of the chat is ${tempPlyList[0].name}');
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
}
