import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/AT1/Animal_and_Plant_Cells_AT_3_1.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/AT1/result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class Plant_Animal_ScorePage extends StatelessWidget {
  final int score;
  final bool passed;
  final Map<String, List<String>> userAnswers;
  final Map<String, List<String>> correctAnswers;

  const Plant_Animal_ScorePage({
    Key? key,
    required this.score,
    required this.passed,
    required this.userAnswers,
    required this.correctAnswers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final globalVariables =
          Provider.of<GlobalVariables>(context, listen: false);

      // Consistent with the reference structure
      const lessonId = 'lesson3';
      const quizId = 'quiz1';

      globalVariables.incrementQuizTakeCount(lessonId, quizId);
      globalVariables.setGlobalScore(lessonId, quizId, score);
      globalVariables.updateGlobalRemarks(lessonId, quizId, score, 12);
      globalVariables.setQuizItemCount(lessonId, quizId, 12);

      globalVariables.printGlobalVariables();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA1C084),
        elevation: 4, // Add shadow for depth
        title: Text(
          'Lesson 3 Quiz 1 Score',
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
                builder: (context) => Animal_and_Plant_AT_3_1(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
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
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              passed
                  ? Image.asset(
                      'assets/lesson1&2/congratulation.png',
                      width: 120,
                      height: 120,
                    )
                  : Icon(
                      Icons.cancel_outlined,
                      color: Colors.red,
                      size: 120.0,
                    ),
              SizedBox(height: 20),
              Text(
                'Your Score: $score / 12',
                style: TextStyle(
                  fontSize: 30,
                  color: passed ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'You ${passed ? 'passed' : 'failed'} the quiz!',
                style: TextStyle(
                  fontSize: 24,
                  color: passed ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Plant_Animal_ResultsPage(
                        userAnswers: userAnswers,
                        correctAnswers: correctAnswers,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA1C084),
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'View Results',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
