import 'package:flutter/material.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1/Ecosystem_AT_6_1.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1/item.dart';

class Ecosystem_AT_6_1_Results extends StatelessWidget {
  final List<QuizItem> quizItems;
  final Map<int, List<String>> userSelectedChoices;
  final int userScore;
  final int totalQuestions;

  Ecosystem_AT_6_1_Results({
    required this.quizItems,
    required this.userSelectedChoices,
    required this.userScore,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Ecosystem_AT_6_1(),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Lesson 6 Quiz 1 Results',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          backgroundColor: const Color(0xFFA846A0),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Ecosystem_AT_6_1(),
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
                'Overall Score: $userScore / $totalQuestions',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              // List of Questions and Answers
              Expanded(
                child: ListView.builder(
                  itemCount: totalQuestions,
                  itemBuilder: (context, index) {
                    final userAnswers = userSelectedChoices[index];
                    final isCorrect = userAnswers != null &&
                        userAnswers.isNotEmpty &&
                        userAnswers.first == quizItems[index].correctAnswer;

                    final pointsText = isCorrect ? '1/1 point' : '0/1 point';
                    final selectedChoices = userAnswers ?? [];

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
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              pointsText,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Display Question
                          Text(
                            quizItems[index].question,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Display Image
                          if (quizItems[index].imagePath.isNotEmpty)
                            Image.asset(
                              quizItems[index].imagePath,
                              fit: BoxFit.cover,
                            ),
                          const SizedBox(height: 8),
                          // Display Choices
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: quizItems[index].choices.map((choice) {
                              final isSelected = userAnswers != null &&
                                  userAnswers.contains(choice);
                              final isCorrectChoice =
                                  choice == quizItems[index].correctAnswer;

                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? (isCorrectChoice
                                          ? Colors.green[50]
                                          : Colors.red[50])
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: isSelected
                                        ? (isCorrectChoice
                                            ? Colors.green
                                            : Colors.red)
                                        : Colors.grey,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isCorrectChoice
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      color: isCorrectChoice
                                          ? Colors.green
                                          : Colors.red,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        choice,
                                        style: TextStyle(
                                          color: isSelected
                                              ? (isCorrectChoice
                                                  ? Colors.green
                                                  : Colors.red)
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          if (!isCorrect)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Correct Answer: ${quizItems[index].correctAnswer}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
