class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions() {
  List<Question> list = [];

  //Questions and answer here

  list.add(Question(
    "Who is the owner of Flutter?",
    [
      Answer('Nokia', false),
      Answer('Samsung', false),
      Answer('Google', true),
      Answer('Apple', false),
    ],
  ));

  list.add(Question(
    "Who owns Iphone?",
    [
      Answer('Apple', true),
      Answer('Microsoft', false),
      Answer('Google', false),
      Answer('Nokia', false),
    ],
  ));

  list.add(Question(
    "Youtube is ________ platform?",
    [
      Answer('Music Sharing', false),
      Answer('Video Sharing', false),
      Answer('Live Streaming', true),
      Answer('All of the above', true),
    ],
  ));

  list.add(Question(
    "Flutter use dart as a programming language?",
    [
      Answer('True', true),
      Answer('False', false),
    ],
  ));

  return list;
}
