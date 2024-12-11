// lib/Module Contents/Heredity/Heredity_AT/Heredity_AT_5_1/content.dart

import 'package:flutter/material.dart';
import 'package:capstone/Module Contents/Heredity/Heredity_AT/Heredity_AT_5_1/item.dart';
import 'package:capstone/helpers/fisher_yates.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:provider/provider.dart';
import 'package:capstone/Module Contents/Heredity/Heredity_AT/Heredity_AT_5_1/score.dart';

class Heredity_AT_Quiz_0_Content extends StatefulWidget {
  @override
  _Heredity_AT_Quiz_0_ContentState createState() =>
      _Heredity_AT_Quiz_0_ContentState();
}

class _Heredity_AT_Quiz_0_ContentState
    extends State<Heredity_AT_Quiz_0_Content> {
  final List<QuizItem> quizItems = [
    QuizItem(
      question:
          'This image shows a paramecium splitting into two identical halves. Does this image depict asexual or sexual reproduction?',
      choices: [
        'Asexual (Binary fission)',
        'Asexual (Sporulation)',
        'Sexual (External Fertilization)',
        'Sexual (Conjugation)'
      ],
      correctAnswer: 'Asexual (Binary fission)',
      imagePath: 'assets/AT images/week 7/binaryfission.jpg',
    ),
    QuizItem(
      question:
          'This image shows reproduction typical of hydra. Does this image depict asexual or sexual reproduction?',
      choices: [
        'Asexual (Budding)',
        'Asexual (Fragmentation)',
        'Sexual (Pollination)',
        'Sexual (Internal Fertilization)'
      ],
      correctAnswer: 'Asexual (Budding)',
      imagePath: 'assets/AT images/week 7/budding.jpg',
    ),
    QuizItem(
      question:
          'This image shows growing a new plant using any plant part. Does this image depict asexual or sexual reproduction?',
      choices: [
        'Asexual (Vegetative propagation)',
        'Asexual (Sporulation)',
        'Sexual (Pollination)',
        'Sexual (Conjugation)'
      ],
      correctAnswer: 'Asexual (Vegetative propagation)',
      imagePath: 'assets/AT images/week 7/vegetativepropagation.jpg',
    ),
    QuizItem(
      question:
          'This image shows reproduction exhibited by ferns, mosses, and fungi. Does this image depict asexual or sexual reproduction?',
      choices: [
        'Asexual (Sporulation)',
        'Asexual (Binary fission)',
        'Sexual (External Fertilization)',
        'Sexual (Pollination)'
      ],
      correctAnswer: 'Asexual (Sporulation)',
      imagePath: 'assets/AT images/week 7/spores.jpg',
    ),
    QuizItem(
      question:
          'This image shows an entire animal growing from a cut piece of a parent animal. Does this image depict asexual or sexual reproduction?',
      choices: [
        'Asexual (Fragmentation)',
        'Asexual (Budding)',
        'Sexual (Internal Fertilization)',
        'Sexual (Conjugation)'
      ],
      correctAnswer: 'Asexual (Fragmentation)',
      imagePath: 'assets/AT images/week 7/star.jpg',
    ),
    QuizItem(
      question:
          'This image shows pollination in flowers. Does this image depict asexual or sexual reproduction?',
      choices: [
        'Asexual (Vegetative propagation)',
        'Asexual (Binary fission)',
        'Sexual (Pollination)',
        'Sexual (External Fertilization)'
      ],
      correctAnswer: 'Sexual (Pollination)',
      imagePath: 'assets/AT images/week 7/pollination.jpg',
    ),
    QuizItem(
      question:
          'This image shows fertilization in frogs. Does this image depict asexual or sexual reproduction?',
      choices: [
        'Asexual (Sporulation)',
        'Asexual (Fragmentation)',
        'Sexual (External Fertilization)',
        'Sexual (Conjugation)'
      ],
      correctAnswer: 'Sexual (External Fertilization)',
      imagePath: 'assets/AT images/week 7/frog.jpg',
    ),
    QuizItem(
      question:
          'This image shows bacteria undergoing genetic recombination. Does this image depict asexual or sexual reproduction?',
      choices: [
        'Asexual (Binary fission)',
        'Asexual (Vegetative propagation)',
        'Sexual (Conjugation)',
        'Sexual (Pollination)'
      ],
      correctAnswer: 'Sexual (Conjugation)',
      imagePath: 'assets/AT images/week 7/conjugation.jpg',
    ),
    QuizItem(
      question:
          'This image shows fertilization in fish. Does this image depict asexual or sexual reproduction?',
      choices: [
        'Asexual (Sporulation)',
        'Asexual (Fragmentation)',
        'Sexual (External Fertilization)',
        'Sexual (Internal Fertilization)'
      ],
      correctAnswer: 'Sexual (External Fertilization)',
      imagePath: 'assets/AT images/week 7/fish.jpg',
    ),
    QuizItem(
      question:
          'This image shows human fertilization. Does this image depict asexual or sexual reproduction?',
      choices: [
        'Asexual (Budding)',
        'Asexual (Binary fission)',
        'Sexual (Internal Fertilization)',
        'Sexual (Conjugation)'
      ],
      correctAnswer: 'Sexual (Internal Fertilization)',
      imagePath: 'assets/AT images/week 7/fertilization.jpg',
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
          builder: (context) => Heredity_AT_Quiz_0_Score(
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
    return WillPopScope(
      onWillPop: () async {
        if (currentQuestionIndex == 0) {
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
          return false;
        } else {
          setState(() {
            currentQuestionIndex--;
          });
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Lesson 5 Quiz 1',
            style: TextStyle(color: Colors.white), // Set text color to white
          ),
          backgroundColor: Color(0xFF64B6AC),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white, // Set icon color to white
            onPressed: currentQuestionIndex == 0
                ? () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Warning'),
                        content:
                            Text('You cannot go back after starting a quiz.'),
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
                : () {
                    setState(() {
                      currentQuestionIndex--;
                    });
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

  QuizItemWidget({
    required this.quizItem,
    required this.onSubmit,
    required this.isLastQuestion,
    required this.userSelectedChoices,
    required this.currentQuestionIndex,
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
          padding: const EdgeInsets.only(top: 50.0),
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
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(widget.quizItem.imagePath),
                      width: 180,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 15),
                    Text(
                      widget.quizItem.question,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ...widget.quizItem.choices.asMap().entries.map((entry) {
                String choice = entry.value;
                bool isSelected = selectedChoice == choice;
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isSelected ? Color(0xFF64B6AC) : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                            color: isSelected
                                ? Colors.transparent
                                : Colors.transparent),
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
                          fontSize: 14,
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
                          var globalVariables = Provider.of<GlobalVariables>(
                              context,
                              listen: false);
                          globalVariables.setQuizTaken(
                              'lesson5', 'quiz1', true);
                          globalVariables.allowQuiz('lesson5', 'quiz2');
                          setState(() {
                            answerSubmitted = true;
                          });
                          widget.onSubmit(selectedChoice!);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF64B6AC),
                      ),
                      child:
                          Text('Submit', style: TextStyle(color: Colors.white)),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF64B6AC),
                      ),
                      child:
                          Text('Next', style: TextStyle(color: Colors.white)),
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
