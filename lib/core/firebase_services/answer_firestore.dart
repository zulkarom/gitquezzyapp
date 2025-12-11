import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ta_plus/core/models/entities.dart';

import '../../global.dart';

class AnswerFirestore {
  // get answer from firestore for individual
  static Future<List<PlayerAnswer>> getAnswerI({String? answerDocId}) async {
    List<PlayerAnswer> answerList = [];

    try {
      final data = await FirebaseFirestore.instance
          .collection("answer")
          .doc(answerDocId)
          .collection("answerlist")
          .get();

      // print(querySnapshot.docs.first.id);
      // Step 2: Determine whether to add a new document or update an existing one
      if (data.docs.isNotEmpty) {
        for (var answer in data.docs) {
          answerList.add(PlayerAnswer.fromMap(answer.data()));
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return answerList;
  }

//get answer from firestore for multiplayer
  static Future<List<PlayerAnswer>> getAnswerM({
    String? roomDocId,
  }) async {
    List<PlayerAnswer> answerList = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("quizRooms")
          .doc(roomDocId)
          .collection("playerlist")
          .where("student_token",
              isEqualTo: Global.storageService.getStudentProfile().token)
          .limit(1)
          .get();
      // print(querySnapshot.docs.first.id);
      // Step 2: Determine whether to add a new document or update an existing one
      if (querySnapshot.docs.isNotEmpty) {
        // Retrieve the document ID from the first document in the query result
        String playerDocId = querySnapshot.docs.first.id;

        final data = await FirebaseFirestore.instance
            .collection("quizRooms")
            .doc(roomDocId)
            .collection("playerlist")
            .doc(playerDocId)
            .collection("answer") // Add another collection here
            .get();

        for (var answer in data.docs) {
          answerList.add(PlayerAnswer.fromMap(answer.data()));
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return answerList;
  }

  //create answer collection in firestore
  static Future<String?> goAnswer({
    LevelItem? levelItem,
    TopicItem? topicItem,
    String? studentToken,
    StudentItem? studentProfile,
    double? starScore,
  }) async {
    var db = FirebaseFirestore.instance;
    //you sent answer
    var sendAnswer = await db
        .collection("answer")
        .withConverter(
            fromFirestore: Ans.fromFirestore,
            toFirestore: (Ans ans, options) => ans.toFirestore())
        .where('student_token', isEqualTo: studentProfile!.token)
        .where('level_id', isEqualTo: levelItem!.id)
        .get();

    //check if we had a answer before
    if (sendAnswer.docs.isEmpty) {
      //never had a answer
      var ansData = Ans(
          studentToken: studentProfile.token,
          packageId: int.parse(Global.storageService.getPackageId()),
          subjectId: topicItem!.subjectId,
          levelId: levelItem.id,
          name: studentProfile.name,
          avatar: studentProfile.avatar,
          topicId: levelItem.topic_id,
          starScore: starScore);
      //Add answer into firestore and get docId for answer
      var docId = await db
          .collection("answer")
          .withConverter(
              fromFirestore: Ans.fromFirestore,
              toFirestore: (Ans ans, options) => ans.toFirestore())
          .add(ansData);

      return docId.id;

      //navigate to question page
    } else {
      // await sendAnswer.docs.first.reference.update({'star_score': starScore});
      return sendAnswer.docs.first.id;
    }
  }

  static Future<String?> updateScore({
    LevelItem? levelItem,
    TopicItem? topicItem,
    String? studentToken,
    StudentItem? studentProfile,
    double? starScore,
    double? totalScore,
  }) async {
    var db = FirebaseFirestore.instance;
    //you sent answer
    var sendAnswer = await db
        .collection("answer")
        .withConverter(
            fromFirestore: Ans.fromFirestore,
            toFirestore: (Ans ans, options) => ans.toFirestore())
        .where('student_token', isEqualTo: studentProfile!.token)
        .where('level_id', isEqualTo: levelItem!.id)
        .get();

    //check if we had a answer before
    if (sendAnswer.docs.isNotEmpty) {
      await sendAnswer.docs.first.reference
          .update({'star_score': starScore, 'total_score': totalScore});
      return sendAnswer.docs.first.id;
    } else {
      var ansData = Ans(
          studentToken: studentProfile.token,
          packageId: int.parse(Global.storageService.getPackageId()),
          subjectId: topicItem!.subjectId,
          levelId: levelItem.id,
          name: studentProfile.name,
          avatar: studentProfile.avatar,
          topicId: levelItem.topic_id,
          starScore: starScore,
          totalScore: totalScore);
      //Add answer into firestore and get docId for answer
      var docId = await db
          .collection("answer")
          .withConverter(
              fromFirestore: Ans.fromFirestore,
              toFirestore: (Ans ans, options) => ans.toFirestore())
          .add(ansData);

      return docId.id;
    }
  }

  static Future<bool> sendAnswer(
      int questionId, int itemId, int isAnswer, String docId) async {
    if (docId == "") {}
    var db = FirebaseFirestore.instance;
    final content = Answercontent(
      questionId: questionId,
      itemId: itemId,
      isAnswer: isAnswer,
    );

    // Step 1: Check if the document already exists in the "answerlist" subcollection
    QuerySnapshot querySnapshot = await db
        .collection("answer")
        .doc(docId)
        .collection("answerlist")
        .where("question_id", isEqualTo: content.questionId)
        .get();

    // Step 2: Determine whether to add a new document or update an existing one
    if (querySnapshot.docs.isEmpty) {
      // If the document doesn't exist, add a new one
      await db
          .collection("answer")
          .doc(docId)
          .collection("answerlist")
          .withConverter(
              fromFirestore: Answercontent.fromFirestore,
              toFirestore: (Answercontent ans, options) => ans.toFirestore())
          .add(content);
      return true;
    } else {
      // print("testtttt answerrrr else");
      // If the document already exists, update it (you can update all matching documents if needed)
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.update({
          "item_id": content.itemId,
          "is_answer": content.isAnswer,
        });
      }
      return false;
    }
  }

  static Future<List<Ans>> getLevelStar({int? topicId}) async {
    List<Ans> answerList = [];

    try {
      final data = await FirebaseFirestore.instance
          .collection("answer")
          .where("student_token",
              isEqualTo: Global.storageService.getStudentProfile().token)
          .where("topic_id", isEqualTo: topicId)
          .get();

      // print(querySnapshot.docs.first.id);
      // Step 2: Determine whether to add a new document or update an existing one
      if (data.docs.isNotEmpty) {
        for (var answer in data.docs) {
          answerList.add(Ans.fromMap(answer.data()));
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }

    return answerList;
  }

  static Future<List<Ans>> getAllLevelStarScore({int? subjectId}) async {
    List<Ans> answerList = [];

    try {
      final data = await FirebaseFirestore.instance
          .collection("answer")
          .where("student_token",
              isEqualTo: Global.storageService.getStudentProfile().token)
          .where("subject_id", isEqualTo: subjectId)
          .get();

      // print(querySnapshot.docs.first.id);
      // Step 2: Determine whether to add a new document or update an existing one
      if (data.docs.isNotEmpty) {
        for (var answer in data.docs) {
          answerList.add(Ans.fromMap(answer.data()));
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }

    return answerList;
  }

  static Future<List<Ans>> getLevelStarScoreBySubject({int? packageId}) async {
    List<Ans> answerList = [];

    try {
      final data = await FirebaseFirestore.instance
          .collection("answer")
          .where("student_token",
              isEqualTo: Global.storageService.getStudentProfile().token)
          .where("package_id", isEqualTo: packageId)
          .get();

      // print(querySnapshot.docs.first.id);
      // Step 2: Determine whether to add a new document or update an existing one
      if (data.docs.isNotEmpty) {
        for (var answer in data.docs) {
          answerList.add(Ans.fromMap(answer.data()));
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }

    return answerList;
  }
}
