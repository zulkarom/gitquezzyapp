import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/firebase_services/answer_firestore.dart';
import 'package:quezzy_app/core/models/entities.dart';

import '../../../core/api/level_api.dart';
import '../../../core/constant/constants.dart';
import '../../../core/models/answer/ans.dart';
import '../../../global.dart';
import '../../../routes/routes.dart';
import '../bloc/level_bloc.dart';

class LevelController {
  late BuildContext context;
  LevelController({required this.context});
  StudentItem studentProfile = Global.storageService.getStudentProfile();
  String packageId = Global.storageService.getPackageId();
  var db = FirebaseFirestore.instance;

  void init(TopicItem topicItem) {
    asynLoadLevelData(topicItem);
  }

  asynLoadLevelData(TopicItem topicItem) async {
    //Store topic data in local storage
    Global.storageService
        .setString(AppConstants.STORAGE_TOPIC_KEY, jsonEncode(topicItem));
    context.read<LevelBloc>().add(const TriggerLoadingMyLevelEvent());
    LevelRequestEntity levelRequestEntity = LevelRequestEntity();
    //post topic_id
    levelRequestEntity.id = topicItem.id;

    var result = await LevelAPI.levelList(levelRequestEntity);
    List<Ans> answerList = [];
    if (result.code == 200) {
      //get level result
      await AnswerFirestore.getLevelStar(
        topicId: topicItem.id,
      ).then((value) {
        for (var answer in value) {
          answerList.add(answer);
        }
      });

      if (context.mounted) {
        context
            .read<LevelBloc>()
            .add(TriggerLoadedMyLevelEvent(result.data!, answerList));

        Future.delayed(const Duration(milliseconds: 10), () {
          context.read<LevelBloc>().add(const TriggerDoneLoadingMyLevelEvent());
        });
      }
    }
  }

  Future<void> createRoom(
      SubjectItem subjectItem, LevelItem levelItem, TopicItem topicItem) async {
    var nav = Navigator.of(context);
    //you sent answer
    // var createRoom = await db
    //     .collection("quizRooms")
    //     .withConverter(
    //         fromFirestore: Room.fromFirestore,
    //         toFirestore: (Room room, options) => room.toFirestore())
    //     .where('student_token',
    //         isEqualTo: studentProfile.token) //the one trying to chat
    //     .where('level_id', isEqualTo: level.id)
    //     .get();

    //check if we had a room before
    // if (createRoom.docs.isEmpty) {
    //never had a room
    var roomData = Room(
      packageId: int.parse(packageId),
      subjectId: topicItem.subjectId,
      status: 10, // waiting
      student_token: studentProfile.token,
      subjectItem: subjectItem,
      topicItem: topicItem,
      levelItem: levelItem,
    );
    //Add roomData into firestore and get docRef for quizRoom
    var docRef = await db
        .collection("quizRooms")
        .withConverter(
            fromFirestore: Room.fromFirestore,
            toFirestore: (Room room, options) => room.toFirestore())
        .add(roomData);

    // print("docId.id");
    // print(docId.id);

    if (docRef.id.isNotEmpty) {
      // Update the document with the docId
      await docRef.update({'room_doc_id': docRef.id});

      final content = Player(
        studentToken: studentProfile.token,
        name: studentProfile.name,
        avatar: studentProfile.avatar,
        entryTime: Timestamp.now(),
        status: 20,
        isAdmin: 1,
        totalQuestion: 0,
        totalMark: 0,
      );

      final playerListRef = db
          .collection("quizRooms")
          .doc(docRef.id)
          .collection("playerlist")
          .withConverter(
              fromFirestore: Player.fromFirestore,
              toFirestore: (Player player, options) => player.toFirestore());
      await playerListRef.add(content);

      final quizRoomRef = db
          .collection("quizRooms")
          .doc(docRef.id)
          .withConverter(
              fromFirestore: Room.fromFirestore,
              toFirestore: (Room room, options) => room.toFirestore());
      final quizRoomRes = await quizRoomRef.get();

      if (quizRoomRes.data() != null) {
        nav.pop(); // Pop the previous route
        nav.pushReplacementNamed(AppRoutes.QZ_ROOM, arguments: {
          "doc_id": docRef.id,
          "subjectItem": subjectItem,
          "topicItem": topicItem,
          "levelItem": levelItem,
          "adminToken": studentProfile.token,
        });
      }
    }
  }

  Future<void> goAnswer(
      SubjectItem subjectItem, LevelItem levelItem, TopicItem topicItem) async {
    var nav = Navigator.of(context);

    await AnswerFirestore.goAnswer(
      levelItem: levelItem,
      topicItem: topicItem,
      studentProfile: Global.storageService.getStudentProfile(),
      starScore: 0,
    ).then((value) async {
      if (value != null) {
        //check if we had a answer before
        nav.pop(); // Pop the previous route

        nav.pushReplacementNamed(AppRoutes.QZ_INDIVIDUAL, arguments: {
          "answer_doc_id": value,
          "subjectItem": subjectItem,
          "levelItem": levelItem,
          "topicItem": topicItem,
        });
      } else {
        if (kDebugMode) {
          print("error message here");
        }
      }
    });
  }
}
