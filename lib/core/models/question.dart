class QuestionRequestEntity {
  int? id;

  QuestionRequestEntity({
    this.id,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class QuestionListResponseEntity {
  int? code;
  String? msg;
  List<Question>? data;

  QuestionListResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory QuestionListResponseEntity.fromJson(Map<String, dynamic> json) =>
      QuestionListResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<Question>.from(
                json["data"].map((x) => Question.fromJson(x))),
      );
}

//api post response msg
class QuestionDetailResponseEntity {
  int? code;
  String? msg;
  Question? data;

  QuestionDetailResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory QuestionDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      QuestionDetailResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: Question.fromJson(json["data"]),
      );
}

// question result
class Question {
  int? id;
  int? level_id;
  int? text_id;
  String? text_bm;
  String? soalan_bm;
  String? soalan_eng;
  String? imageUrl;
  List<QuestionItem>? questionItems;

  Question({
    this.id,
    this.level_id,
    this.text_id,
    this.text_bm,
    this.soalan_bm,
    this.soalan_eng,
    this.imageUrl,
    this.questionItems,
  });

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level_id = json['level_id'];
    text_id = json['text_id'];
    text_bm = json['text_bm'];
    soalan_bm = json['soalan_bm'];
    soalan_eng = json['soalan_eng'];
    imageUrl = json['image_url'];

    if (json['questionItems'] != null) {
      questionItems = <QuestionItem>[];
      json['questionItems'].forEach((v) {
        questionItems!.add(QuestionItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['soalan_bm'] = soalan_bm;
    data['soalan_eng'] = soalan_eng;
    if (questionItems != null) {
      data['questionItems'] = questionItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionItem {
  int? id;
  int? question_id;
  String? answer;
  int? is_answer;

  QuestionItem({
    this.id,
    this.question_id,
    this.answer,
    this.is_answer,
  });

  factory QuestionItem.fromJson(Map<String, dynamic> json) => QuestionItem(
        id: json["item_id"],
        question_id: int.parse(json["question_id"]),
        answer: json["answer"],
        is_answer: int.parse(json["is_answer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question_id": question_id,
        "answer": answer,
        "is_answer": is_answer,
      };
}

// class Answer {
//   final String answerText;
//   final bool isCorrect;

//   Answer(this.answerText, this.isCorrect);
// }
