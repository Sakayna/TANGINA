import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/AT1/score.dart';

class AnimalAndPlant extends StatefulWidget {
  @override
  _AnimalAndPlantState createState() => _AnimalAndPlantState();
}

class _AnimalAndPlantState extends State<AnimalAndPlant> {
  final List<String> plantOnly = [];
  final List<String> both = [];
  final List<String> animalOnly = [];

  final List<String> items = [
    'Mitochondria',
    'Chloroplast',
    'Cell Wall',
    'Cell Membrane',
    'Nucleus',
    'Ribosomes',
    'Vacuole',
    'Lysosomes',
    'Centrioles',
    'Endoplasmic Reticulum',
    'Golgi apparatus',
    'Cytoplasm',
  ];

  List<String> remainingItems = [];

  @override
  void initState() {
    super.initState();
    remainingItems = List.from(items);
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
    if (plantOnly.isEmpty && both.isEmpty && animalOnly.isEmpty) {
      showWarningDialog();
      return false; // Prevents going back
    }
    return false; // Always prevent going back
  }

  void submitOrder() {
    int score = 0;

    // Correct answers
    final List<String> correctPlantOnly = ['Cell Wall', 'Chloroplast'];
    final List<String> correctBoth = [
      'Cell Membrane',
      'Ribosomes',
      'Nucleus',
      'Endoplasmic Reticulum',
      'Golgi apparatus',
      'Lysosomes',
      'Vacuole',
      'Mitochondria',
      'Cytoplasm'
    ];
    final List<String> correctAnimalOnly = ['Centriole'];

    // Track user answers
    final Map<String, List<String>> userAnswers = {
      'Plant Only': List.from(plantOnly),
      'Both': List.from(both),
      'Animal Only': List.from(animalOnly),
    };

    // Calculate the score based on correct answers
    score += plantOnly.where((item) => correctPlantOnly.contains(item)).length;
    score += both.where((item) => correctBoth.contains(item)).length;
    score +=
        animalOnly.where((item) => correctAnimalOnly.contains(item)).length;

    bool passed = score >= 8; // Adjusted passing score as needed

    // Global variable updates
    var globalVariables = Provider.of<GlobalVariables>(context, listen: false);
    globalVariables.setQuizTaken('lesson3', 'quiz1', true);
    globalVariables.incrementQuizTakeCount('lesson3_quiz1');
    globalVariables.updateGlobalRemarks('lesson3_quiz1', score, items.length);
    globalVariables.setGlobalScore('lesson3_quiz1', score);
    globalVariables.setQuizItemCount('lesson3_quiz1', items.length);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Plant_Animal_ScorePage(
          score: score,
          passed: passed,
          userAnswers: userAnswers,
          correctAnswers: {
            'Plant Only': correctPlantOnly,
            'Both': correctBoth,
            'Animal Only': correctAnimalOnly,
          },
        ),
      ),
    );
  }

  void returnItemToOriginalPosition(String item, List<String> list) {
    setState(() {
      list.remove(item);
      remainingItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Lesson 3 Quiz 1',
            style: TextStyle(color: Colors.white), // Set text color to white
          ),
          backgroundColor: Color(0xFFA1C084),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (plantOnly.isEmpty && both.isEmpty && animalOnly.isEmpty) {
                showWarningDialog();
              }
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
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
                        'Drag the items below and place them in the correct part of the Venn diagram: Plant, Animal, or Both.',
                        style: TextStyle(fontSize: 12),
                      ),
                      Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: remainingItems.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2.5,
                          ),
                          itemBuilder: (context, index) {
                            return Draggable<String>(
                              data: remainingItems[index],
                              child: buildDraggableContainer(
                                  remainingItems[index], Colors.white),
                              feedback: Material(
                                child: buildDraggableContainer(
                                    remainingItems[index], Colors.grey[200]!),
                              ),
                              childWhenDragging: buildDraggableContainer(
                                  remainingItems[index], Colors.grey[300]!),
                              onDragCompleted: () {
                                setState(() {
                                  remainingItems.removeAt(index);
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                buildDragTarget('Plant', Colors.green.withOpacity(0.3),
                    plantOnly, returnItemToOriginalPosition),
                SizedBox(height: 20),
                buildDragTarget('Both', Colors.purple.withOpacity(0.3), both,
                    returnItemToOriginalPosition),
                SizedBox(height: 20),
                buildDragTarget('Animal', Colors.blue.withOpacity(0.3),
                    animalOnly, returnItemToOriginalPosition),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: submitOrder,
                  child: Text('Submit'),
                ),
              ],
            ),
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

  Widget buildDragTarget(String label, Color backgroundColor,
      List<String> itemList, Function(String, List<String>) onRemove) {
    return CircleAvatar(
      radius: 100,
      backgroundColor: backgroundColor,
      child: DragTarget<String>(
        onAccept: (receivedItem) {
          setState(() {
            itemList.add(receivedItem);
          });
        },
        builder: (context, acceptedItems, rejectedItems) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
              for (var item in itemList)
                GestureDetector(
                  onTap: () => onRemove(item, itemList),
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
