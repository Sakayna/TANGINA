import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_TLA/Ecosystem_TLA_6_3.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_TLA/Ecosystem_TLA_6_4.dart';
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
  runApp(MaterialApp(home: ModuleScreen12()));
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

class ModuleScreen12 extends StatefulWidget {
  @override
  _ModuleScreen12Page createState() => _ModuleScreen12Page();
}

class _ModuleScreen12Page extends State<ModuleScreen12> {
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
  List<bool> unlockedButtons = List.filled(9, false);
  List<String> wrongAnswers = [];
  String feedbackMessage = '';
  bool showFeedback = false;
  Color feedbackColor = Colors.black;
  List<String> correctFeedbackMessages = [
    "Great Job!",
    "You are Amazing!",
    "Wow! Hats off to you!",
  ];

  List<Map<String, dynamic>> questionAnswerPairs = [
    {
      "question":
          "What happens if there is too much or too little rain water? Click on the cause.",
      "answer": "Flood or Drought",
      "discussion":
          "Too much rain can cause flooding, leading to soil erosion, destruction of habitats, and loss of life. Too little rain can cause droughts, resulting in water scarcity, loss of vegetation, and desertification.",
      "images": [
        {"path": "assets/lesson12/for images/flood.jpg", "label": "Flood"},
        {"path": "assets/lesson12/for images/drought.jpg", "label": "Drought"}
      ],
      "title": "Flood or Drought"
    },
    {
      "question":
          "What happens if there is too much sunlight or too little sunlight? Click on the cause.",
      "answer": "Overheating or Insufficient Sunlight",
      "discussion":
          "Excessive sunlight can cause overheating and desertification, stressing plant and animal life. Insufficient sunlight can slow plant growth and reduce photosynthesis, impacting the entire food chain.",
      "images": [
        {
          "path": "assets/lesson12/for images/too much sunlight.jpg",
          "label": "Overheating"
        },
        {
          "path": "assets/lesson12/for images/now sunlight.jpeg",
          "label": "Insufficient Sunlight"
        }
      ],
      "title": "Overheating or Insufficient Sunlight"
    },
    {
      "question":
          "What happens if there is pollution or garbage? Click on the cause.",
      "answer": "Pollution",
      "discussion":
          "Pollution from garbage and other sources can contaminate the air, water, and soil, leading to health problems for humans and animals, and disrupting ecosystems.",
      "images": [
        {
          "path": "assets/lesson12/for images/garbage polluton.jpg",
          "label": "Pollution"
        }
      ],
      "title": "Pollution"
    },
    {
      "question":
          "What happens if there is too much temperature in water? Click on the cause.",
      "answer": "Thermal Pollution",
      "discussion":
          "Increased water temperatures can reduce oxygen levels, harm aquatic life, and disrupt marine ecosystems, leading to loss of biodiversity.",
      "images": [
        {
          "path": "assets/lesson12/for images/thermal pollution.jpg",
          "label": "Thermal Pollution"
        }
      ],
      "title": "Thermal Pollution"
    },
    {
      "question":
          "What happens if there is too much cutting of trees? Click on the cause.",
      "answer": "Deforestation",
      "discussion":
          "Excessive cutting of trees leads to deforestation, which results in habitat loss, soil erosion, and contributes to climate change by reducing the number of trees that can absorb carbon dioxide.",
      "images": [
        {
          "path": "assets/lesson12/for images/deforastation.jpg",
          "label": "Deforestation"
        }
      ],
      "title": "Deforestation"
    }
  ];

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
            SizedBox(width: 48),
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
                          'Introduction to Environmental Impact',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'In this module, you will learn about how different factors affect our environment. Pay attention to the models and try to answer the questions correctly. Good luck!',
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
                          'You will be asked a series of questions related to the models. Tap on the corresponding model to answer each question. If you answer incorrectly, it will be counted. Try your best to get them all right!',
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
              bottom: 150,
              left: 16,
              right: 16,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  questionAnswerPairs[currentQuestionIndex]['question']!,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
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
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: questionAnswerPairs.length,
                  itemBuilder: (context, index) {
                    String buttonText = questionAnswerPairs[index]['title']!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: unlockedButtons[index]
                                ? () {
                                    _showDiscussion(
                                      context,
                                      buttonText,
                                      questionAnswerPairs[index]['discussion']!,
                                      questionAnswerPairs[index]['images'],
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
                                        questionAnswerPairs[index]['images'][0]
                                            ['path'],
                                        width: 60,
                                        height: 60,
                                      ),
                                      SizedBox(height: 5),
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

          // Add the table node
          var tableNode = ARNode(
            type: NodeType.localGLTF2,
            uri: "assets/lesson9/tabless.gltf",
            scale: vector.Vector3(1.5, 1.0, 1.0),
            position: vector.Vector3(
              translation.x + 0.05,
              translation.y - 0.25,
              translation.z - 0.20,
            ),
            rotation: vector.Vector4(0, 1, 0, 1.5708),
            name: "table",
            canScale: false,
          );

          arObjectManager!.addNode(tableNode).then((didAddTableNode) {
            if (didAddTableNode!) {
              nodes.add(tableNode);
              // Add display-only nodes for Mountain, Cloud, Sun, Flower, and Rock
              List<SceneNode> displayNodes = [
                SceneNode(
                  name: "Mountain",
                  modelPath: "assets/lesson9/mountain/mountainers.gltf",
                  position: vector.Vector3(-0.1, 0.02, -0.4),
                  scale: vector.Vector3(0.3, 0.3, 0.3),
                ),
                SceneNode(
                  name: "Flower",
                  modelPath: "assets/lesson9/flower/flower.gltf",
                  position: vector.Vector3(0.15, 0.02, 0.05),
                  scale: vector.Vector3(0.12, 0.12, 0.12),
                ),
                SceneNode(
                  name: "Rock",
                  modelPath: "assets/lesson9/rock/rockista.gltf",
                  position: vector.Vector3(0.15, 0.02, 0.0),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
              ];

              List<SceneNode> interactiveNodes = [
                SceneNode(
                  name: "Flood or Drought",
                  modelPath: "assets/lesson9/cloudy/clouderistss.gltf",
                  position: vector.Vector3(0.3, 0.25, -0.3),
                  scale: vector.Vector3(0.15, 0.15, 0.15),
                ),
                SceneNode(
                  name: "Overheating or Insufficient Sunlight",
                  modelPath: "assets/lesson9/sun/sunny.gltf",
                  position: vector.Vector3(0.4, 0.5, -0.3),
                  scale: vector.Vector3(0.15, 0.15, 0.15),
                ),
                SceneNode(
                  name: "Pollution",
                  modelPath: "assets/lesson12/garbage/garbage.gltf",
                  position: vector.Vector3(0.28, 0.02, -0.05),
                  scale: vector.Vector3(0.08, 0.08, 0.08),
                ),
                SceneNode(
                  name: "Thermal Pollution",
                  modelPath: "assets/lesson11/fish/fish.gltf",
                  position: vector.Vector3(0.3, 0.02, -0.25),
                  scale: vector.Vector3(0.12, 0.12, 0.12),
                ),
                SceneNode(
                  name: "Deforestation",
                  modelPath: "assets/lesson12/cut/cut.gltf",
                  position: vector.Vector3(-0.15, 0.02, 0.0),
                  scale: vector.Vector3(0.05, 0.05, 0.05),
                ),
              ];

              // Load models before showing the introduction message
              loadModels(displayNodes, translation, rotationQuaternion);
              loadModels(interactiveNodes, translation, rotationQuaternion);
            }
          });
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
        rotation: vector.Vector4(0, 1, 0, 6.2832),
        name: sceneNode.name,
        canScale: false,
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
      surfaceDetected = true;
    });
    arObjectManager!.onNodeTap = (tappedNodes) {
      tappedNodes.forEach((nodeName) {
        String question =
            questionAnswerPairs[currentQuestionIndex]['question']!;
        String answer = questionAnswerPairs[currentQuestionIndex]['answer']!;

        if (nodeName == answer) {
          _showDiscussion(
            context,
            nodeName,
            questionAnswerPairs[currentQuestionIndex]['discussion']!,
            questionAnswerPairs[currentQuestionIndex]['images'],
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

  void _showDiscussion(BuildContext context, String part, String discussion,
      List<Map<String, String>> images) {
    double dialogHeight;

    if (discussion.length > 200) {
      dialogHeight = 300.0;
    } else if (discussion.length > 100) {
      dialogHeight = 250.0;
    } else {
      dialogHeight = 200.0;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(part),
          content: SizedBox(
            height: dialogHeight,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(discussion),
                  SizedBox(height: 10),
                  ...images
                      .map((image) => Column(
                            children: [
                              Image.asset(image['path']!),
                              SizedBox(height: 5),
                              Text(
                                image['label']!,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ))
                      .toList(),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                if (currentQuestionIndex >= questionAnswerPairs.length) {
                  _showScore();
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
    if (finalScore < 0) finalScore = 0;
    String passOrFail = finalScore >= 3 ? 'Passed' : 'Failed';

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
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Ecosystem_TLA_6_4()),
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
