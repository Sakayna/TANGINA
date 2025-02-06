import 'package:capstone/Module%20Contents/Levels%20of%20Biological%20Organization/Levels_of_Biological_Organization_AT/Levels_of_Biological_Organization_AT_2_2/Levels_of_Biological_Organization_AT_2_2.dart';
import 'package:capstone/Module%20Contents/Levels%20of%20Biological%20Organization/Levels_of_Biological_Organization_Topics/Levels_of_Biological_Organization_Topic_2_1..dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class ResultsPage extends StatelessWidget {
  final List<String> questions;
  final List<String> userAnswers;
  final List<String> correctAnswers;

  const ResultsPage({
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
      const lessonId = 'lesson2';
      const quizId = 'quiz1';

      // Ensure the quiz is only incremented once
      if (!globalVariables.getQuizTaken(lessonId, quizId)) {
        globalVariables.setGlobalScore(lessonId, quizId, correctAnswersCount);
        globalVariables.setQuizItemCount(lessonId, quizId, totalQuestions);
        globalVariables.updateGlobalRemarks(
            lessonId, quizId, correctAnswersCount, totalQuestions);
        globalVariables.incrementQuizTakeCount(lessonId, quizId);
        globalVariables.setQuizTaken(lessonId, quizId, true);

        // Unlock the next lesson only if the quiz is passed
        if (globalVariables.hasPassedQuiz(lessonId, quizId)) {
          globalVariables.unlockNextLesson(lessonId);
        }

        // Debug logs for easier tracking
        debugPrint('Updated progress for $lessonId $quizId:');
        globalVariables.printGlobalVariables();
      } else {
        debugPrint('Quiz $lessonId $quizId already taken. Skipping increment.');
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9463FF),
        elevation: 4,
        title: Text(
          'Lesson 2 Quiz 1 Results',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Biological_Organization_AT_2_2(),
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
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your Answer: ${userAnswers[index]}',
                          style: TextStyle(
                            color: isCorrect ? Colors.green : Colors.red,
                          ),
                        ),
                        if (!isCorrect) ...[
                          Text(
                            'Correct Answer: ${correctAnswers[index]}',
                            style: const TextStyle(color: Colors.green),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Biological_Organization_Topic_2_1(),
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
