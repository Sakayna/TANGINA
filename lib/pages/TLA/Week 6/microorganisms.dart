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
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MaterialApp(home: ModuleScreen6()));
}

class SceneNode {
  final String name;
  final String modelPath;
  final vector.Vector3 position;
  final vector.Vector3 scale;
  final vector.Vector4 rotation;
  final String description;

  SceneNode({
    required this.name,
    required this.modelPath,
    required this.position,
    required this.scale,
    required this.rotation,
    required this.description,
  });
}

class ModuleScreen6 extends StatefulWidget {
  @override
  _ModuleScreen6Page createState() => _ModuleScreen6Page();
}

class _ModuleScreen6Page extends State<ModuleScreen6> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  ARLocationManager? arLocationManager;
  bool surfaceDetected = false;
  bool modelPlaced = false;
  int currentTextStep = 0;
  ARNode? activeNode;
  ARHitTestResult? lastHitTestResult;
  int currentPageIndex = 0;
  int correctCount = 0;
  int wrongCount = 0;
  bool isFollowUpQuestionVisible = false;
  bool isExplanationVisible = false;
  bool isNameQuestionVisible = true;
  bool isScoreVisible = false; // Controls score and exit button visibility
  String feedbackMessage = '';
  String currentQuestion = "Which bacteria is used here?";
  int currentNodeIndex = 0;
  List<String> finishedBacteria = [];
  List<String> randomizedBacteriaNames = [];

  final vector.Vector3 fixedPosition = vector.Vector3(0.0, -0.3, -1.0);
  final vector.Quaternion fixedRotation = vector.Quaternion(0, 0, 0, 1);

  final List<SceneNode> microorganismNodes = [
    SceneNode(
      name: "Lactobacillus",
      modelPath: "assets/lesson6/cheese/cheese.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description:
          "Cheese (Lactobacillus): Lactobacillus is a beneficial bacterium used in the production of cheese.",
    ),
    SceneNode(
      name: "Saccharomyces cerevisiae",
      modelPath: "assets/lesson6/bread/bread.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description:
          "Bread (Saccharomyces cerevisiae): Saccharomyces cerevisiae is a yeast used in baking bread.",
    ),
    SceneNode(
      name: "Penicillin",
      modelPath: "assets/lesson6/pill/pill.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description:
          "Medicine (Penicillin): Penicillin is an antibiotic derived from Penicillium mold, used to treat bacterial infections.",
    ),
    SceneNode(
      name: "Salmonella",
      modelPath: "assets/lesson6/raw/rawchicken.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description:
          "Raw Chicken (Salmonella): Salmonella is a harmful bacterium often found in raw or undercooked chicken, causing food poisoning.",
    ),
    SceneNode(
      name: "Campylobacter",
      modelPath: "assets/lesson6/meat/meat.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description:
          "Contaminated Meat (Campylobacter): Campylobacter is a harmful bacterium found in contaminated meat, leading to severe gastrointestinal illness.",
    ),
    SceneNode(
      name: "Mycobacterium tuberculosis",
      modelPath: "assets/lesson6/tb/tb.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description:
          "TB (Mycobacterium tuberculosis): Mycobacterium tuberculosis is a harmful bacterium that causes tuberculosis.",
    ),
  ];

  bool showNodeDescription = true;
  Timer? debounceTimer;
  bool isChangingNode = false;

  @override
  void initState() {
    super.initState();
    randomizedBacteriaNames =
        microorganismNodes.map((node) => node.name).toList();
    randomizedBacteriaNames.shuffle(); // Shuffle names for randomization
  }

  @override
  void dispose() {
    try {
      // Dispose AR session manager
      arSessionManager?.dispose();

      // Cancel any running timers
      debounceTimer?.cancel();

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
      // Clear active nodes
      if (activeNode != null) {
        arObjectManager?.removeNode(activeNode!);
        activeNode = null;
      }

      // Clear AR nodes list
      microorganismNodes.clear();

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
      appBar: AppBar(
        title: Text(
          'Correct: $correctCount | Wrong: $wrongCount',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
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
                    'Scan the surface and tap the screen to place the model.',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          if (modelPlaced && currentTextStep == 0)
            buildIntroductionText(
              'Welcome to the Microorganism Exploration!',
              'In this module, you will explore various microorganisms and learn about their beneficial and harmful effects. Interact with 3D models to discover how these tiny organisms impact our world.',
              () {
                setState(() {
                  currentTextStep = 1;
                });
              },
            ),
          if (modelPlaced && currentTextStep == 1)
            buildIntroductionText(
              'Understanding Microorganisms',
              'Microorganisms can be both beneficial and harmful. In this activity, you will examine different microorganisms and identify their roles in various contexts, such as food production, medicine, and health.',
              () {
                setState(() {
                  currentTextStep = 2;
                });
              },
            ),
          if (currentTextStep == 2)
            Positioned(
              bottom: 150,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: microorganismNodes.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                onModelButtonScrolled(
                                    microorganismNodes[index]);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            child: Text(microorganismNodes[index].name),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Proceed with the next activity',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentTextStep = 3;
                        showNodeDescription = false;
                      });
                    },
                    child: Text('Next Activity'),
                  ),
                ],
              ),
            ),
          if (currentTextStep == 3) buildActivityIntroduction(),
          if (currentTextStep == 4) buildQuestionWidget(),
          if (isScoreVisible)
            buildScoreWidget(), // Display score and exit button
        ],
      ),
    );
  }

  Widget buildIntroductionText(
      String title, String content, VoidCallback onNext) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                content,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: onNext,
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildActivityIntroduction() {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Introduction to the Next Activity',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'In this activity, you will analyze different microorganisms and determine whether their characteristics are beneficial or harmful. Follow the instructions carefully to complete the activity.',
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
                    currentTextStep = 4;
                    showQuestionForFirstModel();
                  });
                },
                child: Text('Start Activity'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuestionWidget() {
    return Positioned(
      bottom: 150,
      left: 0,
      right: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isNameQuestionVisible)
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.black54,
                  child: Text(
                    'Which bacteria is used here?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 10.0,
                  children: randomizedBacteriaNames.map((name) {
                    bool isFinished = finishedBacteria.contains(name);
                    return ElevatedButton(
                      onPressed:
                          isFinished ? null : () => checkNameAnswer(name),
                      child: Text(name),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isFinished ? Colors.grey : Colors.white,
                        foregroundColor: Colors.black,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          if (isFollowUpQuestionVisible)
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.black54,
                  child: Text(
                    'Is this microorganism beneficial or harmful?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    checkAnswer("Beneficial");
                  },
                  child: Text('Beneficial'),
                ),
                ElevatedButton(
                  onPressed: () {
                    checkAnswer("Harmful");
                  },
                  child: Text('Harmful'),
                ),
              ],
            ),
          if (isExplanationVisible)
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.black54,
                  child: Text(
                    feedbackMessage,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      moveToNextNode();
                    });
                  },
                  child: Text('Next'),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget buildScoreWidget() {
    int totalScore =
        max(correctCount - wrongCount, 0); // Ensuring the score is not below 0
    return Center(
      child: Container(
        color: Colors.black54,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'All questions completed!',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Your total score is $totalScore.\n${totalScore >= 3 ? "You passed!" : "You did not pass."}',
              style: TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Exit the activity
              },
              child: Text('Exit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkNameAnswer(String name) {
    if (name == microorganismNodes[currentNodeIndex].name) {
      setState(() {
        isNameQuestionVisible = false;
        isFollowUpQuestionVisible = true;
        correctCount++;
        finishedBacteria.add(name);
      });
    } else {
      setState(() {
        wrongCount++;
      });
    }
  }

  void checkAnswer(String answer) {
    String correctAnswer =
        (microorganismNodes[currentNodeIndex].name == "Lactobacillus" ||
                microorganismNodes[currentNodeIndex].name ==
                    "Saccharomyces cerevisiae" ||
                microorganismNodes[currentNodeIndex].name == "Penicillin")
            ? "Beneficial"
            : "Harmful";

    if (answer == correctAnswer) {
      setState(() {
        correctCount++;
        feedbackMessage =
            "Correct! ${microorganismNodes[currentNodeIndex].description}";
        isFollowUpQuestionVisible = false;
        isExplanationVisible = true;
      });
    } else {
      setState(() {
        wrongCount++;
        feedbackMessage = "Wrong! Try again.";
      });
    }
  }

  void moveToNextNode() {
    setState(() {
      if (activeNode != null) {
        arObjectManager?.removeNode(activeNode!);
        activeNode = null;
      }

      if (currentNodeIndex < microorganismNodes.length - 1) {
        currentNodeIndex++;
        isNameQuestionVisible = true;
        isFollowUpQuestionVisible = false;
        isExplanationVisible = false;
        showQuestionForFirstModel();
      } else {
        isScoreVisible = true; // Display score after all questions
        isNameQuestionVisible = false;
        isFollowUpQuestionVisible = false;
        isExplanationVisible = false;
      }
    });
  }

  void onModelButtonScrolled(SceneNode selectedNode) async {
    if (isChangingNode) return;
    isChangingNode = true;

    if (activeNode != null) {
      await arObjectManager?.removeNode(activeNode!);
      activeNode = null;
    }

    await placeNode(selectedNode, fixedPosition, fixedRotation);
    isChangingNode = false;
  }

  Future<void> placeNode(SceneNode sceneNode, vector.Vector3 position,
      vector.Quaternion rotation) async {
    try {
      if (activeNode != null) {
        await arObjectManager?.removeNode(activeNode!);
        activeNode = null;
      }

      var newNode = ARNode(
        type: NodeType.localGLTF2,
        uri: sceneNode.modelPath,
        scale: sceneNode.scale,
        position: position,
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
      }
    } catch (e) {
      arSessionManager?.onError("Failed to add model: $e");
    }
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

    this.arObjectManager!.onNodeTap = onNodeTap;

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
          placeNode(microorganismNodes[0], fixedPosition, fixedRotation);
        }
      }
    };
  }

  void onNodeTap(List<String> nodeNames) {
    if (nodeNames.isNotEmpty && showNodeDescription) {
      String tappedNodeName = nodeNames.first;
      SceneNode? tappedNode = microorganismNodes.firstWhere(
          (node) => node.name == tappedNodeName,
          orElse: () => microorganismNodes[0]);

      if (tappedNode != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(tappedNode.name),
              content: Text(tappedNode.description),
              actions: [
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
      }
    }
  }

  void showQuestionForFirstModel() {
    placeNode(
        microorganismNodes[currentNodeIndex], fixedPosition, fixedRotation);
  }
}
