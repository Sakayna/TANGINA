import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1/score.dart';
import 'package:flutter/material.dart';
import 'package:capstone/helpers/fisher_yates.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1/item.dart';

class Ecosystem_AT_Quiz_0_Content extends StatefulWidget {
  @override
  _Ecosystem_AT_Quiz_0_ContentState createState() =>
      _Ecosystem_AT_Quiz_0_ContentState();
}

class _Ecosystem_AT_Quiz_0_ContentState
    extends State<Ecosystem_AT_Quiz_0_Content> {
  final List<QuizItem> quizItems = [
    QuizItem(
      question:
          'This image shows air being blown by the wind. Is this a biotic or abiotic factor?',
      choices: ['Biotic', 'Abiotic'],
      correctAnswer: 'Abiotic',
      imagePath: 'assets/AT images/week 9/air.jpg',
    ),
    QuizItem(
      question:
          'This image shows bacteria under a microscope. Is this a biotic or abiotic factor?',
      choices: ['Biotic', 'Abiotic'],
      correctAnswer: 'Biotic',
      imagePath: 'assets/AT images/week 9/bacteria.jpg',
    ),
    QuizItem(
      question:
          'This image shows a deer grazing in a meadow. Is this a biotic or abiotic factor?',
      choices: ['Biotic', 'Abiotic'],
      correctAnswer: 'Biotic',
      imagePath: 'assets/AT images/week 9/deer.jpg',
    ),
    QuizItem(
      question:
          'This image shows mushrooms growing on a log. Is this a biotic or abiotic factor?',
      choices: ['Biotic', 'Abiotic'],
      correctAnswer: 'Biotic',
      imagePath: 'assets/AT images/week 9/mushroom.jpg',
    ),
    QuizItem(
      question:
          'This image shows a pine tree in a forest. Is this a biotic or abiotic factor?',
      choices: ['Biotic', 'Abiotic'],
      correctAnswer: 'Biotic',
      imagePath: 'assets/AT images/week 9/pinetree.jpg',
    ),
    QuizItem(
      question:
          'This image shows a river flowing through a valley. Is this a biotic or abiotic factor?',
      choices: ['Biotic', 'Abiotic'],
      correctAnswer: 'Abiotic',
      imagePath: 'assets/AT images/week 9/river.jpg',
    ),
    QuizItem(
      question:
          'This image shows the season and climate changes. Is this a biotic or abiotic factor?',
      choices: ['Biotic', 'Abiotic'],
      correctAnswer: 'Abiotic',
      imagePath: 'assets/AT images/week 9/season_cliamte.jpg',
    ),
    QuizItem(
      question:
          'This image shows soil with visible minerals and nutrients. Is this a biotic or abiotic factor?',
      choices: ['Biotic', 'Abiotic'],
      correctAnswer: 'Abiotic',
      imagePath: 'assets/AT images/week 9/soil.jpg',
    ),
    QuizItem(
      question:
          'This image shows a sunflower in a garden. Is this a biotic or abiotic factor?',
      choices: ['Biotic', 'Abiotic'],
      correctAnswer: 'Biotic',
      imagePath: 'assets/AT images/week 9/sunflower.jpg',
    ),
    QuizItem(
      question:
          'This image shows sunlight shining through the trees. Is this a biotic or abiotic factor?',
      choices: ['Biotic', 'Abiotic'],
      correctAnswer: 'Abiotic',
      imagePath: 'assets/AT images/week 9/sunlight.jpeg',
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
      var globalVariables =
          Provider.of<GlobalVariables>(context, listen: false);
      globalVariables.setQuizTaken('lesson6', 'quiz1', true);

      globalVariables.unlockNextLesson('lesson6');
      globalVariables.incrementQuizTakeCount('lesson6_quiz1');
      globalVariables.updateGlobalRemarks(
          'lesson6_quiz1', userScore, quizItems.length);
      globalVariables.setGlobalScore('lesson6_quiz1', userScore);
      globalVariables.setQuizItemCount('lesson6_quiz1', quizItems.length);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Ecosystem_AT_6_1_Score(
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
            'Lesson 5 Quiz 1',
            style: TextStyle(color: Colors.white), // Set text color to white
          ),
          backgroundColor: Color(0xFFA846A0), // Updated color for AppBar
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white, // Set icon color to white
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
                  color: Colors.white, // White background color
                  borderRadius: BorderRadius.circular(15.0), // Border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.01), // Shadow color
                      spreadRadius: 0.01,
                      blurRadius: 4,
                      offset: Offset(0, 4), // Shadow position
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(widget.quizItem.imagePath),
                      width: 180, // Adjust the image width
                      height: 120, // Adjust the image height
                      fit: BoxFit.cover, // Ensures the image does not overflow
                    ),
                    SizedBox(height: 15),
                    Text(
                      widget.quizItem.question,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14, // Smaller text size for the question
                        fontWeight: FontWeight.normal,
                        color: Colors.black, // Black text color
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
                          isSelected ? Color(0xFFA846A0) : Colors.white,
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
                          fontSize: 14, // Smaller text size for choices
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
                              'lesson6', 'quiz1', true);
                          globalVariables.allowQuiz('lesson6', 'quiz2');
                          setState(() {
                            answerSubmitted = true;
                          });
                          widget.onSubmit(selectedChoice!);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFA846A0),
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
                        backgroundColor: Color(0xFFA846A0),
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
