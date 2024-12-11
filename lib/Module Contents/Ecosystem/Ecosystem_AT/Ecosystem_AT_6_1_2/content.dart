import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1_2/results.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1_2/score.dart';
import 'package:capstone/helpers/fisher_yates.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class Ecosystem_AT_Quiz_1_Content extends StatefulWidget {
  @override
  _Ecosystem_AT_Quiz_1_ContentState createState() =>
      _Ecosystem_AT_Quiz_1_ContentState();
}

class _Ecosystem_AT_Quiz_1_ContentState
    extends State<Ecosystem_AT_Quiz_1_Content> {
  final List<Map<String, String>> questions = [
    {
      'question':
          'What is the predator and prey in Snow Leopard and Himalayan Tahr?',
      'predator': 'Snow Leopard',
      'prey': 'Himalayan Tahr (a type of mountain goat)',
    },
    {
      'question':
          'What is the predator and prey in Seal and Orca (Killer Whale)?',
      'predator': 'Orca (Killer Whale)',
      'prey': 'Seal',
    },
    {
      'question':
          'What is the predator and prey in Peregrine Falcon and Pigeon?',
      'predator': 'Peregrine Falcon',
      'prey': 'Pigeon',
    },
    {
      'question':
          'What is the predator and prey in Cricket and Praying Mantis?',
      'predator': 'Praying Mantis',
      'prey': 'Cricket',
    },
    {
      'question':
          'What is the predator and prey in Sea Lion and Great White Shark?',
      'predator': 'Great White Shark',
      'prey': 'Sea Lion',
    },
    {
      'question': 'What is the predator and prey in Owl and Vole?',
      'predator': 'Owl',
      'prey': 'Vole',
    },
    {
      'question':
          'What is the predator and prey in Komodo Dragon and Water Buffalo?',
      'predator': 'Komodo Dragon',
      'prey': 'Water Buffalo',
    },
    {
      'question':
          'What is the predator and prey in Small Fish and Electric Eel?',
      'predator': 'Electric Eel',
      'prey': 'Small Fish',
    },
    {
      'question': 'What is the predator and prey in Tarantula and Small Birds?',
      'predator': 'Tarantula',
      'prey': 'Small Birds (occasionally)',
    },
    {
      'question': 'What is the predator and prey in King Cobra and Rat?',
      'predator': 'King Cobra',
      'prey': 'Rat',
    },
  ];

  List<String?> selectedPredators = List.filled(10, null);
  List<String?> selectedPreys = List.filled(10, null);

  late List<String> remainingItems;

  @override
  void initState() {
    super.initState();
    remainingItems =
        questions.expand((q) => [q['predator']!, q['prey']!]).toList();
  }

  void returnItemToOriginalPosition(int index, bool isPredator) {
    setState(() {
      if (isPredator) {
        remainingItems.add(selectedPredators[index]!);
        selectedPredators[index] = null;
      } else {
        remainingItems.add(selectedPreys[index]!);
        selectedPreys[index] = null;
      }
    });
  }

  void submitAnswer() {
    int score = 0;

    // Calculate the score
    for (int i = 0; i < questions.length; i++) {
      if (selectedPredators[i] == questions[i]['predator'] &&
          selectedPreys[i] == questions[i]['prey']) {
        score++;
      }
    }

    // Update global variables
    var globalVariables = Provider.of<GlobalVariables>(context, listen: false);
    globalVariables.setQuizTaken('lesson6', 'quiz2', true);
    globalVariables.allowQuiz('lesson6', 'quiz3');
    globalVariables.incrementQuizTakeCount('lesson6_quiz2');
    globalVariables.updateGlobalRemarks(
        'lesson6_quiz2', score, questions.length);
    globalVariables.setGlobalScore('lesson6_quiz2', score);
    globalVariables.setQuizItemCount('lesson6_quiz2', questions.length);

    // Navigate to the score page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Ecosystem_AT_Quiz_1_Score(
          score: score,
          questions: questions,
          selectedPredators: selectedPredators,
          selectedPreys: selectedPreys,
        ),
      ),
    );
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
    showWarningDialog();
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Lesson 6 Quiz 2',
            style: TextStyle(color: Colors.white), // Set text color to white
          ),
          backgroundColor: Color(0xFFA846A0),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.only(bottom: 20.0),
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
                      'Drag the correct predator and prey into the blanks below. The options are limited to the related predator and prey.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                children: questions.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, String> question = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Draggable<String>(
                                data: question['predator']!,
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          40,
                                  padding: EdgeInsets.all(8.0),
                                  margin: EdgeInsets.only(right: 16),
                                  decoration: BoxDecoration(
                                    color: remainingItems
                                            .contains(question['predator']!)
                                        ? Color(0xFFA846A0)
                                        : Colors.grey[200],
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
                                      question['predator']!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: remainingItems
                                                .contains(question['predator']!)
                                            ? Colors.white
                                            : Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                feedback: Material(
                                  child: Container(
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        40,
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFA846A0),
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
                                        question['predator']!,
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                childWhenDragging: Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          40,
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
                                      question['predator']!,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              Draggable<String>(
                                data: question['prey']!,
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          40,
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: remainingItems
                                            .contains(question['prey']!)
                                        ? Color(0xFFA846A0)
                                        : Colors.grey[200],
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
                                      question['prey']!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: remainingItems
                                                .contains(question['prey']!)
                                            ? Colors.white
                                            : Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                feedback: Material(
                                  child: Container(
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        40,
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFA846A0),
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
                                        question['prey']!,
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                childWhenDragging: Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          40,
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
                                      question['prey']!,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            question['question']!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: DragTarget<String>(
                                  onWillAccept: (receivedItem) =>
                                      receivedItem == question['predator'] ||
                                      receivedItem == question['prey'],
                                  onAccept: (receivedItem) {
                                    setState(() {
                                      selectedPredators[index] = receivedItem;
                                      remainingItems.remove(receivedItem);
                                    });
                                  },
                                  builder:
                                      (context, acceptedItems, rejectedItems) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (selectedPredators[index] != null) {
                                          returnItemToOriginalPosition(
                                              index, true);
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          color:
                                              selectedPredators[index] == null
                                                  ? Colors.grey[200]
                                                  : Color(0xFFA846A0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.01),
                                              spreadRadius: 0.01,
                                              blurRadius: 4,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            selectedPredators[index] ??
                                                'Predator',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: selectedPredators[index] ==
                                                      null
                                                  ? Colors.grey
                                                  : Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: DragTarget<String>(
                                  onWillAccept: (receivedItem) =>
                                      receivedItem == question['predator'] ||
                                      receivedItem == question['prey'],
                                  onAccept: (receivedItem) {
                                    setState(() {
                                      selectedPreys[index] = receivedItem;
                                      remainingItems.remove(receivedItem);
                                    });
                                  },
                                  builder:
                                      (context, acceptedItems, rejectedItems) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (selectedPreys[index] != null) {
                                          returnItemToOriginalPosition(
                                              index, false);
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          color: selectedPreys[index] == null
                                              ? Colors.grey[200]
                                              : Color(0xFFA846A0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.01),
                                              spreadRadius: 0.01,
                                              blurRadius: 4,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            selectedPreys[index] ?? 'Prey',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  selectedPreys[index] == null
                                                      ? Colors.grey
                                                      : Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitAnswer,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA846A0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
