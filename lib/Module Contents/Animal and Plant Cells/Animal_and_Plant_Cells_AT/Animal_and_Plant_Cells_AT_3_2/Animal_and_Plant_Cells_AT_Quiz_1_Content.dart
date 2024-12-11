import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/Animal_and_Plant_Cells_AT_3_2/Animal_and_Plant_Cells_AT_Quiz_1_Score.dart';
import 'package:capstone/helpers/fisher_yates.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/Animal_and_Plant_Cells_AT_3_2/Animal_and_Plant_Cells_AT_Quiz_1_Items.dart';

class Animal_and_Plant_AT_3_1_2_Content extends StatefulWidget {
  @override
  _Animal_and_Plant_AT_3_1_2_ContentState createState() =>
      _Animal_and_Plant_AT_3_1_2_ContentState();
}

class _Animal_and_Plant_AT_3_1_2_ContentState
    extends State<Animal_and_Plant_AT_3_1_2_Content> {
  final List<QuizItem> quizItems = [
    QuizItem(
      question:
          'Which cell structure provides mechanical support and maintains cell shape in plant cells?',
      choices: ['Cell wall', 'Plasma membrane', 'Cytoplasm', 'Nucleus'],
      correctAnswer: 'Cell wall',
    ),
    QuizItem(
      question:
          'What part of the cell regulates the entry and exit of materials like ions and organic molecules?',
      choices: ['Plasma membrane', 'Cell wall', 'Vacuole', 'Golgi apparatus'],
      correctAnswer: 'Plasma membrane',
    ),
    QuizItem(
      question:
          'Which organelle is known as the powerhouse of the cell and provides energy in the form of ATP?',
      choices: [
        'Mitochondrion',
        'Chloroplastid',
        'Lysosome',
        'Endoplasmic reticulum'
      ],
      correctAnswer: 'Mitochondrion',
    ),
    QuizItem(
      question:
          'Which cell structure stores water, food, or waste for the cells?',
      choices: ['Vacuole', 'Nucleolus', 'Cytoplasm', 'Chromosomes'],
      correctAnswer: 'Vacuole',
    ),
    QuizItem(
      question:
          'Which organelle sorts, packages, and modifies proteins for secretion?',
      choices: ['Golgi apparatus', 'Lysosome', 'Plasma membrane', 'Nucleus'],
      correctAnswer: 'Golgi apparatus',
    ),
    QuizItem(
      question:
          'What is the matrix of different cellular organelles and is responsible for the distribution of materials throughout the cell due to cyclosis?',
      choices: [
        'Cytoplasm',
        'Endoplasmic reticulum',
        'Nuclear membrane',
        'Vacuole'
      ],
      correctAnswer: 'Cytoplasm',
    ),
    QuizItem(
      question:
          'Which cell structure separates the nuclear contents from the contents of the cytoplasm?',
      choices: [
        'Nuclear membrane',
        'Plasma membrane',
        'Nucleolus',
        'Chromosomes'
      ],
      correctAnswer: 'Nuclear membrane',
    ),
    QuizItem(
      question:
          'What is the dense, spherical body inside the nucleus responsible for the synthesis of RNA and production of ribosomes?',
      choices: [
        'Nucleolus',
        'Nucleoplasm',
        'Endoplasmic reticulum',
        'Chromosomes'
      ],
      correctAnswer: 'Nucleolus',
    ),
    QuizItem(
      question:
          'What functions as the matrix of the chromosomes and nucleolus within the nucleus?',
      choices: ['Nucleoplasm', 'Cytoplasm', 'Lysosome', 'Nucleolus'],
      correctAnswer: 'Nucleoplasm',
    ),
    QuizItem(
      question:
          'Which cell structure carries genes responsible for transmitting hereditary characteristics?',
      choices: ['Chromosomes', 'Nucleolus', 'Cytoplasm', 'Nucleus'],
      correctAnswer: 'Chromosomes',
    ),
    QuizItem(
      question:
          'Which organelle is the control center of the cell and directs and coordinates all cellular activities?',
      choices: ['Nucleus', 'Mitochondrion', 'Chloroplastid', 'Golgi apparatus'],
      correctAnswer: 'Nucleus',
    ),
    QuizItem(
      question:
          'Which network of channels plays an important role in the formation of the skeletal framework?',
      choices: [
        'Endoplasmic reticulum',
        'Golgi apparatus',
        'Lysosome',
        'Nucleoplasm'
      ],
      correctAnswer: 'Endoplasmic reticulum',
    ),
    QuizItem(
      question:
          'Which double-membrane structure contains chlorophyll pigments and functions for photosynthesis?',
      choices: [
        'Chloroplastid',
        'Mitochondrion',
        'Endoplasmic reticulum',
        'Vacuole'
      ],
      correctAnswer: 'Chloroplastid',
    ),
    QuizItem(
      question:
          'Which cell structure is involved in the formation of spindle fibers during cell division and functions as the anchor for the cytoskeletons?',
      choices: ['Centrioles', 'Cytoplasm', 'Chromosomes', 'Nuclear membrane'],
      correctAnswer: 'Centrioles',
    ),
    QuizItem(
      question:
          'Which organelle contains powerful hydrolytic enzymes and is referred to as the "suicide bag" of the cell?',
      choices: ['Lysosome', 'Vacuole', 'Nucleus', 'Mitochondrion'],
      correctAnswer: 'Lysosome',
    ),
  ];

  int currentQuestionIndex = 0;
  int userScore = 0;
  Map<int, List<String>> userSelectedChoices = {};

  @override
  void initState() {
    super.initState();
    FisherYates.shuffleList(quizItems);
    for (var quizItem in quizItems) {
      FisherYates.shuffleList(quizItem.choices);
    }
  }

  void submitAnswer(String selectedChoice) {
    final int questionIndex = currentQuestionIndex;

    if (!userSelectedChoices.containsKey(questionIndex)) {
      userSelectedChoices[questionIndex] = [];
    }

    userSelectedChoices[questionIndex]!.add(selectedChoice);

    if (selectedChoice == quizItems[questionIndex].correctAnswer) {
      setState(() {
        userScore++;
      });
    }

    if (currentQuestionIndex < quizItems.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Animal_and_Plant_AT_3_1_2_Score(
            quizItems: quizItems,
            userSelectedChoices: userSelectedChoices,
            userScore: userScore,
            totalQuestions: quizItems.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        if (currentQuestionIndex > 0) {
          setState(() {
            currentQuestionIndex--;
          });
          return Future.value(false);
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Warning'),
              content: Text('You cannot go back after starting a quiz.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
          return Future.value(false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Lesson 3 Quiz 2',
            style: TextStyle(color: Colors.white), // Set text color to white
          ),
          backgroundColor: Color(0xFFA1C084), // Set the background color
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (currentQuestionIndex > 0) {
                setState(() {
                  currentQuestionIndex--;
                });
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Warning'),
                    content: Text('You cannot go back after starting a quiz.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
        body: currentQuestionIndex < quizItems.length
            ? QuizItemWidget(
                quizItem: quizItems[currentQuestionIndex],
                onSubmit: submitAnswer,
                isLastQuestion: currentQuestionIndex == quizItems.length - 1,
                userSelectedChoices: userSelectedChoices,
                currentQuestionIndex: currentQuestionIndex,
                globalVariables: globalVariables,
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class QuizItemWidget extends StatefulWidget {
  final QuizItem quizItem;
  final ValueChanged<String> onSubmit;
  final bool isLastQuestion;
  final Map<int, List<String>> userSelectedChoices;
  final int currentQuestionIndex;
  final GlobalVariables globalVariables;

  QuizItemWidget({
    required this.quizItem,
    required this.onSubmit,
    required this.isLastQuestion,
    required this.userSelectedChoices,
    required this.currentQuestionIndex,
    required this.globalVariables,
  });

  @override
  _QuizItemWidgetState createState() => _QuizItemWidgetState();
}

class _QuizItemWidgetState extends State<QuizItemWidget> {
  String? selectedChoice;
  bool answerSubmitted = false;

  @override
  void initState() {
    super.initState();
    selectedChoice =
        widget.userSelectedChoices[widget.currentQuestionIndex]?.last;
  }

  @override
  void didUpdateWidget(covariant QuizItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentQuestionIndex != widget.currentQuestionIndex) {
      selectedChoice =
          widget.userSelectedChoices[widget.currentQuestionIndex]?.last;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.quizItem.question,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ...widget.quizItem.choices.asMap().entries.map((entry) {
                int idx = entry.key;
                String choice = entry.value;
                bool isSelected = selectedChoice == choice;
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isSelected ? Color(0xFFA1C084) : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                            color: isSelected
                                ? Colors.transparent
                                : Colors.grey[400]!),
                      ),
                    ),
                    onPressed: answerSubmitted
                        ? null
                        : () {
                            setState(() {
                              selectedChoice = choice;
                            });
                          },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        choice,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
              if (widget.isLastQuestion)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: EdgeInsets.only(top: 10, right: 20, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedChoice != null) {
                          widget.globalVariables
                              .setQuizTaken('lesson3', 'quiz2', true);
                          widget.globalVariables.allowQuiz('lesson3', 'quiz2');
                          widget.globalVariables.unlockNextLesson('lesson3');
                          setState(() {
                            answerSubmitted = true;
                          });
                          widget.onSubmit(selectedChoice!);
                        }
                      },
                      child:
                          Text('Submit', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                )
              else
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: EdgeInsets.only(top: 10, right: 20, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedChoice != null) {
                          widget.onSubmit(selectedChoice!);
                          setState(() {
                            selectedChoice = null;
                          });
                        }
                      },
                      child:
                          Text('Next', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
