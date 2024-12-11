import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_2/Ecosystem_AT_Quiz_1_Score.dart';
import 'package:capstone/helpers/fisher_yates.dart';
import 'package:flutter/material.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_2/Ecosystem_AT_Quiz_1_Items.dart';

import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class Ecosystem_AT_Quiz_3_Content extends StatefulWidget {
  @override
  _Ecosystem_AT_Quiz_3_ContentState createState() =>
      _Ecosystem_AT_Quiz_3_ContentState();
}

class _Ecosystem_AT_Quiz_3_ContentState
    extends State<Ecosystem_AT_Quiz_3_Content> {
  final List<QuizItem> quizItems = [
    QuizItem(
      question:
          'Which image best depicts the effect of extreme temperature on a habitat?',
      choices: [
        'Extreme Temperature',
        'Volcanic Eruption',
        'Flood',
        'Wildfire'
      ],
      correctAnswer: 'Extreme Temperature',
      imagePath: 'assets/AT images/week12/extremetemp.jpg',
    ),
    QuizItem(
      question:
          'Which image best illustrates the impact of a flood on a forest ecosystem?',
      choices: ['Flood', 'Volcanic Eruption', 'Soil Erosion', 'Wildfire'],
      correctAnswer: 'Flood',
      imagePath: 'assets/AT images/week12/flood.jpg',
    ),
    QuizItem(
      question:
          'Which image best represents the effects of soil erosion on a landscape?',
      choices: ['Soil Erosion', 'Volcanic Eruption', 'Flood', 'Wildfire'],
      correctAnswer: 'Soil Erosion',
      imagePath: 'assets/AT images/week12/soilerosion.jpg',
    ),
    QuizItem(
      question:
          'Which image shows the likely effect of a volcanic eruption on a nearby ecosystem?',
      choices: ['Volcanic Eruption', 'Flood', 'Soil Erosion', 'Wildfire'],
      correctAnswer: 'Volcanic Eruption',
      imagePath: 'assets/AT images/week12/volcanic_eruption.jpg',
    ),
    QuizItem(
      question:
          'Which image shows the impact of water pollution on aquatic life?',
      choices: [
        'Water Pollution',
        'Volcanic Eruption',
        'Soil Erosion',
        'Wildfire'
      ],
      correctAnswer: 'Water Pollution',
      imagePath: 'assets/AT images/week12/waterpollution.jpg',
    ),
    QuizItem(
      question: 'Which image depicts the effects of a wildfire on a forest?',
      choices: ['Wildfire', 'Volcanic Eruption', 'Flood', 'Soil Erosion'],
      correctAnswer: 'Wildfire',
      imagePath: 'assets/AT images/week12/wildfire.jpg',
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
      globalVariables.setQuizTaken('lesson6', 'quiz4', true);
      globalVariables.unlockNextLesson('lesson6');
      globalVariables.incrementQuizTakeCount('lesson6_quiz4');
      globalVariables.updateGlobalRemarks(
          'lesson6_quiz4', userScore, quizItems.length);
      globalVariables.setGlobalScore('lesson6_quiz4', userScore);
      globalVariables.setQuizItemCount('lesson6_quiz4', quizItems.length);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Ecosystem_AT_Quiz_3_Score(
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
            'Lesson 6 Quiz 4',
            style: TextStyle(color: Colors.white), // Set text color to white
          ),
          backgroundColor: Color(0xFFA846A0),
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
                              'lesson6', 'quiz4', true);
                          globalVariables.allowQuiz('lesson6', 'quiz4');
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
