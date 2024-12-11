import 'package:capstone/Module%20Contents/Microscopy/Microscopy_AT/Microscopy_AT_1_2/score.dart';
import 'package:capstone/helpers/fisher_yates.dart';
import 'package:flutter/material.dart';
import 'item.dart' as quizItemsFile;

import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

void main() {
  runApp(MaterialApp(
    home: Microscopy_AT_Quiz_2_Content(),
  ));
}

class Microscopy_AT_Quiz_2_Content extends StatefulWidget {
  @override
  _Microscopy_AT_Quiz_2_ContentState createState() =>
      _Microscopy_AT_Quiz_2_ContentState();
}

class _Microscopy_AT_Quiz_2_ContentState
    extends State<Microscopy_AT_Quiz_2_Content> {
  final List<quizItemsFile.QuizItemContent> quizItems = [
    quizItemsFile.QuizItemContent(
      question:
          '1. What part of the microscope connects the eyepiece to the objective lenses? (Hint: e.t.)',
      answer: 'eyepiece tube',
    ),
    quizItemsFile.QuizItemContent(
      question:
          '2. Which part of the microscope holds the objective lenses and rotates to change magnification? (Hint: n.)',
      answer: 'nosepiece',
    ),
    quizItemsFile.QuizItemContent(
      question:
          '3. What are the lenses called that magnify the specimen by different powers? (Hint: o.l.)',
      answer: 'objective lenses',
    ),
    quizItemsFile.QuizItemContent(
      question:
          '4. Which part of the microscope secures the slide in place? (Hint: s.c.)',
      answer: 'stage clips',
    ),
    quizItemsFile.QuizItemContent(
      question:
          '5. What is the flat platform where the slide is placed for viewing? (Hint: s.)',
      answer: 'stage',
    ),
    quizItemsFile.QuizItemContent(
      question:
          '6. Which part of the microscope controls the amount of light reaching the specimen? (Hint: d.)',
      answer: 'diaphragm',
    ),
    quizItemsFile.QuizItemContent(
      question:
          '7. What is the light source at the base of the microscope called? (Hint: i.)',
      answer: 'illuminator',
    ),
    quizItemsFile.QuizItemContent(
      question:
          '8. Where do you look through to see the magnified image of the specimen? (Hint: e.)',
      answer: 'eyepiece',
    ),
    quizItemsFile.QuizItemContent(
      question:
          '9. What is the vertical part of the microscope that connects the base to the head called? (Hint: a.)',
      answer: 'arm',
    ),
    quizItemsFile.QuizItemContent(
      question:
          '10. Which knob moves the stage up and down to bring the specimen into general focus? (Hint: c.f.)',
      answer: 'coarse focus',
    ),
    quizItemsFile.QuizItemContent(
      question:
          '11. Which knob is used to fine-tune the focus of the specimen? (Hint: f.f.)',
      answer: 'fine focus',
    ),
    quizItemsFile.QuizItemContent(
      question:
          '12. What is the bottom part of the microscope that provides stability called? (Hint: b.)',
      answer: 'base',
    ),
  ];

  final answerController = TextEditingController();
  int currentQuestionIndex = 0;
  Map<int, String> userAnswers = {};
  bool isAnswerEmpty = true;

  @override
  void initState() {
    super.initState();
    FisherYates.shuffleList(quizItems);
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    if (userAnswers.containsKey(currentQuestionIndex)) {
      answerController.text = userAnswers[currentQuestionIndex] ?? '';
      isAnswerEmpty = answerController.text.isEmpty;
    } else {
      answerController.clear();
      isAnswerEmpty = true;
    }

    return WillPopScope(
      onWillPop: () async {
        if (currentQuestionIndex == 0) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Warning'),
                content: Text('You cannot go back after starting the quiz.'),
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
          return false; // Prevents the screen from being popped
        } else {
          setState(() {
            currentQuestionIndex--;
            isAnswerEmpty =
                (userAnswers[currentQuestionIndex]?.isEmpty ?? true);
          });
          return false;
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xFFFFA551), // Solid background color
              elevation: 4, // Adds shadow
              pinned: true, // Keeps the app bar visible
              title: Text(
                'Lesson 1 Quiz 1',
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
                  if (currentQuestionIndex == 0) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Warning'),
                          content: Text(
                              'You cannot go back after starting the quiz.'),
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
                      currentQuestionIndex--;
                      isAnswerEmpty =
                          userAnswers[currentQuestionIndex]?.isEmpty ?? true;
                    });
                  }
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 40.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Instructions: Label and Identify the part of the microscope based on the given image and functions of it. Write your answer below. Make sure the answer is in lowercase. There is a hint for each part to assist you. Good luck!',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Image.asset(
                            'assets/images/Microscopy/worksheet2.jpg',
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              'Question ${currentQuestionIndex + 1}:',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              quizItems[currentQuestionIndex].question,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          TextField(
                            controller: answerController,
                            onChanged: (answer) {
                              setState(() {
                                userAnswers[currentQuestionIndex] = answer;
                                isAnswerEmpty = answer.isEmpty;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your answer',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, top: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (isAnswerEmpty) {
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
                                if (currentQuestionIndex <
                                    quizItems.length - 1) {
                                  setState(() {
                                    currentQuestionIndex++;
                                    isAnswerEmpty = !userAnswers
                                        .containsKey(currentQuestionIndex + 1);
                                  });
                                } else {
                                  globalVariables.setQuizTaken(
                                      'lesson1', 'quiz1', true);
                                  globalVariables.allowQuiz('lesson1', 'quiz2');

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Microscopy_AT_Quiz_2_Score(
                                        totalQuestions: quizItems.length,
                                        correctAnswers: 0,
                                        quizItems: quizItems,
                                        userAnswers: userAnswers,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                currentQuestionIndex < quizItems.length - 1
                                    ? 'Next'
                                    : 'Submit',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
