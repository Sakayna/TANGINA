import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_AT/Bactera_AT_4_2/Bacteria_AT_Quiz_1_Score.dart';
import 'package:capstone/helpers/fisher_yates.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class QuizItem {
  final String question;
  final List<String> choices;
  final String correctAnswer;
  final String imagePath; // Added imagePath for questions with images

  QuizItem({
    required this.question,
    required this.choices,
    required this.correctAnswer,
    this.imagePath = '', // Default empty string if no image
  });
}

class Bacteria_AT_Quiz_1_Content extends StatefulWidget {
  @override
  _Bacteria_AT_Quiz_1_ContentState createState() =>
      _Bacteria_AT_Quiz_1_ContentState();
}

class _Bacteria_AT_Quiz_1_ContentState
    extends State<Bacteria_AT_Quiz_1_Content> {
  final List<QuizItem> quizItems = [
    QuizItem(
      question:
          'This image shows jute fibers being separated for use in making ropes and sacks. The process involves the use of bacteria. Is this microorganism beneficial or harmful?',
      imagePath: 'assets/AT images/week6/jutefibers.jpg',
      choices: [
        'Beneficial (Clostridium butylicum used in fiber retting)',
        'Harmful (Bacteria causing fiber degradation)'
      ],
      correctAnswer: 'Beneficial (Clostridium butylicum used in fiber retting)',
    ),
    QuizItem(
      question:
          'This image shows a scientist in a laboratory working with bacteria to produce insulin, a crucial hormone for diabetes management. Is this microorganism beneficial or harmful?',
      imagePath: 'assets/AT images/week6/insulin.jpg',
      choices: [
        'Beneficial (Bioengineered bacteria such as Bacillus subtilis used for producing therapeutic proteins like insulin)',
        'Harmful (Bacteria causing contamination in laboratory settings)'
      ],
      correctAnswer:
          'Beneficial (Bioengineered bacteria such as Bacillus subtilis used for producing therapeutic proteins like insulin)',
    ),
    QuizItem(
      question:
          'This image shows a tank of wine undergoing fermentation. The fermentation process relies on a combination of bacteria and yeasts. Is this microorganism beneficial or harmful?',
      imagePath: 'assets/AT images/week6/tank.jpg',
      choices: [
        'Beneficial (Lactobacillus and yeasts used in fermentation processes like brewing wine)',
        'Harmful (Bacteria causing spoilage of wine during fermentation)'
      ],
      correctAnswer:
          'Beneficial (Lactobacillus and yeasts used in fermentation processes like brewing wine)',
    ),
    QuizItem(
      question:
          'This image depicts a field being sprayed with a biological pesticide to control pests without harming other wildlife. Is this microorganism beneficial or harmful?',
      imagePath: 'assets/AT images/week6/sewage.jpg',
      choices: [
        'Beneficial (Bacillus thuringiensis used as a biological pest control)',
        'Harmful (Bacteria causing unintended harm to beneficial insects)'
      ],
      correctAnswer:
          'Beneficial (Bacillus thuringiensis used as a biological pest control)',
    ),
    QuizItem(
      question:
          'This image shows a sewage treatment plant where bacteria are used to convert sludge into methane gas. Is this microorganism beneficial or harmful?',
      imagePath: 'assets/AT images/week6/sewage.jpg',
      choices: [
        'Beneficial (Methane-producing bacteria used in sewage treatment)',
        'Harmful (Bacteria causing harmful emissions during sewage treatment)'
      ],
      correctAnswer:
          'Beneficial (Methane-producing bacteria used in sewage treatment)',
    ),
    QuizItem(
      question:
          'This image shows spoiled food with mold and signs of decay due to bacterial activity. Is this microorganism beneficial or harmful?',
      imagePath: 'assets/AT images/week6/saprotrophic.png',
      choices: [
        'Beneficial (Bacteria used in composting food waste)',
        'Harmful (Saprotrophic bacteria causing food spoilage)'
      ],
      correctAnswer: 'Harmful (Saprotrophic bacteria causing food spoilage)',
    ),
    QuizItem(
      question:
          'This image shows a person with a high fever and a rash, symptoms commonly associated with typhoid fever. The disease is caused by a specific bacterium. Is this microorganism beneficial or harmful?',
      imagePath: 'assets/AT images/week6/salmonela.png',
      choices: [
        'Beneficial (Bacteria used in vaccine development)',
        'Harmful (Salmonella typhi, previously known as Bacillus typhosus, causes typhoid fever)'
      ],
      correctAnswer:
          'Harmful (Salmonella typhi, previously known as Bacillus typhosus, causes typhoid fever)',
    ),
    QuizItem(
      question:
          'This image depicts a rusty nail causing a wound on a person\'s foot, leading to muscle stiffness and spasms. This condition is known as tetanus. Is this microorganism beneficial or harmful?',
      imagePath: 'assets/AT images/week6/tetanus.jpg',
      choices: [
        'Beneficial (Bacteria used in the production of tetanus toxoid vaccine)',
        'Harmful (Clostridium tetani causes tetanus)'
      ],
      correctAnswer: 'Harmful (Clostridium tetani causes tetanus)',
    ),
    QuizItem(
      question:
          'This image shows a person suffering from severe dehydration after drinking contaminated water, a condition caused by cholera. Is this microorganism beneficial or harmful?',
      imagePath: 'assets/AT images/week6/cholera.jpg',
      choices: [
        'Beneficial (Bacteria used in water purification processes)',
        'Harmful (Vibrio cholerae causes cholera)'
      ],
      correctAnswer: 'Harmful (Vibrio cholerae causes cholera)',
    ),
    QuizItem(
      question:
          'This image shows deteriorated leather items with signs of bacterial decay. Is this microorganism beneficial or harmful?',
      imagePath: 'assets/AT images/week6/deterioratedleather.jpg',
      choices: [
        'Beneficial (Bacteria used in leather tanning processes)',
        'Harmful (Spirochaete cytophaga causes deterioration of wooden and leather articles)'
      ],
      correctAnswer:
          'Harmful (Spirochaete cytophaga causes deterioration of wooden and leather articles)',
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
          builder: (context) => Bacteria_AT_Quiz_1_Score(
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
            'Lesson 4 Quiz 1',
            style: TextStyle(color: Colors.white), // Set text color to white
          ),
          backgroundColor: Color(0xFFFF6A6A), // Set the background color
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
  bool answerSubmitted = false; // Track if the answer is submitted

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
    final List<Color> buttonColors = [
      Color(0xFFFF6A6A),
    ];

    var globalVariables = Provider.of<GlobalVariables>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0), // Specify top padding
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
                int idx = entry.key;
                String choice = entry.value;
                bool isSelected = selectedChoice == choice;
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected
                          ? buttonColors[idx % buttonColors.length]
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                            color: isSelected
                                ? Colors.transparent
                                : Colors.grey[400]!), // Lighter gray border
                      ),
                    ),
                    onPressed: answerSubmitted
                        ? null // Disable button after answer is submitted
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
                          globalVariables.setQuizTaken(
                              'lesson4', 'quiz1', true);
                          globalVariables.unlockNextLesson('lesson4');
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
