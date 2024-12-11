import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/AT1/Animal_and_Plant_Cells_AT_3_1.dart';
import 'package:flutter/material.dart';

class Plant_Animal_ResultsPage extends StatelessWidget {
  final Map<String, List<String>> userAnswers;
  final Map<String, List<String>> correctAnswers;

  const Plant_Animal_ResultsPage({
    Key? key,
    required this.userAnswers,
    required this.correctAnswers,
  }) : super(key: key);

  int calculateOverallScore() {
    int score = 0;
    userAnswers.forEach((key, answers) {
      for (var answer in answers) {
        if (correctAnswers[key]!.contains(answer)) {
          score++;
        }
      }
    });
    return score;
  }

  @override
  Widget build(BuildContext context) {
    final int overallScore = calculateOverallScore();
    final int totalCorrectAnswers =
        correctAnswers.values.fold(0, (sum, answers) => sum + answers.length);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA1C084),
        elevation: 4,
        title: Text(
          'Lesson 3 Quiz 1 Results',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall Score Section
            Text(
              'Overall Score: $overallScore / $totalCorrectAnswers',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            // Results Section
            Expanded(
              child: ListView(
                children: [
                  buildResultSection('Plant Only', userAnswers['Plant Only']!,
                      correctAnswers['Plant Only']!),
                  const SizedBox(height: 20),
                  buildResultSection(
                      'Both', userAnswers['Both']!, correctAnswers['Both']!),
                  const SizedBox(height: 20),
                  buildResultSection('Animal Only', userAnswers['Animal Only']!,
                      correctAnswers['Animal Only']!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResultSection(
      String title, List<String> userAnswers, List<String> correctAnswers) {
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
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Your Answers:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          for (var answer in userAnswers)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 16,
                  color: correctAnswers.contains(answer)
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ),
          const SizedBox(height: 10),
          const Text(
            'Correct Answers:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          for (var answer in correctAnswers)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                answer,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
