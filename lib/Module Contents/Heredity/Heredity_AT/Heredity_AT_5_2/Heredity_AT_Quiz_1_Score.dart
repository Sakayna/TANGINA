import 'package:capstone/Module%20Contents/Heredity/Heredity_AT/Heredity_AT_5_2/Heredity_AT_5_2.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_AT/Heredity_AT_5_2/Heredity_AT_Quiz_1_Results.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class Heredity_AT_5_1_2_Score extends StatelessWidget {
  final int score;
  final bool passed;
  final List<String> stages;
  final List<String> userAnswers;

  const Heredity_AT_5_1_2_Score({
    Key? key,
    required this.score,
    required this.passed,
    required this.stages,
    required this.userAnswers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final globalVariables =
          Provider.of<GlobalVariables>(context, listen: false);
      globalVariables.incrementQuizTakeCount('quiz8');
      globalVariables.setGlobalScore('quiz8', score);
      globalVariables.updateGlobalRemarks('quiz8', score, stages.length);
      globalVariables.setQuizItemCount('quiz8', stages.length);
      globalVariables.printGlobalVariables();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF64B6AC), // Retain original color
        elevation: 4, // Adds shadow for depth
        title: Text(
          'Lesson 5 Quiz 2 Score',
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
                builder: (context) => Heredity_AT_5_2(),
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
                'Score: $score / ${stages.length}',
                style: TextStyle(
                  fontSize: 36,
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
                      builder: (context) => Heredity_AT_5_1_2_Results(
                        stages: stages,
                        userAnswers: userAnswers,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF64B6AC),
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
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
    );
  }
}
