class Question {
  final String questionText;
  final List<String> options;
  final int correctIndex;
  final String chapter;

  Question({
    required this.questionText,
    required this.options,
    required this.correctIndex,
    required this.chapter,
  });
}
