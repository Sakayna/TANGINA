import 'package:capstone/Module%20Contents/Microscopy/Microscopy_AT/Microscopy_AT_1_2/Microscopy_AT_1_2.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_AT/Microscopy_AT_1_2/score.dart';
import 'package:flutter/material.dart';
import 'item.dart' as quizItemsFile;

class Microscopy_AT_Quiz_2_Results extends StatelessWidget {
  final List<quizItemsFile.QuizItemContent> quizItems;
  final Map<int, String> userAnswers;

  Microscopy_AT_Quiz_2_Results({
    required this.quizItems,
    required this.userAnswers,
  });

  String toCamelCase(String text) {
    return text[0].toLowerCase() + text.substring(1);
  }

  bool isAnswerCorrect(int questionIndex, String userAnswer) {
    var correctAnswers = quizItems[questionIndex]
        .answer
        .split(RegExp(',|or|and'))
        .map((s) => s.trim())
        .toList();
    return correctAnswers.contains(userAnswer.toLowerCase()) ||
        correctAnswers.contains(userAnswer.toUpperCase()) ||
        correctAnswers.contains(userAnswer) ||
        correctAnswers.contains(toCamelCase(userAnswer));
  }

  int calculateScore() {
    int score = 0;
    userAnswers.forEach((questionIndex, userAnswer) {
      if (isAnswerCorrect(questionIndex, userAnswer)) {
        score++;
      }
    });
    return score;
  }

  @override
  Widget build(BuildContext context) {
    int totalQuestions = quizItems.length;
    int correctAnswers = calculateScore();

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Microscopy_AT_Quiz_2_Score(
              totalQuestions: totalQuestions,
              correctAnswers: correctAnswers,
              quizItems: quizItems,
              userAnswers: userAnswers,
            ),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(
              0xFFFFA551), // Match color from `Microscopy_AT_Quiz_2_Score`
          elevation: 4, // Add shadow for depth
          title: Text(
            'Lesson 1 Quiz 1 Results',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Microscopy_AT_1_2(),
                ),
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Overall Score: $correctAnswers / $totalQuestions',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: totalQuestions,
                  itemBuilder: (context, index) {
                    final userAnswer = userAnswers[index] ?? "No answer";
                    final correctAnswer = quizItems[index].answer;
                    final isCorrect = isAnswerCorrect(index, userAnswer);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.01),
                            spreadRadius: 0.01,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quizItems[index].question,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Your Answer: $userAnswer',
                            style: TextStyle(
                              color: isCorrect ? Colors.green : Colors.red,
                            ),
                          ),
                          if (!isCorrect)
                            Text(
                              'Correct Answer: $correctAnswer',
                              style: TextStyle(color: Colors.green),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
