import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:capstone/components/graph_card.dart';
import 'package:capstone/components/graph_details_screen.dart';

class LessonRecordAT3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalVariables = Provider.of<GlobalVariables>(context, listen: false);
    final List<Map<String, dynamic>> quizData = [
      {'lesson': 3, 'quiz': 1, 'title': 'Lesson 3 Quiz 1', 'key': 'quiz4'},
      {'lesson': 3, 'quiz': 2, 'title': 'Lesson 3 Quiz 2', 'key': 'quiz5'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson 3 Quizzes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: quizData.length,
          itemBuilder: (context, index) {
            final quiz = quizData[index];
            final itemCount = globalVariables.quizItemCount[quiz['key']] ?? 0;
            final takeCount = globalVariables.quizTakeCount[quiz['key']] ?? 0;
            final remarks = globalVariables.globalRemarks[quiz['key']] ?? [];
            final scores = globalVariables.globalScores[quiz['key']] ?? [0];
            final dateTaken = globalVariables.quizTakenDates[quiz['key']] ?? [];

            bool canTakeQuiz = globalVariables.getQuizTaken(
                'lesson${quiz['lesson']}', 'quiz${quiz['quiz']}');

            if (takeCount > 0) {
              canTakeQuiz = true;
              globalVariables.allowQuiz(
                  'lesson${quiz['lesson']}', 'quiz${quiz['quiz']}');
            }

            return Column(
              children: [
                Opacity(
                  opacity: canTakeQuiz ? 1 : 0.5,
                  child: GestureDetector(
                    onTap: canTakeQuiz
                        ? () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => GraphDetailScreen(
                                  title: quiz['title'],
                                  itemCount: itemCount,
                                  takeCount: takeCount,
                                  remarks: remarks,
                                  scores: scores,
                                  dateTaken: dateTaken,
                                ),
                              ),
                            );
                          }
                        : null,
                    child: Stack(
                      children: [
                        GraphCard(
                          title: quiz['title'],
                          itemCount: itemCount,
                          takeCount: takeCount,
                        ),
                        if (!canTakeQuiz)
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.lock,
                                  color: Colors.white, size: 50.0),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
