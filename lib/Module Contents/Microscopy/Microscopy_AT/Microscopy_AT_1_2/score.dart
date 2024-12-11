import 'package:capstone/Module%20Contents/Microscopy/Microscopy_AT/Microscopy_AT_1_2/Microscopy_AT_1_2.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_AT/Microscopy_AT_1_2/result.dart';
import 'package:capstone/categories/microscopy_screen.dart';
import 'package:flutter/material.dart';
import 'item.dart' as quizItemsFile;

import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class Microscopy_AT_Quiz_2_Score extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final List<quizItemsFile.QuizItemContent> quizItems;
  final Map<int, String> userAnswers;

  Microscopy_AT_Quiz_2_Score({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.quizItems,
    required this.userAnswers,
  });

  String toCamelCase(String text) {
    return text[0].toLowerCase() + text.substring(1);
  }

  int calculateCorrectAnswers() {
    int correctCount = 0;
    userAnswers.forEach((questionIndex, userAnswer) {
      var correctAnswers = quizItems[questionIndex]
          .answer
          .split(RegExp(',|or|and'))
          .map((s) => s.trim())
          .toList();
      if (correctAnswers.contains(userAnswer.toLowerCase()) ||
          correctAnswers.contains(userAnswer.toUpperCase()) ||
          correctAnswers.contains(userAnswer) ||
          correctAnswers.contains(toCamelCase(userAnswer))) {
        correctCount++;
      }
    });
    return correctCount;
  }

  @override
  Widget build(BuildContext context) {
    int finalCorrectAnswers = calculateCorrectAnswers();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final globalVariables =
          Provider.of<GlobalVariables>(context, listen: false);
      globalVariables.incrementQuizTakeCount('quiz1');
      globalVariables.setGlobalScore('quiz1', finalCorrectAnswers);
      globalVariables.updateGlobalRemarks(
          'quiz1', finalCorrectAnswers, totalQuestions);
      globalVariables.setQuizItemCount('quiz1', totalQuestions);
      globalVariables.printGlobalVariables();
    });

    bool passed = (finalCorrectAnswers / totalQuestions) >= 0.5;

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MicroscopyScreen()),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFFA551), // Solid background color
          elevation: 4, // Adds shadow for depth
          title: Text(
                'Lesson 1 Quiz 1 Score',
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
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Microscopy_AT_1_2(),
              ));
            },
          ),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
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
                  'Score: $finalCorrectAnswers/$totalQuestions',
                  style: TextStyle(
                    fontSize: 36,
                    color: passed ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'You ${passed ? 'passed' : 'failed'} the quiz!',
                  style: TextStyle(
                    fontSize: 24,
                    color: passed ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFA551),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Microscopy_AT_Quiz_2_Results(
                          quizItems: quizItems,
                          userAnswers: userAnswers,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Check Results',
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
      ),
    );
  }
}
