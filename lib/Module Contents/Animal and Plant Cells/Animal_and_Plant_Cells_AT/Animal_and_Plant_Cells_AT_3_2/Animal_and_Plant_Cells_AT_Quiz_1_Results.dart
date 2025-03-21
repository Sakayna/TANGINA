import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/Animal_and_Plant_Cells_AT_3_2/Animal_and_Plant_Cells_AT_3_2.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/Animal_and_Plant_Cells_AT_3_2/Animal_and_Plant_Cells_AT_Quiz_1_Score.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_Topics/Animal_and_Plant_Topic_3_2.dart';
import 'package:flutter/material.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/Animal_and_Plant_Cells_AT_3_2/Animal_and_Plant_Cells_AT_Quiz_1_Items.dart';

class Animal_and_Plant_AT_3_1_2_Results extends StatelessWidget {
  final List<QuizItem> quizItems;
  final Map<int, List<String>> userSelectedChoices;
  final int userScore;
  final int totalQuestions;

  Animal_and_Plant_AT_3_1_2_Results({
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
            builder: (context) => Animal_and_Plant_AT_3_1_2_Score(
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
          title: Text(
            'Lesson 3 Quiz 2 Results',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFFA1C084),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Animal_and_Plant_AT_3_2(),
                ),
              );
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Overall Score: $userScore / $totalQuestions',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: totalQuestions,
                itemBuilder: (context, index) {
                  final userAnswers = userSelectedChoices[index];
                  final isCorrect = userAnswers != null &&
                      userAnswers.isNotEmpty &&
                      userAnswers.first == quizItems[index].correctAnswer;

                  final pointsText = isCorrect ? '1/1 point' : '0/1 point';

                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
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
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          quizItems[index].question,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: quizItems[index].choices.map((choice) {
                            final isSelected = userAnswers != null &&
                                userAnswers.contains(choice);
                            final isCorrectChoice =
                                choice == quizItems[index].correctAnswer;

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 4.0),
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
                        if (!isCorrect) ...[
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
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Animal_and_Plant_Topic_3_2(),
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
