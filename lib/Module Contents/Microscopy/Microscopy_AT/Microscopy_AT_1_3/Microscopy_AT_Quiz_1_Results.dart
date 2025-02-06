import 'package:capstone/Module%20Contents/Microscopy/Microscopy_AT/Microscopy_AT_1_3/Microscopy_AT_1_3.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_Topics/Microscopy_Topic_1_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class Microscopy_AT_Quiz_1_Results extends StatelessWidget {
  final List<String> questions;
  final List<String> userAnswers;
  final List<String> correctAnswers;

  const Microscopy_AT_Quiz_1_Results({
    Key? key,
    required this.questions,
    required this.userAnswers,
    required this.correctAnswers,
  }) : super(key: key);

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < userAnswers.length; i++) {
      if (userAnswers[i] == correctAnswers[i]) {
        score++;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    int correctAnswersCount = calculateScore();
    int totalQuestions = questions.length;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final globalVariables =
          Provider.of<GlobalVariables>(context, listen: false);

      // Specify both lessonId and quizId for all operations
      const lessonId = 'lesson1';
      const quizId = 'quiz2';

      // Store the score and quiz completion data
      globalVariables.setGlobalScore(lessonId, quizId, correctAnswersCount);
      globalVariables.setQuizItemCount(lessonId, quizId, totalQuestions);
      globalVariables.updateGlobalRemarks(
          lessonId, quizId, correctAnswersCount, totalQuestions);
      globalVariables.incrementQuizTakeCount(lessonId, quizId);

      // Unlock Lesson 2 only if both quizzes in Lesson 1 are passed
      if (globalVariables.hasPassedQuiz(lessonId, 'quiz1') &&
          globalVariables.hasPassedQuiz(lessonId, 'quiz2')) {
        globalVariables.unlockNextLesson(lessonId);
      }

      globalVariables.printGlobalVariables(); // Debugging purposes
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFA551), // Consistent AppBar color
        elevation: 4, // Add shadow
        title: Text(
          'Lesson 1 Quiz 2 Results',
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
                builder: (context) => Microscopy_AT_1_3(),
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
              'Overall Score: $correctAnswersCount / $totalQuestions',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  bool isCorrect = userAnswers[index] == correctAnswers[index];

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
                          questions[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Your Answer: ${userAnswers[index]}',
                          style: TextStyle(
                            color: isCorrect ? Colors.green : Colors.red,
                          ),
                        ),
                        if (!isCorrect) ...[
                          Text(
                            'Correct Answer: ${correctAnswers[index]}',
                            style: TextStyle(color: Colors.green),
                          ),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Microscopy_Topic_1_2(),
                                ),
                              );
                            },
                            child: Text(
                              'Click this link to review your wrong answer',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
