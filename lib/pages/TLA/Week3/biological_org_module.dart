import 'package:capstone/Module%20Contents/Levels%20of%20Biological%20Organization/Levels_of_Biological_Organization_TLA/Levels_of_Biological_Organization_TLA_2_1.dart';
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
  runApp(MaterialApp(home: ModuleScreen3()));
}

class SceneNode {
  final String name;
  final String modelPath;
  final vector.Vector3 position;
  final vector.Vector3 scale;

  SceneNode({
    required this.name,
    required this.modelPath,
    required this.position,
    required this.scale,
  });
}

class ModuleScreen3 extends StatefulWidget {
  @override
  _ModuleScreen3Page createState() => _ModuleScreen3Page();
}

class _ModuleScreen3Page extends State<ModuleScreen3> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  ARLocationManager? arLocationManager;
  bool surfaceDetected = false;
  bool modelPlaced = false;
  bool introductionShown = false;
  bool instructionsShown = false;
  List<ARNode> nodes = [];
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  int currentQuestionIndex = 0;
  List<bool> unlockedButtons = List.filled(12, false);
  List<String> wrongAnswers = [];
  String feedbackMessage = '';
  bool showFeedback = false;
  Color feedbackColor = Colors.black;
  List<String> correctFeedbackMessages = [
    "Great Job!",
    "You are Amazing!",
    "Wow! Hats off to you!",
  ];

  // Updated questionAnswerPairs list
  List<Map<String, String>> questionAnswerPairs = [
    {
      "question":
          "Which level in biological organization is the basic unit of life?",
      "answer": "Cells",
      "definition":
          "A cell is a collection of organelles that function together as the basic unit of life, capable of carrying out all functions of living things. Cells vary in size and shape.",
      "image": "assets/lesson3/assets/org/cell.png"
    },
    {
      "question":
          "Which level in biological organization is a group of similar cells performing specific functions?",
      "answer": "Tissues",
      "definition":
          "Tissue is a group of similar cells that work together to perform specific functions. Examples in plants include parenchyma, and in animals, epithelial tissue.",
      "image": "assets/lesson3/assets/org/tissues.jpg"
    },
    {
      "question":
          "Which level in biological organization consists of different tissues performing a function?",
      "answer": "Organs",
      "definition":
          "An organ consists of different tissues organized together to perform a specific function. For example, the heart pumps blood throughout the body.",
      "image": "assets/lesson3/assets/org/organ.png"
    },
    {
      "question":
          "Which level in biological organization involves several organs working together?",
      "answer": "Organ System",
      "definition":
          "An organ system consists of multiple organs working together to perform broad functions, like the excretory system removing waste.",
      "image": "assets/lesson3/assets/org/organsystem.png"
    },
    {
      "question":
          "Which level in biological organization pertains to an individual of a species?",
      "answer": "Organism",
      "definition":
          "An organism is an individual with distinct existence as a complex, self-reproducing unit, composed of organ systems working together.",
      "image": "assets/lesson3/assets/org/organism.jpg"
    },
    {
      "question":
          "Which level in biological organization is a group of organisms of the same species?",
      "answer": "Population",
      "definition":
          "A population is a group of organisms of the same species occupying a given area, interacting with one another.",
      "image": "assets/lesson3/assets/org/population.jpg"
    },
    {
      "question":
          "Which level in biological organization involves different species living together?",
      "answer": "Communities",
      "definition":
          "A community consists of all the populations of different species living together in an area, interacting in various ways.",
      "image": "assets/lesson3/assets/org/communities.jpg"
    },
    {
      "question":
          "Which level in biological organization involves biotic and abiotic components interacting?",
      "answer": "Ecosystem",
      "definition":
          "An ecosystem consists of communities of organisms (biotic) and nonliving (abiotic) components interacting within an area.",
      "image": "assets/lesson3/assets/org/ecosystem.jpg"
    },
    {
      "question":
          "Which level in biological organization involves ecosystems with similar climates?",
      "answer": "Biomes",
      "definition":
          "A biome is a collection of ecosystems with similar climates covering a large area, like grasslands or deserts.",
      "image": "assets/lesson3/assets/org/biomes.jpg"
    },
    {
      "question":
          "Which level in biological organization includes all ecosystems on Earth?",
      "answer": "Biosphere",
      "definition":
          "The biosphere is the totality of Earth's ecosystems, encompassing any part where life exists.",
      "image": "assets/lesson3/assets/org/biosphere.jpg"
    }
  ];

  @override
  void initState() {
    super.initState();
    questionAnswerPairs.shuffle(Random());
  }

  @override
  void dispose() {
    arSessionManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Adjust the height here
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
                'Correct: $correctAnswers  Wrong: $incorrectAnswers',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          actions: [
            SizedBox(width: 48), // To keep the title centered
          ],
        ),
      ),
      body: Stack(
        children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontal,
          ),
          if (!surfaceDetected || (surfaceDetected && !modelPlaced))
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
          if (modelPlaced && !introductionShown)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Introduction to the AR Biological Organization Module',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'In this activity, you will learn about the different levels of biological organization. Pay attention to the models and try to answer the questions correctly. Good luck!',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              introductionShown = true;
                            });
                          },
                          child: Text('Next'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (introductionShown && !instructionsShown)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Instructions',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'In this module, you will learn about the levels of biological organization. Carefully observe the images and answer the questions to identify each level correctly. Good luck!',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              instructionsShown = true;
                            });
                          },
                          child: Text('Start'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (showFeedback)
            Positioned(
              top: 16,
              left: MediaQuery.of(context).size.width / 6,
              right: MediaQuery.of(context).size.width / 6,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    feedbackMessage,
                    style: TextStyle(
                      fontSize: 16,
                      color: feedbackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          if (modelPlaced &&
              instructionsShown &&
              currentQuestionIndex < questionAnswerPairs.length)
            Positioned(
              bottom: 150, // Adjusted to avoid overlapping with buttons
              left: 16,
              right: 16,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      questionAnswerPairs[currentQuestionIndex]['question']!,
                      style: TextStyle(
                        fontSize: 12, // Smaller font size for the question text
                        color: Colors.white,
                        height: 1.2, // Smaller line height
                      ),
                      textAlign: TextAlign.center,
                      textHeightBehavior: TextHeightBehavior(
                        applyHeightToFirstAscent: false,
                        applyHeightToLastDescent: false,
                      ),
                    ),
                    SizedBox(
                        height:
                            4), // Reduced spacing between the text and the image
                    Image.asset(
                      questionAnswerPairs[currentQuestionIndex]['image']!,
                      width: MediaQuery.of(context).size.width *
                          0.5, // Smaller image: 30% of screen width
                      height: MediaQuery.of(context).size.height *
                          0.15, // Smaller image: 15% of screen height
                    ),
                  ],
                ),
              ),
            ),
          if (instructionsShown)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                height: 120, // Lowered the height of the container
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10, // Adjusted to 10 for the new question set
                  itemBuilder: (context, index) {
                    String buttonText = questionAnswerPairs[index]['answer']!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: unlockedButtons[index]
                                ? () {
                                    _showDefinition(
                                      context,
                                      buttonText,
                                      questionAnswerPairs[index]['definition']!,
                                      questionAnswerPairs[index]['image']!,
                                    );
                                  }
                                : null,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(5),
                              foregroundColor: Colors.white,
                            ),
                            child: unlockedButtons[index]
                                ? Column(
                                    children: [
                                      Image.asset(
                                        questionAnswerPairs[index]['image']!,
                                        width: 60,
                                        height: 60,
                                      ),
                                      Text(
                                        buttonText,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )
                                : Icon(Icons.help_outline, size: 40),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
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
          var translation = singleHitTestResult.worldTransform.getTranslation();
          var rotation = singleHitTestResult.worldTransform.getRotation();
          var rotationQuaternion = vector.Quaternion.fromRotation(rotation);

          // Updated sceneNodes list
          List<SceneNode> sceneNodes = [
            SceneNode(
              name: "Cells",
              modelPath: "assets/lesson3/assets/blocks/cells.gltf",
              position: vector.Vector3(0, 0.15, 0),
              scale: vector.Vector3(0.07, 0.07, 0.07),
            ),
            SceneNode(
              name: "Tissues",
              modelPath: "assets/lesson3/assets/blocks/tissues.gltf",
              position: vector.Vector3(0, 0.18, 0),
              scale: vector.Vector3(0.07, 0.07, 0.07),
            ),
            SceneNode(
              name: "Organs",
              modelPath: "assets/lesson3/assets/blocks/organs.gltf",
              position: vector.Vector3(0, 0.21, 0),
              scale: vector.Vector3(0.07, 0.07, 0.07),
            ),
            SceneNode(
              name: "Organ System",
              modelPath: "assets/lesson3/assets/blocks/organsystem.gltf",
              position: vector.Vector3(0, 0.24, 0),
              scale: vector.Vector3(0.07, 0.07, 0.07),
            ),
            SceneNode(
              name: "Organism",
              modelPath: "assets/lesson3/assets/blocks/organism.gltf",
              position: vector.Vector3(0, 0.27, 0),
              scale: vector.Vector3(0.07, 0.07, 0.07),
            ),
            SceneNode(
              name: "Population",
              modelPath: "assets/lesson3/assets/blocks/population.gltf",
              position: vector.Vector3(0, 0.30, 0),
              scale: vector.Vector3(0.07, 0.07, 0.07),
            ),
            SceneNode(
              name: "Communities",
              modelPath: "assets/lesson3/assets/blocks/comm.gltf",
              position: vector.Vector3(0, 0.33, 0),
              scale: vector.Vector3(0.07, 0.07, 0.07),
            ),
            SceneNode(
              name: "Ecosystem",
              modelPath: "assets/lesson3/assets/blocks/ecosystem.gltf",
              position: vector.Vector3(0, 0.36, 0),
              scale: vector.Vector3(0.07, 0.07, 0.07),
            ),
            SceneNode(
              name: "Biomes",
              modelPath: "assets/lesson3/assets/blocks/biomes.gltf",
              position: vector.Vector3(0, 0.39, 0),
              scale: vector.Vector3(0.07, 0.07, 0.07),
            ),
            SceneNode(
              name: "Biosphere",
              modelPath: "assets/lesson3/assets/blocks/biosphere.gltf",
              position: vector.Vector3(0, 0.42, 0),
              scale: vector.Vector3(0.07, 0.07, 0.07),
            ),
          ];

          loadModels(sceneNodes, translation, rotationQuaternion);
        }
      }
    };
  }

  Future<void> loadModel(SceneNode sceneNode, vector.Vector3 translation,
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
        rotation:
            vector.Vector4(0, 1, 0, 6.2832), // Rotate 360 degrees around Y-axis
        name: sceneNode.name,
        canScale: false, // Ensure models cannot be pinched
      );

      bool didAddNode = await arObjectManager!.addNode(newNode) ?? false;
      if (didAddNode) {
        nodes.add(newNode);
      }
    } catch (e) {
      arSessionManager?.onError("Failed to add model: $e");
    }
  }

  void loadModels(List<SceneNode> sceneNodes, vector.Vector3 translation,
      vector.Quaternion rotation) async {
    for (var sceneNode in sceneNodes) {
      await loadModel(sceneNode, translation, rotation);
    }
    setState(() {
      modelPlaced = true;
      surfaceDetected = true; // Set surfaceDetected to true to hide the text
    });
    arObjectManager!.onNodeTap = (tappedNodes) {
      tappedNodes.forEach((nodeName) {
        String question =
            questionAnswerPairs[currentQuestionIndex]['question']!;
        String answer = questionAnswerPairs[currentQuestionIndex]['answer']!;

        // Show the correct definition and image for the tapped node
        if (nodeName == answer) {
          _showDefinition(
            context,
            nodeName,
            questionAnswerPairs[currentQuestionIndex]['definition']!,
            questionAnswerPairs[currentQuestionIndex]['image']!,
            isLastQuestion:
                currentQuestionIndex >= questionAnswerPairs.length - 1,
          );

          setState(() {
            correctAnswers++;
            unlockedButtons[currentQuestionIndex] = true;
            currentQuestionIndex++;
            feedbackMessage = correctFeedbackMessages[
                Random().nextInt(correctFeedbackMessages.length)];
            feedbackColor = Colors.green;
            showFeedback = true;
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                showFeedback = false;
                feedbackMessage = '';
              });
            });
          });
        } else {
          setState(() {
            incorrectAnswers++;
            feedbackMessage = 'Wrong! You tapped on $nodeName';
            feedbackColor = Colors.red;
            wrongAnswers.add(
                'Q: ${questionAnswerPairs[currentQuestionIndex]['question']} - Your answer: $nodeName');
            showFeedback = true;
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                showFeedback = false;
                feedbackMessage = '';
              });
            });
          });
        }
      });
    };
  }

  void _showDefinition(
    BuildContext context,
    String part,
    String definition,
    String imagePath, {
    bool isLastQuestion = false,
  }) {
    double dialogHeight;

    // Adjust height based on content length
    if (definition.length > 200) {
      dialogHeight = 300.0; // Fixed height for long discussions
    } else if (definition.length > 100) {
      dialogHeight = 250.0; // Intermediate height for medium discussions
    } else {
      dialogHeight = 200.0; // Slightly larger height for short discussions
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(part),
          content: SizedBox(
            height:
                dialogHeight, // Adaptive height for the discussion container
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(definition),
                  SizedBox(height: 10),
                  Image.asset(imagePath),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                if (isLastQuestion) {
                  _showScore(); // Only show the score after the last question is closed
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showScore() {
    int finalScore = correctAnswers - incorrectAnswers;
    if (finalScore < 0)
      finalScore = 0; // Ensure the score does not go below zero
    String passOrFail = finalScore >= 7 ? 'Passed' : 'Failed';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Completed!'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Your Score: $finalScore / ${questionAnswerPairs.length}'),
                Text('You have $passOrFail'),
                SizedBox(height: 20),
                Text('Incorrect Answers:'),
                for (String wrongAnswer in wrongAnswers) Text(wrongAnswer),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Click on the button to go back to the module.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
                // Navigate back to the initial screen
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => Biological_Organization_TLA_2_1()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('Exit'),
            ),
          ],
        );
      },
    );
  }
}
