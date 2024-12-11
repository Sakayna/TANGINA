import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_TLA/Ecosystem_TLA_6_3.dart';
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
  runApp(MaterialApp(home: ModuleScreen11()));
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

class ModuleScreen11 extends StatefulWidget {
  @override
  _ModuleScreen11Page createState() => _ModuleScreen11Page();
}

class _ModuleScreen11Page extends State<ModuleScreen11> {
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

  List<Map<String, String>> questionAnswerPairs = [
    {
      "question":
          "What happens if the tree is cut down? Tap on the tree to view the changes in population.",
      "answer": "Cutting down trees",
      "discussion":
          "Cutting down the tree removes the habitat and food source for many species. This impacts animals like deer, bison, and mice, who rely on trees and plants for shelter and sustenance.",
      "image": "assets/lesson11/for image/deforestation.jpg",
    },
    {
      "question":
          "What happens to the bison if there is less vegetation? Tap on the bison to view the changes in population.",
      "answer": "Bison",
      "discussion":
          "Bison depend on grasses and plants for food. A decline in vegetation due to deforestation or other factors could lead to a decrease in the bison population, affecting predators like wolves that rely on them.",
      "image": "assets/lesson11/for image/bizon.jpg",
    },
    {
      "question":
          "What happens to wolves if the bison population decreases? Tap on the wolf to view the changes in population.",
      "answer": "Wolf",
      "discussion":
          "Wolves prey on bison. If the bison population declines, wolves may struggle to find enough food, leading to a decline in their population as well.",
      "image":
          "assets/lesson11/for image/wolf vs bison.jpg", // Assuming the wolf model path is this
    },
    {
      "question":
          "What happens to the deer when trees and plants are removed? Tap on the deer to view the changes in population.",
      "answer": "Deer",
      "discussion":
          "With fewer trees and plants, deer have less food, leading to a potential decline in their population. This also affects predators like foxes that depend on deer.",
      "image": "assets/lesson11/for image/deer dead.jpeg",
    },
    {
      "question":
          "What happens to mice if there is less vegetation? Tap on the mice to view the changes in population.",
      "answer": "Mice",
      "discussion":
          "The decline in trees and plants also affects mice, as they lose their food and shelter. This impacts predators like foxes who rely on mice for food.",
      "image": "assets/lesson11/for image/daga.jpg",
    },
    {
      "question":
          "What happens to foxes if their prey, like mice and deer, declines? Tap on the fox to view the changes in population.",
      "answer": "Fox",
      "discussion":
          "Foxes rely on mice and deer for food. If these populations decline, foxes may struggle to find enough food, potentially leading to a decline in the fox population.",
      "image": "assets/lesson11/for image/what does the fox say_.jpg",
    },
    {
      "question":
          "What happens if bees disappear? Tap on the bee to view the changes in population.",
      "answer": "Bee",
      "discussion":
          "Bees are crucial for pollinating many plants. If bees disappear, these plants cannot reproduce, leading to a decline in plant populations, which impacts the entire food web, including herbivores like deer and bison, and their predators.",
      "image": "assets/lesson11/for image/jollibee.jpeg",
    },
    {
      "question":
          "What happens to plants if the mouse population increases? Tap on the plants to view the changes in population.",
      "answer": "Plants",
      "discussion":
          "If the mouse population increases due to fewer predators like foxes, they may overconsume the plants, leading to a decline in vegetation. This disrupts the food supply for herbivores like deer and bison.",
      "image": "assets/lesson11/for image/vegetarian jerry.jpg",
    },
    {
      "question":
          "What happens to the ecosystem if fish populations are overfished? Tap on the fish to view the changes in population.",
      "answer": "Overfishing",
      "discussion":
          "Overfishing reduces fish populations, affecting aquatic predators that rely on them. This disrupts the marine ecosystem, leading to broader ecological consequences.",
      "image": "assets/lesson11/for image/seafood lover.jpg",
    },
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
                          'Introduction to Population Dynamics',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'In this module, you will learn about how changes in population can affect ecosystems. Pay attention to the models and try to answer the questions correctly. Good luck!',
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
                    String buttonText = questionAnswerPairs[index]['answer']!;
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
              // Add display-only nodes for Mountain, Cloud, and Sun
              List<SceneNode> displayNodes = [
                SceneNode(
                  name: "Mountain",
                  modelPath: "assets/lesson9/mountain/mountainers.gltf",
                  position: vector.Vector3(
                      -0.1, 0.02, -0.5), // Moved to the left and backwards
                  scale: vector.Vector3(0.3, 0.3, 0.3),
                ),
                SceneNode(
                  name: "Cloud",
                  modelPath: "assets/lesson9/cloudy/clouderistss.gltf",
                  position: vector.Vector3(0.3, 0.25, -0.3), // Floating above
                  scale: vector.Vector3(0.15, 0.15, 0.15),
                ),
                SceneNode(
                  name: "Sun",
                  modelPath: "assets/lesson9/sun/sunny.gltf",
                  position:
                      vector.Vector3(0.35, 0.4, -0.3), // Positioned in the sky
                  scale: vector.Vector3(0.15, 0.15, 0.15),
                ),
              ];

              List<SceneNode> interactiveNodes = [
                SceneNode(
                  name: "Cutting down trees",
                  modelPath: "assets/lesson11/tree/tree.gltf",
                  position: vector.Vector3(
                      -0.2, 0.02, -0.05), // Moved slightly backward
                  scale: vector.Vector3(0.10, 0.10, 0.10),
                ),
                SceneNode(
                  name: "Bison",
                  modelPath: "assets/lesson11/bison/bison.gltf",
                  position: vector.Vector3(
                      0.1, 0.02, 0.0), // Moved further to the left
                  scale: vector.Vector3(0.02, 0.02, 0.02),
                ),
                SceneNode(
                  name: "Wolf",
                  modelPath: "assets/lesson11/wolf/wolf.gltf",
                  position: vector.Vector3(0.0, 0.02,
                      -0.05), // Moving the wolf further to the right and forward
                  scale: vector.Vector3(0.05, 0.05, 0.05),
                ),
                SceneNode(
                  name: "Deer",
                  modelPath: "assets/lesson11/deer/deer.gltf",
                  position: vector.Vector3(0.05, 0.02,
                      0.0), // Moving the deer further to the right and forward
                  scale: vector.Vector3(0.05, 0.05, 0.05),
                ),
                SceneNode(
                  name: "Mice",
                  modelPath: "assets/lesson11/mice/mouse.gltf",
                  position: vector.Vector3(0.15, 0.02,
                      -0.1), // Positioning the wolf on the left side of the deer
                  scale: vector.Vector3(0.01, 0.01, 0.01),
                ),
                SceneNode(
                  name: "Fox",
                  modelPath: "assets/lesson11/fox/fox.gltf",
                  position: vector.Vector3(
                      0.2, 0.02, -0.1), // To the left of the fish
                  scale: vector.Vector3(0.05, 0.05, 0.05),
                ),
                SceneNode(
                  name: "Bee",
                  modelPath: "assets/lesson11/bee/bee.gltf",
                  position: vector.Vector3(0.15, 0.15, 0.0),
                  scale: vector.Vector3(0.03, 0.03, 0.03),
                ),
                SceneNode(
                  name: "Plants",
                  modelPath: "assets/lesson11/grass/grass.gltf",
                  position: vector.Vector3(
                      0.35, 0.02, 0.0), // Moved slightly to the right
                  scale: vector.Vector3(0.05, 0.05, 0.05),
                ),
                SceneNode(
                  name: "Overfishing",
                  modelPath: "assets/lesson11/fish/fish.gltf",
                  position: vector.Vector3(
                      0.3, 0.02, -0.25), // Moved to the left and backwards
                  scale: vector.Vector3(0.12, 0.12, 0.12),
                ),
              ];

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
            questionAnswerPairs[currentQuestionIndex]['image']!,
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

  void _showDiscussion(
      BuildContext context, String part, String discussion, String imagePath) {
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
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Ecosystem_TLA_6_3()),
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
