import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1_2/Ecosystem_AT_6_1_2.dart';
import 'package:flutter/material.dart';

class Ecosystem_AT_Quiz_1_Results extends StatelessWidget {
  final List<Map<String, String>> questions;
  final List<String?> selectedPredators;
  final List<String?> selectedPreys;

  Ecosystem_AT_Quiz_1_Results({
    required this.questions,
    required this.selectedPredators,
    required this.selectedPreys,
  });

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedPredators[i] == questions[i]['predator'] &&
          selectedPreys[i] == questions[i]['prey']) {
        score++;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    int totalQuestions = questions.length;
    int userScore = calculateScore();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA846A0),
        elevation: 4,
        title: Text(
          'Lesson 6 Quiz 2 Results',
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
                builder: (context) => Ecosystem_AT_6_1_2(),
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
            // Overall Score Section
            Text(
              'Overall Score: $userScore/ $totalQuestions',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            // List of questions and answers
            // Questions and Answers
            Expanded(
              child: ListView.builder(
                itemCount: totalQuestions,
                itemBuilder: (context, index) {
                  bool isPredatorCorrect =
                      selectedPredators[index] == questions[index]['predator'];
                  bool isPreyCorrect =
                      selectedPreys[index] == questions[index]['prey'];

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
                          questions[index]['question']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your Predator: ${selectedPredators[index] ?? "Not Answered"}',
                          style: TextStyle(
                            color:
                                isPredatorCorrect ? Colors.green : Colors.red,
                          ),
                        ),
                        Text(
                          'Your Prey: ${selectedPreys[index] ?? "Not Answered"}',
                          style: TextStyle(
                            color: isPreyCorrect ? Colors.green : Colors.red,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (!isPredatorCorrect || !isPreyCorrect)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isPredatorCorrect)
                                Text(
                                  'Correct Predator: ${questions[index]['predator']}',
                                  style: const TextStyle(color: Colors.green),
                                ),
                              if (!isPreyCorrect)
                                Text(
                                  'Correct Prey: ${questions[index]['prey']}',
                                  style: const TextStyle(color: Colors.green),
                                ),
                            ],
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
    );
  }
}
