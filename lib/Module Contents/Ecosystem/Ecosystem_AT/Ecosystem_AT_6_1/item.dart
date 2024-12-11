// lib/Module Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1/Ecosystem_AT_6_1_Item.dart

class QuizItem {
  final String question;
  final List<String> choices;
  final String correctAnswer;
  final String imagePath;

  QuizItem({
    required this.question,
    required this.choices,
    required this.correctAnswer,
    required this.imagePath,
  });
}
