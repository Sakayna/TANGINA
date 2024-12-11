import 'package:capstone/Module%20Contents/Heredity/Heredity_TLA/Heredity_TLA_5_2.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_TLA/Microscopy_TLA_1_1.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:math';

void main() {
  runApp(MaterialApp(home: ModuleScreen8()));
}

class SceneNode {
  final String name;
  final String modelPath;
  final vector.Vector3 position;
  final vector.Vector3 scale;
  final vector.Vector4 rotation;

  SceneNode({
    required this.name,
    required this.modelPath,
    required this.position,
    required this.scale,
    required this.rotation,
  });
}

class ModuleScreen8 extends StatefulWidget {
  @override
  _ModuleScreen8Page createState() => _ModuleScreen8Page();
}

class _ModuleScreen8Page extends State<ModuleScreen8> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  ARLocationManager? arLocationManager;
  bool surfaceDetected = false;
  bool modelPlaced = false;
  bool introductionShown = false;
  bool instructionsShown = false;
  bool showButtons = false;
  int currentTextStep = 0;
  bool isAnswerCorrect = false;
  bool showIntroOnce = true;
  List<ARNode> nodes = [];
  int currentNodeIndex = 0;
  ARNode? activeNode;
  ARHitTestResult? lastHitTestResult;
  bool showQuestionIntro =
      true; // Add this flag to control the introduction display
  List<String> incorrectQuestions = []; // To store incorrect questions
  List<String> userAnswers = []; // To store user's answers

  int currentQuestionIndex = 0; // Track current question index
  int correctAnswers = 0; // Count of correct answers
  int wrongAnswers = 0; // Count of wrong answers

  final List<Map<String, dynamic>> questions = [
    {
      'question':
          'What is the process called when sperm is introduced into the female reproductive system?',
      'correctAnswer': 'Insemination',
      'options': ['Insemination', 'Ovulation', 'Fertilization'],
    },
    {
      'question': 'Where does fertilization typically occur?',
      'correctAnswer': 'Fallopian Tube',
      'options': ['Fallopian Tube', 'Uterus', 'Ovary']
    },
    {
      'question':
          'What is the name of the cell formed when an egg is fertilized?',
      'correctAnswer': 'Zygote',
      'options': ['Zygote', 'Embryo', 'Fetus'],
    },
    {
      'question': 'What hormone triggers ovulation?',
      'correctAnswer': 'LH',
      'options': ['LH', 'FSH', 'Estrogen'],
    },
    {
      'question':
          'Which structure carries the egg from the ovary to the uterus?',
      'correctAnswer': 'Fallopian Tube',
      'options': ['Fallopian Tube', 'Vagina', 'Cervix'],
    },
  ];

  String getQuestionText() {
    return 'Question ${currentQuestionIndex + 1}: ${questions[currentQuestionIndex]['question']}';
  }

  List<Widget> getAnswerButtons() {
    return questions[currentQuestionIndex]['options']
        .map<Widget>((option) => ElevatedButton(
              onPressed: () {
                checkAnswer(option);
              },
              child: Text(option),
            ))
        .toList();
  }

  void checkAnswer(String answer) {
    setState(() {
      if (currentTextStep == 14) {
        // We are in the question phase
        if (answer == questions[currentQuestionIndex]['correctAnswer']) {
          // Correct answer
          isAnswerCorrect = true;
          correctAnswers++; // Increment correct count

          // Move to the next question
          currentQuestionIndex++;

          // Check if there are more questions to proceed
          if (currentQuestionIndex < questions.length) {
            currentTextStep = 14; // Stay in the question phase
          } else {
            currentTextStep =
                15; // End the activity if all questions are completed
          }
        } else {
          // Incorrect answer
          isAnswerCorrect = false;
          wrongAnswers++; // Increment wrong count

          // Do not proceed to the next question if the answer is wrong
          // Optionally, you can show some feedback to the user here
        }
      } else {
        // Specific handling for other questions
        if (currentTextStep == 3 && answer == 'Ovary') {
          // Correct answer for the question about egg production
          isAnswerCorrect = true;
          correctAnswers++; // Increment correct count
          currentTextStep = 4; // Proceed to next step
        } else if (currentTextStep == 6 && answer == 'Fertilization') {
          // Correct answer for the question about fertilization
          isAnswerCorrect = true;
          correctAnswers++; // Increment correct count
          currentTextStep = 7; // Move to the next step
        } else {
          // Incorrect answer handling
          isAnswerCorrect = false;
          wrongAnswers++; // Increment wrong count
        }
      }
    });
  }

  final List<SceneNode> sceneNodes = [
    SceneNode(
      name: "Uterus",
      modelPath: "assets/lesson8/uterus/uterus.gltf",
      position: vector.Vector3(-0.08, -0.3, -1.0),
      scale: vector.Vector3(0.5, 0.5, 0.5),
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "Ovary",
      modelPath: "assets/lesson8/ooctye/ooctyte.gltf",
      position: vector.Vector3(-0.08, -0.3, -1.0),
      scale: vector.Vector3(0.4, 0.4, 0.4),
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "Insemination",
      modelPath: "assets/lesson8/1/1.gltf",
      position: vector.Vector3(-0.08, -0.3, -1.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "SpermSurroundingEgg",
      modelPath: "assets/lesson8/2/2.gltf",
      position: vector.Vector3(-0.08, -0.3, -1.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "SpermEnteringEgg",
      modelPath: "assets/lesson8/3/3.gltf",
      position: vector.Vector3(-0.08, -0.3, -1.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "MembraneFormation",
      modelPath: "assets/lesson8/4/4.gltf",
      position: vector.Vector3(-0.08, -0.3, -1.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "Fertilization",
      modelPath: "assets/lesson8/5/5.gltf",
      position: vector.Vector3(-0.08, -0.3, -1.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    try {
      // Dispose AR session manager
      arSessionManager?.dispose();

      // Clear cached AR nodes and Flutter's image cache
      clearCache();

      print("AR session and resources cleaned up.");
    } catch (e) {
      print("Error while disposing AR resources: $e");
    }
    super.dispose();
  }

  /// Clears cached AR resources and triggers garbage collection
  void clearCache() {
    try {
      // Clear AR nodes
      nodes.clear();

      // Clear Flutter's image cache
      PaintingBinding.instance.imageCache.clear();

      // Optionally request garbage collection
      print("Garbage collection triggered for resource cleanup.");
    } catch (e) {
      print("Error while clearing cache: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: Center(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.black,
              child: Text(
                'Correct: $correctAnswers | Wrong: $wrongAnswers',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                setState(() {
                  showButtons = !showButtons; // Toggle button visibility
                });
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontal,
          ),
          if (!surfaceDetected && !modelPlaced)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera, size: 100, color: Colors.white),
                  SizedBox(height: 20),
                  Text(
                    'Scan the surface and Tap the screen to place the models',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          if (modelPlaced && currentTextStep == 0 && showIntroOnce)
            Container(
              color: Colors.black54,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Welcome to the AR Learning Module!',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'We are excited to guide you through this immersive experience to learn about the female reproductive system.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentTextStep = 2; // Move to the explanation text
                            showButtons =
                                true; // Show buttons after the introduction
                            instructionsShown =
                                true; // Mark instructions as shown
                          });
                        },
                        child: Text('Next'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (modelPlaced && currentTextStep == 1 && showIntroOnce)
            Container(
              color: Colors.black54,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Introduction to the AR Experience',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'In this module, you will explore a 3D model of the female reproductive system. This interactive experience will help you understand each part and its function.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentTextStep = 2; // Move to the explanation text
                            showButtons =
                                true; // Show buttons after introduction
                            instructionsShown =
                                true; // Mark instructions as shown
                          });
                        },
                        child: Text('Next'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (showButtons)
            Positioned(
              top: 50,
              right: 10,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end, // Align buttons to the right
                children: [
                  buildInfoButton('Uterus',
                      'The uterus is a hollow muscular organ where a fertilized egg implants and develops into a fetus during pregnancy.'),
                  buildInfoButton('Ovary',
                      'The ovaries are reproductive glands that produce eggs and hormones like estrogen and progesterone.'),
                  buildInfoButton('Tube',
                      'The fallopian tubes transport eggs from the ovaries to the uterus and are the site of fertilization.'),
                  buildInfoButton('Fimbriae',
                      'Fimbriae are finger-like projections at the end of the fallopian tubes that help guide eggs into the tube.'),
                  buildInfoButton('Cervix',
                      'The cervix is the lower part of the uterus that connects to the vagina and allows passage between them.'),
                  buildInfoButton('Vagina',
                      'The vagina is a muscular canal that serves as the passageway for childbirth, menstrual flow, and sexual intercourse.'),
                ],
              ),
            ),

          if (modelPlaced && currentTextStep == 2)
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'This is a 3D model of the female reproductive system. It includes various parts such as the uterus, ovaries, fallopian tubes, and more. Take a closer look to understand its structure and function. You can tap on the buttons to explore different parts and click the icon at the top right to hide the buttons.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          introductionShown =
                              true; // Mark introduction as completed
                          currentTextStep = 3; // Move to the next step
                        });
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          // Question about Egg Production
          if (currentTextStep == 3 && introductionShown)
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Do you know where the female eggs are produced?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        checkAnswer('Uterus');
                      },
                      child: Text('Uterus'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        checkAnswer('Ovary'); // Correct answer
                      },
                      child: Text('Ovary'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        checkAnswer('Tube');
                      },
                      child: Text('Tube'),
                    ),
                  ],
                ),
              ),
            ),
          if (isAnswerCorrect && currentTextStep == 4)
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'You are correct! The eggs are produced in the Ovary.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentTextStep = 5; // Proceed to next node
                          showIntroOnce =
                              false; // Prevent re-showing of intro texts
                          onNextButtonPressed(); // Proceed to the next node
                        });
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          if (modelPlaced && currentTextStep == 5)
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Women experience a menstrual cycle each month, during which they ovulate and release an egg called the oocyte. If the egg is not fertilized, it will disintegrate and be shed with the uterine lining.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentTextStep = 6; // Move to the next question
                        });
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          if (currentTextStep == 6)
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'If the egg cell is not fertilized, it will just be a normal menstruation cycle, which is called a period. Then how about if there is a sperm in the tube? What will happen?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        checkAnswer('Fertilization'); // Correct answer
                      },
                      child: Text('Fertilization'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        checkAnswer('Ovulation');
                      },
                      child: Text('Ovulation'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        checkAnswer('Menstruation');
                      },
                      child: Text('Menstruation'),
                    ),
                  ],
                ),
              ),
            ),
          // Correct Answer Confirmation and Next Step to Insemination
          if (isAnswerCorrect && currentTextStep == 7)
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Correct! The next step is insemination.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentTextStep = 8; // Move to show 1.gltf
                          onNextButtonPressed(); // Proceed to the next node
                        });
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          // Explanation about Insemination (1.gltf)
          if (modelPlaced && currentTextStep == 8)
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Insemination is the process where sperm is introduced into the female reproductive system.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentTextStep = 9; // Move to the next node
                          onNextButtonPressed(); // Replace with next node 2.gltf
                        });
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          // Explanation for Sperm Surrounding Egg (2.gltf)
          if (modelPlaced && currentTextStep == 9)
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'The sperm surrounds the egg, attempting to penetrate its outer membrane.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentTextStep = 10; // Move to the next node
                          onNextButtonPressed(); // Replace with next node 3.gltf
                        });
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          // Explanation when the Sperm Enters the Egg (3.gltf)
          if (modelPlaced && currentTextStep == 10)
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'One sperm manages to penetrate the egg and enter it.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentTextStep = 11; // Move to the next node
                          onNextButtonPressed(); // Replace with next node 4.gltf
                        });
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          // Explanation about Membrane Formation (4.gltf)
          if (modelPlaced && currentTextStep == 11)
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'A new membrane forms around the egg to prevent any other sperm from entering.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentTextStep = 12; // Move to the next node
                          onNextButtonPressed(); // Replace with next node 5.gltf
                        });
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          // Explanation about Fertilization (5.gltf)
          if (modelPlaced && currentTextStep == 12)
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Fertilization occurs, resulting in the formation of a zygote, the first stage of a new organism.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentTextStep = 13; // Move to question phase
                        });
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          // Explanation before the Question Phase
          if (currentTextStep == 13 && showQuestionIntro)
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'You will now answer 5 questions to test your understanding of the female reproductive system. Try your best to get them all correct!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentTextStep = 14; // Proceed to the first question
                          showQuestionIntro =
                              false; // Hide intro after first display
                        });
                      },
                      child: Text('Start Questions'),
                    ),
                  ],
                ),
              ),
            ),
          // Question Phase with 5 Questions
          if (currentTextStep == 14)
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      getQuestionText(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ...getAnswerButtons(),
                  ],
                ),
              ),
            ),

          if (currentTextStep == 15)
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Quiz Completed!',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    // Show score calculation
                    Text(
                      'Your Score: ${correctAnswers - wrongAnswers > 0 ? correctAnswers - wrongAnswers : 0} / ${questions.length + 2}', // Total number of questions (5 + 2) for a total of 7
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    // Display pass/fail message
                    Text(
                      correctAnswers - wrongAnswers >= 5
                          ? 'Congratulations, you passed!'
                          : 'You did not pass. Please review your answers.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    if (wrongAnswers > 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Display each wrong answer with question and user's incorrect answer
                          ...List.generate(incorrectQuestions.length, (index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  incorrectQuestions[index], // Display question
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  userAnswers[index], // Display user's answer
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Heredity_TLA_5_2(),
                        ));
                      },
                      child: Text('Exit'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildInfoButton(String title, String description) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Text(description),
              actions: <Widget>[
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Text(title),
    );
  }

  void onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;
    this.arLocationManager = arLocationManager;

    this.arSessionManager!.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          showWorldOrigin: false,
          handlePans: false,
          handleScale: true,
        );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap =
        (List<ARHitTestResult> hitTestResults) {
      if (!modelPlaced) {
        ARHitTestResult? singleHitTestResult;
        try {
          singleHitTestResult = hitTestResults.firstWhere(
            (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane,
          );
        } catch (e) {
          singleHitTestResult = null;
        }

        if (singleHitTestResult != null) {
          lastHitTestResult = singleHitTestResult;
          var translation = singleHitTestResult.worldTransform.getTranslation();
          var rotation = singleHitTestResult.worldTransform.getRotation();
          var rotationQuaternion = vector.Quaternion.fromRotation(rotation);

          placeNode(
              sceneNodes[currentNodeIndex], translation, rotationQuaternion);
        }
      }
    };
  }

  Future<void> placeNode(SceneNode sceneNode, vector.Vector3 translation,
      vector.Quaternion rotation) async {
    try {
      var newNode = ARNode(
        type: NodeType.localGLTF2,
        uri: sceneNode.modelPath,
        scale: sceneNode.scale,
        position: vector.Vector3(
          translation.x + sceneNode.position.x,
          translation.y + sceneNode.position.y,
          translation.z + sceneNode.position.z,
        ),
        rotation: sceneNode.rotation,
        name: sceneNode.name,
        canScale: false,
      );

      bool didAddNode = await arObjectManager!.addNode(newNode) ?? false;
      if (didAddNode) {
        setState(() {
          activeNode = newNode;
          modelPlaced = true;
          surfaceDetected = true;
        });
        nodes.add(newNode);
      }
    } catch (e) {
      arSessionManager?.onError("Failed to add model: $e");
    }
  }

  void onNextTextStep() {
    setState(() {
      if (isAnswerCorrect && currentTextStep == 4) {
        currentTextStep = 0; // Reset to the start for the next node
        onNextButtonPressed(); // Proceed to the next node
      } else {
        currentTextStep++;
      }
    });
  }

  void onNextButtonPressed() async {
    if (activeNode != null) {
      await arObjectManager?.removeNode(activeNode!);
      nodes.remove(activeNode);
      activeNode = null;

      setState(() {
        modelPlaced = false;
        currentNodeIndex = (currentNodeIndex + 1) % sceneNodes.length;
        showButtons = false; // Hide buttons when changing nodes
      });

      if (lastHitTestResult != null) {
        var translation = lastHitTestResult!.worldTransform.getTranslation();
        var rotation = lastHitTestResult!.worldTransform.getRotation();
        var rotationQuaternion = vector.Quaternion.fromRotation(rotation);
        placeNode(
            sceneNodes[currentNodeIndex], translation, rotationQuaternion);
      }
    }
  }
}
