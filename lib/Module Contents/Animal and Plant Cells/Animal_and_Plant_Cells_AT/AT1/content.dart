import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/AT1/score.dart';

class AnimalAndPlant extends StatefulWidget {
  @override
  _AnimalAndPlantState createState() => _AnimalAndPlantState();
}

class _AnimalAndPlantState extends State<AnimalAndPlant> {
  final List<String> questions = [
    "Which organelles are found only in plant cells?",
    "Which organelles are found in both plant and animal cells?",
    "Which organelles are found only in animal cells?",
  ];

  final List<List<String>> correctAnswers = [
    ["Cell Wall", "Chloroplast"], // Plant Only
    [
      "Cell Membrane",
      "Ribosomes",
      "Nucleus",
      "Endoplasmic Reticulum",
      "Golgi apparatus",
      "Lysosomes",
      "Vacuole",
      "Mitochondria",
      "Cytoplasm"
    ], // Both
    ["Centrioles"], // Animal Only
  ];

  final List<List<String>> userAnswers = [[], [], []];

  final List<String> allItems = [
    "Mitochondria",
    "Chloroplast",
    "Cell Wall",
    "Cell Membrane",
    "Nucleus",
    "Ribosomes",
    "Vacuole",
    "Lysosomes",
    "Centrioles",
    "Endoplasmic Reticulum",
    "Golgi apparatus",
    "Cytoplasm",
  ];

  int currentQuestionIndex = 0;
  List<String> remainingItems = [];

  @override
  void initState() {
    super.initState();
    remainingItems = List.from(allItems);
  }

  void submitAnswers() {
    int score = 0;

    for (int i = 0; i < userAnswers.length; i++) {
      score += userAnswers[i]
          .where((answer) => correctAnswers[i].contains(answer))
          .length;
    }

    bool passed = score >= 8;

    var globalVariables = Provider.of<GlobalVariables>(context, listen: false);
    globalVariables.setQuizTaken('lesson3', 'quiz1', true);
    globalVariables.incrementQuizTakeCount('lesson3_quiz1');
    globalVariables.updateGlobalRemarks(
        'lesson3_quiz1', score, allItems.length);
    globalVariables.setGlobalScore('lesson3_quiz1', score);
    globalVariables.setQuizItemCount('lesson3_quiz1', allItems.length);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Plant_Animal_ScorePage(
          score: score,
          passed: passed,
          userAnswers: {
            "Plant Only": userAnswers[0],
            "Both": userAnswers[1],
            "Animal Only": userAnswers[2],
          },
          correctAnswers: {
            "Plant Only": correctAnswers[0],
            "Both": correctAnswers[1],
            "Animal Only": correctAnswers[2],
          },
        ),
      ),
    );
  }

  void nextQuestion() {
    if (userAnswers[currentQuestionIndex].isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Answer is required to proceed.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void returnItem(String item) {
    setState(() {
      userAnswers[currentQuestionIndex].remove(item);
      remainingItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lesson 3 Quiz 1',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFFA1C084),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (currentQuestionIndex == 0 &&
                userAnswers.every((q) => q.isEmpty)) {
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
                width: double.infinity,
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
                      'Drag the items below to the appropriate circle.',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: remainingItems.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.8,
                      ),
                      itemBuilder: (context, index) {
                        return Draggable<String>(
                          data: remainingItems[index],
                          child: buildDraggableContainer(
                            remainingItems[index],
                            Colors.white,
                          ),
                          feedback: Material(
                            child: buildDraggableContainer(
                              remainingItems[index],
                              Colors.grey[200]!,
                            ),
                          ),
                          childWhenDragging: buildDraggableContainer(
                            remainingItems[index],
                            Colors.grey[300]!,
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
              Text(
                questions[currentQuestionIndex],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              DragTarget<String>(
                onAccept: (item) {
                  setState(() {
                    userAnswers[currentQuestionIndex].add(item);
                  });
                },
                builder: (context, acceptedItems, rejectedItems) {
                  return CircleAvatar(
                    radius: 100,
                    backgroundColor: getCircleColor(currentQuestionIndex),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Drop items here:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        ...userAnswers[currentQuestionIndex].map((item) {
                          return GestureDetector(
                            onTap: () => returnItem(item),
                            child: Text(
                              item,
                              style: TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: currentQuestionIndex == questions.length - 1
                        ? submitAnswers
                        : nextQuestion,
                    child: Text(
                      currentQuestionIndex == questions.length - 1
                          ? 'Submit'
                          : 'Next',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFA1C084),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDraggableContainer(String text, Color color) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
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
          text,
          style: TextStyle(fontSize: 12, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Color getCircleColor(int index) {
    switch (index) {
      case 0:
        return Colors.green.withOpacity(0.3);
      case 1:
        return Colors.pink.withOpacity(0.3);
      case 2:
        return Colors.blue.withOpacity(0.3);
      default:
        return Colors.grey.withOpacity(0.3);
    }
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
}
