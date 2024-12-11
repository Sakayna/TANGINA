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

void main() {
  runApp(MaterialApp(home: ModuleScreen10()));
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

class ModuleScreen10 extends StatefulWidget {
  @override
  _ModuleScreen10Page createState() => _ModuleScreen10Page();
}

class _ModuleScreen10Page extends State<ModuleScreen10> {
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
  int currentNodeIndex = 0;
  bool isInteractionIdentified = false;
  bool isLoading = false;
  int correctAnswers = 0;
  int wrongAnswers = 0;

  final vector.Vector3 centerPosition = vector.Vector3(0.0, -0.3, -1.0);
  final vector.Vector3 rightPosition = vector.Vector3(0.4, -0.3, -1.0);
  final vector.Vector3 leftPosition = vector.Vector3(-0.4, -0.3, -1.0);
  final vector.Quaternion fixedRotation = vector.Quaternion(0, 0, 0, 1);

  final List<SceneNode> ecologicalNodes = [
    SceneNode(
      name: "Predation",
      modelPath: "assets/lesson10/predation/predation.gltf",
      position: vector.Vector3(0.0, -0.3, -1.0),
      scale: vector.Vector3(0.5, 0.5, 0.5),
      rotation: vector.Vector4(0, 1, 0, 0),
      description:
          "Predation is an interaction where one organism, the predator, hunts and consumes another organism, the prey.",
    ),
    SceneNode(
      name: "Mutualism",
      modelPath: "assets/lesson10/mutualism/mutualism.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description:
          "Mutualism is an interaction where both organisms benefit from the relationship.",
    ),
    SceneNode(
      name: "Parasitism",
      modelPath: "assets/lesson10/parasitism/parasitism.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description:
          "Parasitism is an interaction where one organism, the parasite, benefits at the expense of another organism, the host.",
    ),
    SceneNode(
      name: "Commensalism",
      modelPath: "assets/lesson10/commensalism/commesalism.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description:
          "Commensalism is an interaction where one organism benefits while the other is neither helped nor harmed.",
    ),
    SceneNode(
      name: "Competition",
      modelPath: "assets/lesson10/competition/competition.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description:
          "Competition is an interaction where organisms compete for the same resource, such as food or territory.",
    ),
  ];

  final List<SceneNode> animalNodes = [
    SceneNode(
      name: "Lion",
      modelPath: "assets/lesson10/lion/lion.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description: "Lion is a large carnivorous feline found in Africa.",
    ),
    SceneNode(
      name: "Deer",
      modelPath: "assets/lesson11/deer/deer.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description: "Deer is a herbivorous mammal known for its antlers.",
    ),
    SceneNode(
      name: "Dog",
      modelPath: "assets/lesson10/dog/dog.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description:
          "Dog is a domesticated carnivorous mammal that typically has a long snout.",
    ),
    SceneNode(
      name: "Hyena",
      modelPath: "assets/lesson10/hyena/hyena.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description:
          "Hyena is a carnivorous mammal known for its scavenging habits.",
    ),
    SceneNode(
      name: "Remora Fish", // Renamed to Remora Fish
      modelPath: "assets/lesson10/fish/fish.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description:
          "Remora Fish is a small fish that attaches to larger marine animals for transport and food.",
    ),
    SceneNode(
      name: "Tick",
      modelPath: "assets/lesson10/tick/tick.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description:
          "Tick is a small arachnid that is parasitic and often found on mammals.",
    ),
    SceneNode(
      name: "Shark",
      modelPath: "assets/lesson10/shark/shark.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description: "Shark is a large predatory fish known for its sharp teeth.",
    ),
    SceneNode(
      name: "Flower",
      modelPath: "assets/lesson7/chicken/flower1.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description:
          "A flower represents plant life and is often associated with pollination.",
    ),
    SceneNode(
      name: "Bee",
      modelPath: "assets/lesson11/bee/bee.gltf",
      position: vector.Vector3(0.0, 0.0, 0.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
      description:
          "Bee is an insect known for pollination and producing honey.",
    ),
  ];

  List<ARNode> activeNodes = [];
  bool showNodeDescription = true;
  Timer? debounceTimer;
  bool isChangingNode = false;
  String? activeNodeName;
  List<String> selectedAnimals = [];

  @override
  void initState() {
    super.initState();
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
      activeNodes.forEach((node) async {
        await arObjectManager?.removeNode(node);
      });
      activeNodes.clear();

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
          'Correct: $correctAnswers | Wrong: $wrongAnswers',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
        backgroundColor: Colors.black, // Set the background color to black
        iconTheme: IconThemeData(
            color: Colors.white), // Set the back button color to white
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
                    'Scan the surface and Tap the screen to place the model',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (modelPlaced && currentTextStep == 0 && !isLoading)
            buildIntroductionText(
              'Welcome to the AR Learning Module!',
              'Explore various ecological interactions through immersive 3D models and learn about their characteristics.',
              () {
                setState(() {
                  currentTextStep = 1;
                });
              },
            ),
          if (modelPlaced && currentTextStep == 1 && !isLoading)
            buildIntroductionText(
              'Introduction to Ecological Interactions',
              'In this module, you will explore 3D models representing different types of ecological interactions. This interactive experience will help you understand how organisms interact with each other and their environments.',
              () {
                setState(() {
                  currentTextStep = 2;
                });
              },
            ),
          if (currentTextStep == 2 && !isLoading)
            Positioned(
              bottom: 150,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'Select an Ecological Interaction:',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  buildEcologicalButtons(),
                  SizedBox(height: 20),
                  Text(
                    'Proceed with the next activity',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                        removeAllNodes();
                        Future.delayed(Duration(seconds: 2), () {
                          setState(() {
                            currentTextStep = 3;
                            showNodeDescription = false;
                            isLoading = false;
                          });
                        });
                      });
                    },
                    child: Text('Next Activity'),
                  ),
                ],
              ),
            ),
          if (currentTextStep == 3 && !isLoading) buildActivityIntroduction(),
          if ((currentTextStep >= 4 && currentTextStep <= 8) && !isLoading)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  Text(
                    getQuestionText(),
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  buildButtonsActivity(),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      checkCorrectPair(selectedAnimals);
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String getQuestionText() {
    switch (currentTextStep) {
      case 4:
        return 'Choose two animals to form a predation pair:';
      case 5:
        return 'Choose two animals to form a mutualism pair:';
      case 6:
        return 'Choose two animals to form a parasitism pair:';
      case 7:
        return 'Choose two animals to form a commensalism pair:';
      case 8:
        return 'Choose three animals to form a competition pair:';
      default:
        return '';
    }
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

  Widget buildEcologicalButtons() {
    return Align(
      alignment: Alignment.centerRight,
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.center,
        children: List.generate(ecologicalNodes.length, (index) {
          return ElevatedButton(
            onPressed: () {
              onModelButtonScrolled(ecologicalNodes[index]);
            },
            child: Text(ecologicalNodes[index].name),
          );
        }),
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
                'Identify the Correct Ecological Interaction',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Select the correct animals based on the given ecological interaction, then click Submit.',
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

  Widget buildButtonsActivity() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      alignment: WrapAlignment.center,
      children: List.generate(animalNodes.length, (index) {
        return ElevatedButton(
          onPressed: () {
            toggleNode(animalNodes[index]);
          },
          child: Text(animalNodes[index].name),
        );
      }),
    );
  }

  void toggleNode(SceneNode node) async {
    if (selectedAnimals.contains(node.name)) {
      selectedAnimals.remove(node.name);
      await removeNodeByName(node.name);
    } else if ((selectedAnimals.length < 2 && currentTextStep != 8) ||
        (selectedAnimals.length < 3 && currentTextStep == 8)) {
      selectedAnimals.add(node.name);

      vector.Vector3 position;
      if (selectedAnimals.length == 1) {
        position = centerPosition;
      } else if (selectedAnimals.length == 2 && currentTextStep != 8) {
        position = rightPosition;
      } else if (selectedAnimals.length == 2 && currentTextStep == 8) {
        position = leftPosition;
      } else {
        position = rightPosition;
      }

      await placeNode(node, position, fixedRotation);
    }
  }

  void checkCorrectPair(List<String> selectedAnimals) async {
    bool isCorrect = false;

    if (currentTextStep == 4 &&
        selectedAnimals.length == 2 &&
        selectedAnimals.contains('Lion') &&
        selectedAnimals.contains('Deer')) {
      isCorrect = true;
      correctAnswers++;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Correct!'),
            content: Text(
                'Lion and Deer form a predation pair because the lion is a predator, and the deer is its prey.'),
            actions: [
              TextButton(
                child: Text('Next Question'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    resetForNextQuestion();
                    currentTextStep = 5;
                  });
                },
              ),
            ],
          );
        },
      );
    } else if (currentTextStep == 5 &&
        selectedAnimals.length == 2 &&
        selectedAnimals.contains('Bee') &&
        selectedAnimals.contains('Flower')) {
      isCorrect = true;
      correctAnswers++;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Correct!'),
            content: Text(
                'Bee and Flower form a mutualistic relationship where the bee gets nectar, and the flower gets pollinated.'),
            actions: [
              TextButton(
                child: Text('Next Question'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    resetForNextQuestion();
                    currentTextStep = 6;
                  });
                },
              ),
            ],
          );
        },
      );
    } else if (currentTextStep == 6 &&
        selectedAnimals.length == 2 &&
        selectedAnimals.contains('Dog') &&
        selectedAnimals.contains('Tick')) {
      isCorrect = true;
      correctAnswers++;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Correct!'),
            content: Text(
                'Dog and Tick form a parasitic relationship where the tick benefits by feeding on the dog\'s blood, and the dog is harmed.'),
            actions: [
              TextButton(
                child: Text('Next Question'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    resetForNextQuestion();
                    currentTextStep = 7;
                  });
                },
              ),
            ],
          );
        },
      );
    } else if (currentTextStep == 7 &&
        selectedAnimals.length == 2 &&
        selectedAnimals.contains('Shark') &&
        selectedAnimals.contains('Remora Fish')) {
      isCorrect = true;
      correctAnswers++;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Correct!'),
            content: Text(
                'Shark and Remora Fish represent a commensalism relationship where the fish benefits by gaining protection from the shark, while the shark is neither harmed nor benefited.'),
            actions: [
              TextButton(
                child: Text('Next Question'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    resetForNextQuestion();
                    currentTextStep = 8;
                  });
                },
              ),
            ],
          );
        },
      );
    } else if (currentTextStep == 8 &&
        selectedAnimals.length == 3 &&
        selectedAnimals.contains('Lion') &&
        selectedAnimals.contains('Deer') &&
        selectedAnimals.contains('Hyena')) {
      isCorrect = true;
      correctAnswers++;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Correct!'),
            content: Text(
                'Lion, Deer, and Hyena form a competition pair as they compete for the same resources like food or territory.'),
            actions: [
              TextButton(
                child: Text('See Results'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    showFinalScore();
                  });
                },
              ),
            ],
          );
        },
      );
    }

    if (!isCorrect) {
      setState(() {
        wrongAnswers++;
      });
      await removeSelectedNodes();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Incorrect'),
            content: Text('This is not the correct combination. Try again!'),
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

    selectedAnimals.clear();
  }

  void showFinalScore() {
    // Calculate the total score and ensure it doesn't go below zero
    int totalScore =
        (correctAnswers - wrongAnswers).clamp(0, double.infinity).toInt();

    // Determine if the user passed or failed
    String resultMessage;
    if (totalScore >= 3) {
      // Adjust the passing criteria as needed
      resultMessage = 'Congratulations! You passed.';
    } else {
      resultMessage = 'You did not pass. Better luck next time!';
    }

    // Display the final score with the pass/fail message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Final Score'),
          content: Text('Your total score is: $totalScore.\n\n$resultMessage'),
          actions: [
            TextButton(
              child: Text('Exit'),
              onPressed: () {
                Navigator.of(context).pop();
                exitActivity(); // Exit the activity
              },
            ),
          ],
        );
      },
    );
  }

  void exitActivity() {
    Navigator.of(context).pop();
  }

  void resetForNextQuestion() async {
    selectedAnimals.clear();
    await removeAllNodes();
    setState(() {
      modelPlaced = false;
    });
  }

  Future<void> removeSelectedNodes() async {
    for (var node in activeNodes) {
      if (selectedAnimals.contains(node.name)) {
        await arObjectManager?.removeNode(node);
      }
    }
    activeNodes.removeWhere((node) => selectedAnimals.contains(node.name));
  }

  Future<void> removeNodeByName(String nodeName) async {
    ARNode? nodeToRemove = activeNodes.firstWhere(
      (node) => node.name == nodeName,
      orElse: () => ARNode(
        type: NodeType.localGLTF2,
        uri: "",
        scale: vector.Vector3(0.0, 0.0, 0.0),
        position: vector.Vector3(0.0, 0.0, 0.0),
        rotation: vector.Vector4(0, 0, 0, 1),
        name: "",
        canScale: false,
      ),
    );

    if (nodeToRemove != null && nodeToRemove.name.isNotEmpty) {
      await arObjectManager?.removeNode(nodeToRemove);
      activeNodes.remove(nodeToRemove);
    }
  }

  Future<void> placeNode(SceneNode sceneNode, vector.Vector3 position,
      vector.Quaternion rotation) async {
    try {
      setState(() {
        isLoading = true;
      });
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
          activeNodes.add(newNode);
        });
      }
    } catch (e) {
      arSessionManager?.onError("Failed to add model: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> removeAllNodes() async {
    for (var node in activeNodes) {
      await arObjectManager?.removeNode(node);
    }
    activeNodes.clear();
  }

  void onModelButtonScrolled(SceneNode selectedNode) async {
    if (isChangingNode) return;
    isChangingNode = true;

    await removeAllNodes();
    await placeNode(selectedNode, leftPosition, fixedRotation);
    isChangingNode = false;
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
          placeNode(ecologicalNodes[0], leftPosition, fixedRotation);
        }
      }
    };
  }

  void onNodeTap(List<String> nodeNames) {
    if (nodeNames.isNotEmpty && showNodeDescription) {
      String tappedNodeName = nodeNames.first;
      SceneNode? tappedNode = ecologicalNodes.firstWhere(
          (node) => node.name == tappedNodeName,
          orElse: () => ecologicalNodes[0]);

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
    removeAllEcologicalNodes();
  }

  Future<void> removeAllEcologicalNodes() async {
    for (var node in ecologicalNodes) {
      await arObjectManager?.removeNode(ARNode(
        type: NodeType.localGLTF2,
        uri: node.modelPath,
        scale: node.scale,
        position: node.position,
        rotation: node.rotation,
        name: node.name,
        canScale: false,
      ));
    }
  }
}
