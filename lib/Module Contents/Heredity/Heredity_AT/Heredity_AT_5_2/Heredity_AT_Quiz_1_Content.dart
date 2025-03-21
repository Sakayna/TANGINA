import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_AT/Heredity_AT_5_2/Heredity_AT_Quiz_1_Score.dart';

class Heredity_AT_Quiz_2_Content extends StatefulWidget {
  @override
  _Heredity_AT_Quiz_2_ContentState createState() =>
      _Heredity_AT_Quiz_2_ContentState();
}

class _Heredity_AT_Quiz_2_ContentState
    extends State<Heredity_AT_Quiz_2_Content> {
  final List<String> stages = [
    'Ovulation',
    'Intercourse',
    'Fertilization',
    'Zygote Formation',
    'Blastocyst Formation',
    'Implantation',
    'Early Development',
  ];

  final List<String> descriptions = [
    'An egg is released from the ovary and enters the fallopian tube. This usually occurs around the middle of the menstrual cycle.',
    'During sexual intercourse, sperm is ejaculated into the vagina and travels through the cervix and uterus towards the fallopian tube.',
    'One sperm successfully penetrates the egg’s outer layer in the fallopian tube. The sperm’s nucleus merges with the egg’s nucleus, forming a zygote.',
    'The fertilized egg, now called a zygote, begins to divide as it moves towards the uterus.',
    'The zygote develops into a blastocyst, a structure with an inner cell mass that will become the embryo and an outer layer that will form the placenta.',
    'The blastocyst implants itself into the lining of the uterus, where it continues to develop into an embryo.',
    'The embryo undergoes further development and differentiation, eventually forming the major organs and systems of the body.',
  ];

  List<String> targetOrder = List<String>.filled(7, '');
  List<String> remainingItems = [];
  int currentQuestionIndex = 0;
  bool isAnswerEmpty = true;

  @override
  void initState() {
    super.initState();
    remainingItems = List.from(stages);
  }

  void showWarningDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('You cannot go back after starting the quiz.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> handleWillPop() async {
    if (targetOrder.every((element) => element.isEmpty)) {
      showWarningDialog();
      return false; // Prevents going back
    }
    return false; // Always prevent going back
  }

  void goToNextQuestion() {
    if (targetOrder[currentQuestionIndex].isEmpty) {
      setState(() {
        isAnswerEmpty = true;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Answer is required'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        currentQuestionIndex++;
        isAnswerEmpty = false;
      });
    }
  }

  void submitOrder() {
    int score = 0;
    for (int i = 0; i < targetOrder.length; i++) {
      if (targetOrder[i] == stages[i]) {
        score++;
      }
    }

    bool passed = score >= 5;

    var globalVariables = Provider.of<GlobalVariables>(context, listen: false);
    const lessonId = 'lesson5';
    const quizId = 'quiz2';

    globalVariables.setQuizTaken(lessonId, quizId, true);
    globalVariables.incrementQuizTakeCount(lessonId, quizId);
    globalVariables.updateGlobalRemarks(lessonId, quizId, score, stages.length);
    globalVariables.setGlobalScore(lessonId, quizId, score);
    globalVariables.setQuizItemCount(lessonId, quizId, stages.length);

    if (globalVariables.hasPassedQuiz(lessonId, quizId)) {
      globalVariables.unlockNextLesson(lessonId);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Heredity_AT_5_1_2_Score(
          score: score,
          passed: passed,
          stages: stages,
          userAnswers: targetOrder,
        ),
      ),
    );
  }

  void returnItemToOriginalPosition(String item) {
    setState(() {
      int index = targetOrder.indexOf(item);
      if (index != -1) {
        targetOrder[index] = '';
        remainingItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Lesson 5 Quiz 2',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF64B6AC),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              if (targetOrder.every((element) => element.isEmpty)) {
                showWarningDialog();
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
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
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(
                            'Instructions',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Drag the stages below and arrange them in the correct sequence of fertilization.',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 20),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: remainingItems.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2.5,
                        ),
                        itemBuilder: (context, index) {
                          return Draggable<String>(
                            data: remainingItems[index],
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Color(0xFF64B6AC),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.01),
                                    spreadRadius: 0.01,
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  remainingItems[index],
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            feedback: Material(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFF64B6AC),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    remainingItems[index],
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            childWhenDragging: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(
                                  remainingItems[index],
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ),
                            onDragCompleted: () {
                              setState(() {
                                remainingItems.removeAt(index);
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
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
                        descriptions[currentQuestionIndex],
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 12),
                      DragTarget<String>(
                        onAccept: (receivedItem) {
                          setState(() {
                            targetOrder[currentQuestionIndex] = receivedItem;
                            isAnswerEmpty = false;
                          });
                        },
                        builder: (context, acceptedItems, rejectedItems) {
                          return GestureDetector(
                            onTap: () {
                              if (targetOrder[currentQuestionIndex]
                                  .isNotEmpty) {
                                returnItemToOriginalPosition(
                                    targetOrder[currentQuestionIndex]);
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: targetOrder[currentQuestionIndex].isEmpty
                                    ? Colors.grey[200]
                                    : Color(0xFF64B6AC),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(
                                  targetOrder[currentQuestionIndex],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: targetOrder[currentQuestionIndex]
                                            .isEmpty
                                        ? Colors.grey
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (currentQuestionIndex < stages.length - 1)
                      ElevatedButton(
                        onPressed: goToNextQuestion,
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF64B6AC),
                        ),
                      ),
                    if (currentQuestionIndex == stages.length - 1)
                      ElevatedButton(
                        onPressed: submitOrder,
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF64B6AC),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
