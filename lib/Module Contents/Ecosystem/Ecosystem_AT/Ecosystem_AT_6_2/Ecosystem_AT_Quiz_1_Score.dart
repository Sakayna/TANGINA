import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_2/Ecosystem_AT_6_2.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_2/Ecosystem_AT_Quiz_1_Content.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_2/Ecosystem_AT_Quiz_1_Results.dart';
import 'package:capstone/categories/ecosystem.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_2/Ecosystem_AT_Quiz_1_Items.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class Ecosystem_AT_Quiz_3_Score extends StatelessWidget {
  final List<QuizItem> quizItems;
  final Map<int, List<String>> userSelectedChoices;
  final int userScore;
  final int totalQuestions;

  Ecosystem_AT_Quiz_3_Score({
    required this.quizItems,
    required this.userSelectedChoices,
    required this.userScore,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      const lessonId = 'lesson6';
      const quizId = 'quiz4';

      final globalVariables =
          Provider.of<GlobalVariables>(context, listen: false);
      globalVariables.incrementQuizTakeCount(lessonId, quizId);
      globalVariables.setGlobalScore(lessonId, quizId, userScore);
      globalVariables.updateGlobalRemarks(
          lessonId, quizId, userScore, totalQuestions);
      globalVariables.setQuizItemCount(lessonId, quizId, totalQuestions);
      globalVariables.printGlobalVariables();
    });

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Ecosystem_AT_Quiz_3_Results(
              quizItems: quizItems,
              userSelectedChoices: userSelectedChoices,
              userScore: userScore,
              totalQuestions: totalQuestions,
            ),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFA846A0), // Retain the original color
          elevation: 4, // Adds shadow for depth
          title: Text(
            'Lesson 6 Quiz 4 Score',
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
                  builder: (context) => Ecosystem_AT_6_2(),
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
                userScore >= 7
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
                  'Your Score: $userScore / $totalQuestions',
                  style: TextStyle(
                    fontSize: 30,
                    color: userScore >= 7 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'You ${userScore >= 7 ? 'passed' : 'failed'} the quiz!',
                  style: TextStyle(
                    fontSize: 24,
                    color: userScore >= 7 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Ecosystem_AT_Quiz_3_Results(
                          quizItems: quizItems,
                          userSelectedChoices: userSelectedChoices,
                          userScore: userScore,
                          totalQuestions: totalQuestions,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFA846A0),
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
      ),
    );
  }
}
