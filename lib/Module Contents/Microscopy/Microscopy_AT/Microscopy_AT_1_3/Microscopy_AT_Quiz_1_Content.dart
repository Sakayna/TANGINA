import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_AT/Microscopy_AT_1_3/Microscopy_AT_Quiz_1_Score.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalVariables()),
      ],
      child: MaterialApp(
        home: Microscopy_AT_Quiz_1_Content(),
      ),
    ),
  );
}

class Microscopy_AT_Quiz_1_Content extends StatefulWidget {
  @override
  _Microscopy_AT_Quiz_1_ContentState createState() =>
      _Microscopy_AT_Quiz_1_ContentState();
}

class _Microscopy_AT_Quiz_1_ContentState
    extends State<Microscopy_AT_Quiz_1_Content> {
  final List<String> tasks = [
    "Turn on the microscope",
    "Turn on the illuminator",
    "Click on the 10x objective",
    "Fix the viewing of the specimen in 10x",
    "Click on the 40x objective",
    "Fix the viewing of the specimen in 40x",
    "Rotate the nosepiece away",
    "Click on the oil button",
    "Click on the specimen on the stage",
    "Click on the 100x objective",
    "Fix the viewing of the specimen in 100x",
  ];

  List<String> steps = [];
  List<String> targetOrder = [];
  List<String> remainingItems = [];

  @override
  void initState() {
    super.initState();
    // Randomize tasks and corresponding steps
    final randomizedOrder =
        fisherYatesShuffle(List.generate(tasks.length, (index) => index));
    steps = randomizedOrder.map((i) => "Step ${i + 1}").toList();
    remainingItems = randomizedOrder.map((i) => tasks[i]).toList();
    targetOrder = List<String>.filled(tasks.length, '');
  }

  List<int> fisherYatesShuffle(List<int> list) {
    final random = Random();
    for (int i = list.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1);
      final temp = list[i];
      list[i] = list[j];
      list[j] = temp;
    }
    return list;
  }

  void submitOrder() {
    int score = 0;
    for (int i = 0; i < targetOrder.length; i++) {
      if (targetOrder[i] == tasks[i]) {
        score++;
      }
    }

    debugPrint('Submit button clicked');
    var globalVariables = Provider.of<GlobalVariables>(context, listen: false);
    globalVariables.setQuizTaken('lesson1', 'quiz2', true);
    globalVariables.allowQuiz('lesson1', 'quiz2');
    globalVariables.unlockNextLesson('lesson1');

    debugPrint('Navigating to Microscopy_AT_Quiz_1_Score page');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Microscopy_AT_Quiz_1_Score(
          score: score,
          passed: score >= 8, // Example passing score
          questions: steps,
          userAnswers: targetOrder,
          correctAnswers: tasks,
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFA551), // Set a solid background color
        elevation: 4, // Keeps the shadow effect
        title: Text(
          'Lesson 1 Quiz 2',
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
            if (targetOrder.every((element) => element.isEmpty)) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Warning'),
                    content:
                        Text('You cannot go back after starting the quiz.'),
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
                remainingItems = List.from(tasks);
                remainingItems.shuffle(Random());
                targetOrder = List<String>.filled(11, '');
              });
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
                      'Drag the steps below and arrange them in the correct order.',
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
                        childAspectRatio: 1.8,
                      ),
                      itemBuilder: (context, index) {
                        return Draggable<String>(
                          data: remainingItems[index],
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFA551),
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
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          feedback: Material(
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFA551),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(
                                  remainingItems[index],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          childWhenDragging: Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                remainingItems[index],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
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
                            steps[index],
                            style: TextStyle(fontSize: 14),
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
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: targetOrder[index].isEmpty
                                        ? Colors.grey[200]
                                        : Color(0xFFFFA551),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      targetOrder[index],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: targetOrder[index].isEmpty
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
                        ],
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitOrder,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFA551),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
