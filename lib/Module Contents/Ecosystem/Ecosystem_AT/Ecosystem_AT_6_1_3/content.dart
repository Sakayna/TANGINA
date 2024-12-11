import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1_3/score.dart';
import 'package:flutter/material.dart';
import 'package:capstone/helpers/fisher_yates.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1_3/items.dart';

class Ecosystem_AT_Quiz_2_Content extends StatefulWidget {
  @override
  _Ecosystem_AT_Quiz_2_ContentState createState() =>
      _Ecosystem_AT_Quiz_2_ContentState();
}

class _Ecosystem_AT_Quiz_2_ContentState
    extends State<Ecosystem_AT_Quiz_2_Content> {
  final List<QuizItem> quizItems = [
    QuizItem(
      question:
          'Scenario 1: The population of wolves in a forest decreases. What is the most likely outcome?',
      choices: [
        'Option A: The deer population increases due to fewer predators.',
        'Option B: The rabbit population decreases due to increased competition.',
        'Option C: The plant population decreases due to overgrazing by deer.',
        'Option D: The wolf population eventually increases due to migration.',
      ],
      correctAnswer:
          'Option A: The deer population increases due to fewer predators.',
    ),
    QuizItem(
      question:
          'Scenario 2: A drought reduces the water supply in a grassland ecosystem. What is the most likely outcome?',
      choices: [
        'Option A: Plant populations increase due to less competition for water.',
        'Option B: Herbivore populations decrease due to a lack of food and water.',
        'Option C: Carnivore populations increase due to more available prey.',
        'Option D: Herbivore populations increase as they adapt to the drought conditions.',
      ],
      correctAnswer:
          'Option B: Herbivore populations decrease due to a lack of food and water.',
    ),
    QuizItem(
      question:
          'Scenario 3: The population of bees in an area dramatically declines. What is the most likely outcome?',
      choices: [
        'Option A: Flowering plants increase because bees no longer consume their pollen.',
        'Option B: Flowering plant populations decrease due to reduced pollination.',
        'Option C: The population of pollinators like butterflies increases to replace bees.',
        'Option D: The ecosystem becomes more reliant on wind pollination.',
      ],
      correctAnswer:
          'Option B: Flowering plant populations decrease due to reduced pollination.',
    ),
    QuizItem(
      question:
          'Scenario 4: A disease significantly reduces the population of rabbits in a meadow. What is the most likely outcome?',
      choices: [
        'Option A: The fox population increases due to an abundance of prey.',
        'Option B: The fox population decreases due to a lack of food.',
        'Option C: The grass population decreases due to overgrazing.',
        'Option D: The rabbit population increases as they develop immunity.',
      ],
      correctAnswer:
          'Option B: The fox population decreases due to a lack of food.',
    ),
    QuizItem(
      question:
          'Scenario 5: An invasive plant species rapidly spreads in a wetland, outcompeting native plants. What is the most likely outcome?',
      choices: [
        'Option A: Insect populations increase due to more available food sources.',
        'Option B: Insect populations decrease due to a reduction in native plant resources.',
        'Option C: The invasive plant supports a new variety of animal species.',
        'Option D: The wetland ecosystem becomes more diverse due to the new species.',
      ],
      correctAnswer:
          'Option B: Insect populations decrease due to a reduction in native plant resources.',
    ),
    QuizItem(
      question:
          'Scenario 6: A new predator, the bobcat, is introduced into a forest ecosystem where deer are abundant. What is the most likely outcome?',
      choices: [
        'Option A: The deer population increases due to reduced predation.',
        'Option B: The deer population decreases due to increased predation.',
        'Option C: The bobcat population decreases due to lack of prey.',
        'Option D: The forest ecosystem remains unchanged by the introduction of the bobcat.',
      ],
      correctAnswer:
          'Option B: The deer population decreases due to increased predation.',
    ),
    QuizItem(
      question:
          'Scenario 7: An increase in ocean temperatures causes coral reefs to bleach and die. What is the most likely outcome?',
      choices: [
        'Option A: Fish populations that rely on coral reefs for shelter increase.',
        'Option B: Fish populations that rely on coral reefs for shelter decrease.',
        'Option C: The ocean ecosystem becomes more diverse with new species.',
        'Option D: The coral reefs quickly recover and regain their color.',
      ],
      correctAnswer:
          'Option B: Fish populations that rely on coral reefs for shelter decrease.',
    ),
    QuizItem(
      question:
          'Scenario 8: A sudden cold snap kills a large portion of a butterfly population. What is the most likely outcome?',
      choices: [
        'Option A: The predator population that feeds on butterflies decreases due to less food.',
        'Option B: The predator population that feeds on butterflies increases due to more available food.',
        'Option C: The butterfly population adapts to the cold and rebounds quickly.',
        'Option D: The ecosystem remains unchanged by the loss of the butterflies.',
      ],
      correctAnswer:
          'Option A: The predator population that feeds on butterflies decreases due to less food.',
    ),
    QuizItem(
      question:
          'Scenario 9: A river is dammed, reducing the flow of water and altering the aquatic habitat. What is the most likely outcome?',
      choices: [
        'Option A: Fish populations that thrive in fast-moving water increase.',
        'Option B: Fish populations that prefer slow-moving water increase.',
        'Option C: The dam increases the biodiversity of the river ecosystem.',
        'Option D: The river ecosystem remains unchanged despite the dam.',
      ],
      correctAnswer:
          'Option B: Fish populations that prefer slow-moving water increase.',
    ),
    QuizItem(
      question:
          'Scenario 10: The population of owls in a forest increases significantly. What is the most likely outcome?',
      choices: [
        'Option A: The populations of small rodents decrease due to increased predation.',
        'Option B: The populations of small rodents increase due to fewer predators.',
        'Option C: The owl population decreases due to lack of food.',
        'Option D: The forest ecosystem becomes more diverse with more owls.',
      ],
      correctAnswer:
          'Option A: The populations of small rodents decrease due to increased predation.',
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
      // Integrate GlobalVariables for progress tracking
      var globalVariables =
          Provider.of<GlobalVariables>(context, listen: false);
      globalVariables.setQuizTaken('lesson6', 'quiz3', true);
      globalVariables.allowQuiz('lesson6', 'quiz3');
      globalVariables.incrementQuizTakeCount('lesson6_quiz3');
      globalVariables.updateGlobalRemarks(
          'lesson6_quiz3', userScore, quizItems.length);
      globalVariables.setGlobalScore('lesson6_quiz3', userScore);
      globalVariables.setQuizItemCount('lesson6_quiz3', quizItems.length);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Ecosystem_AT_Quiz_2_Score(
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
            'Lesson 6 Quiz 3',
            style: TextStyle(color: Colors.white), // Set text color to white
          ),
          backgroundColor: Color(0xFFA846A0),
        ),
        body: SingleChildScrollView(
          child: currentQuestionIndex < quizItems.length
              ? QuizItemWidget(
                  quizItem: quizItems[currentQuestionIndex],
                  onSubmit: submitAnswer,
                  isLastQuestion: currentQuestionIndex == quizItems.length - 1,
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}

class QuizItemWidget extends StatefulWidget {
  final QuizItem quizItem;
  final ValueChanged<String> onSubmit;
  final bool isLastQuestion;

  QuizItemWidget({
    required this.quizItem,
    required this.onSubmit,
    required this.isLastQuestion,
  });

  @override
  _QuizItemWidgetState createState() => _QuizItemWidgetState();
}

class _QuizItemWidgetState extends State<QuizItemWidget> {
  String? selectedChoice;
  bool answerSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Question Container
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
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              widget.quizItem.question,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20),
          ...widget.quizItem.choices.asMap().entries.map((entry) {
            String choice = entry.value;
            bool isSelected = selectedChoice == choice;
            return Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
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
                      var globalVariables =
                          Provider.of<GlobalVariables>(context, listen: false);
                      globalVariables.setQuizTaken('lesson6', 'quiz3', true);
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
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
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
                  child: Text('Next', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
