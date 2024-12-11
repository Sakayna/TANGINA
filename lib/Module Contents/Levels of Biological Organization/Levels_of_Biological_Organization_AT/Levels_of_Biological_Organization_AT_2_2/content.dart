import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:capstone/Module%20Contents/Levels%20of%20Biological%20Organization/Levels_of_Biological_Organization_AT/Levels_of_Biological_Organization_AT_2_2/score.dart';

class LevelsOfOrganizationDragDrop extends StatefulWidget {
  @override
  _LevelsOfOrganizationDragDropState createState() =>
      _LevelsOfOrganizationDragDropState();
}

class _LevelsOfOrganizationDragDropState
    extends State<LevelsOfOrganizationDragDrop> {
  final List<String> levels = [
    'Biosphere',
    'Ecosystem',
    'Community',
    'Population',
    'Organism',
    'Organ System',
    'Organ',
    'Tissue',
    'Cell',
  ];

  final List<String> questions = [
    'What encompasses all ecosystems on Earth?',
    'What is a community plus its physical environment?',
    'What is a group of different populations living together?',
    'What is a group of organisms of the same species?',
    'What is an individual living thing?',
    'What is a group of organs working together?',
    'What is a part of the body that performs a specific function?',
    'What is made up of cells working together?',
    'What is the smallest unit of life?',
  ];

  List<String> targetOrder = List<String>.filled(9, '');
  List<String> remainingItems = [];

  @override
  void initState() {
    super.initState();
    remainingItems = List.from(levels);
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

  void submitOrder() {
    int score = 0;
    for (int i = 0; i < targetOrder.length; i++) {
      if (targetOrder[i] == levels[i]) {
        score++;
      }
    }

    bool passed = score >= 6; // Example passing score (6 out of 9)

    // Update global variables for progress tracking
    var globalVariables = Provider.of<GlobalVariables>(context, listen: false);
    globalVariables.setQuizTaken('lesson2', 'quiz1', true);
    globalVariables.unlockNextLesson('lesson2');
    globalVariables.incrementQuizTakeCount('lesson2_quiz1');
    globalVariables.updateGlobalRemarks('lesson2_quiz1', score, levels.length);
    globalVariables.setGlobalScore('lesson2_quiz1', score);
    globalVariables.setQuizItemCount('lesson2_quiz1', levels.length);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScorePage(
          score: score,
          passed: passed,
          questions: questions,
          userAnswers: targetOrder,
          correctAnswers: levels,
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
            'Lesson 2 Quiz 1',
            style: TextStyle(color: Colors.white), // Set text color to white
          ),
          backgroundColor: Color(0xFF9463FF),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
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
                SizedBox(height: 20),
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
                        'Drag the levels below and arrange them in the correct order.',
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
                          childAspectRatio: 2.5,
                        ),
                        itemBuilder: (context, index) {
                          return Draggable<String>(
                            data: remainingItems[index],
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Color(0xFF9463FF),
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
                                  color: Color(0xFF9463FF),
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
                            ),
                            childWhenDragging: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
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
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.center,
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
                Column(
                  children: List.generate(targetOrder.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Container(
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
                              questions[index],
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(height: 12),
                            DragTarget<String>(
                              onAccept: (receivedItem) {
                                setState(() {
                                  targetOrder[index] = receivedItem;
                                });
                              },
                              builder: (context, acceptedItems, rejectedItems) {
                                return GestureDetector(
                                  onTap: () {
                                    if (targetOrder[index].isNotEmpty) {
                                      returnItemToOriginalPosition(
                                          targetOrder[index]);
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF9463FF),
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
                                        targetOrder[index],
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: submitOrder,
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9463FF),
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
