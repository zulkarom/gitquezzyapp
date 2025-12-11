class ResultData {
  final String subjectName;
  final int totalMarks;
  final int obtainedMarks;
  final String grade;

  ResultData(
    this.subjectName,
    this.totalMarks,
    this.obtainedMarks,
    this.grade,
  );

  static List<ResultData> result = [
    ResultData(
      'English',
      100,
      98,
      'A',
    ),
    ResultData(
      'Computer Science',
      100,
      50,
      'D',
    ),
    ResultData(
      'Physics',
      100,
      89,
      'B',
    ),
  ];
}
