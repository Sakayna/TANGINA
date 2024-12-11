import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_TLA/Animal_and_Plant_Cells_TLA_3_2.dart';
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
  runApp(MaterialApp(home: ModuleScreen5()));
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

class ModuleScreen5 extends StatefulWidget {
  @override
  _ModuleScreen5Page createState() => _ModuleScreen5Page();
}

class _ModuleScreen5Page extends State<ModuleScreen5> {
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
  List<bool> unlockedButtons = List.filled(16, false);
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
          "Why are cells considered the functional units of life? Tap to answer.",
      "answer": "Cell",
      "definition":
          "Cells are considered the functional units of life because they perform all the essential functions that define life. Each cell operates as an independent system, maintaining its internal environment while interacting with its surroundings.",
      "image": "assets/lesson5/cell parts/model images/cellimage3.png",
    },
    {
      "question":
          "Identify the structure responsible for providing mechanical support in plant cells. Tap to answer.",
      "answer": "Cell Wall",
      "definition":
          "Structure: It is a nonliving component composed of cellulose, a polysaccharide.\n\nFunction: Provides mechanical support and maintains cell shape in plant cells.",
      "image": "assets/lesson5/images/cellwall.jpg",
    },
    {
      "question":
          "Why is the plasma membrane selectively permeable? Tap to answer.",
      "answer": "Plasma Membrane",
      "definition":
          "Structure: It is flexible and elastic. It is composed of double layers of phospholipid, proteins, carbohydrates, and steroids.\n\nFunction: Selectively permeable; regulates the entry and exit of materials like ions and organic molecules.",
      "image": "assets/lesson5/images/plasma membreane.png",
    },
    {
      "question":
          "Which part of the cell provides energy for cellular activities? Tap to answer.",
      "answer": "Mitochondrion",
      "definition":
          "Structure: It is a double-membrane structure. The inner membrane is folded forming cristae. It is referred to as the powerhouse of the cell.\n\nFunction: Provides energy for the cell in the form of Adenosine Triphosphate (ATP).",
      "image": "assets/lesson5/images/Mitochondria.png",
    },
    {
      "question":
          "Which cell part functions as storage for water, food, or waste? Tap to answer.",
      "answer": "Vacuole",
      "definition":
          "Structure: A compartment covered by a single membrane called tonoplast.\n\nFunction: Stores water, food, or waste for the cells.",
      "image": "assets/lesson5/images/vacuole.jpg",
    },
    {
      "question":
          "Which organelle sorts, packages, and modifies proteins? Tap to answer.",
      "answer": "Golgi Apparatus",
      "definition":
          "Structure: Consists of stacks of single membranes that are connected to the plasma membrane and endoplasmic reticulum.\n\nFunction: Sorts, packages, and modifies proteins for secretion.",
      "image": "assets/lesson5/images/golgi.jpg",
    },
    {
      "question":
          "What is the matrix of different cellular organelles? Tap to answer.",
      "answer": "Cytoplasm",
      "definition":
          "Structure: The complex fluid that fills the cell. The outer cytoplasm (exoplasm) is gel-like, while the inner cytoplasm is fluid (sol-like). The fluid part is capable of streaming (cyclosis).\n\nFunction: Matrix of the different cellular organelles; distribution of materials throughout the cell due to cyclosis.",
      "image": "assets/lesson5/images/cytoplasm.jpg",
    },
    {
      "question":
          "What separates nuclear contents from the cytoplasm? Tap to answer.",
      "answer": "Nuclear Membrane",
      "definition":
          "Structure: It is a double-layered membrane that encloses the nucleus. The outer membrane is porous.\n\nFunction: Separates the nuclear contents from the contents of the cytoplasm.",
      "image": "assets/lesson5/images/nuclear membrane.png",
    },
    {
      "question": "What synthesizes RNA and produces ribosomes? Tap to answer.",
      "answer": "Nucleolus",
      "definition":
          "Structure: It is the dense, spherical body inside the nucleus. It contains the nucleic acid RNA.\n\nFunction: Synthesis of RNA and production of ribosomes.",
      "image": "assets/lesson5/images/nucleolus.png",
    },
    {
      "question":
          "What is the matrix of chromosomes and the nucleolus? Tap to answer.",
      "answer": "Nucleoplasm",
      "definition":
          "Structure: It is the gel-like material that fills the nucleus.\n\nFunction: Functions as the matrix of the chromosomes and nucleolus.",
      "image": "assets/lesson5/images/Nucleoplasm.jpg",
    },
    {
      "question":
          "What carries genes responsible for hereditary characteristics? Tap to answer.",
      "answer": "Chromosomes",
      "definition":
          "Structure: They are highly coiled structures that form a network over the nucleoplasm.\n\nFunction: Carriers of genes responsible for transmitting hereditary characteristics.",
      "image": "assets/lesson5/images/chromosomes.jpg",
    },
    {
      "question":
          "What directs and coordinates all cellular activities? Tap to answer.",
      "answer": "Nucleus",
      "definition":
          "Structure: It is the spherical body that is composed of organelles 7 to 10.\n\nFunction: The control center of the cell; directs and coordinates all cellular activities.",
      "image": "assets/lesson5/images/nucleus.jpg",
    },
    {
      "question":
          "What plays an important role in forming the skeletal framework? Tap to answer.",
      "answer": "Endoplasmic Reticulum",
      "definition":
          "Structure: It is the network of channels composed of a single-membrane that may be bumpy if it contains ribosomes (Rough ER) or smooth (SER) if it does not contain ribosomes.\n\nFunction: They play an important role in the formation of the skeletal framework.",
      "image": "assets/lesson5/images/endoplasmic reticulum.jpg",
    },
    {
      "question":
          "Which organelle provides the green color of plants and functions for photosynthesis? Tap to answer.",
      "answer": "Chloroplastid",
      "definition":
          "Structure: It is the double-membrane structure that contains chlorophyll pigments.\n\nFunction: Provides the green color of plants; functions for photosynthesis.",
      "image": "assets/lesson5/images/Chloroplast.jpg",
    },
    {
      "question":
          "What forms spindle fibers during cell division? Tap to answer.",
      "answer": "Centrioles",
      "definition":
          "Structure: They are two small rods that lie at right angles to each other. Each rod is surrounded with tiny microtubules arranged like the spokes of a wheel.\n\nFunction: Formation of spindle fibers during cell division; function as the anchor for the cytoskeletons.",
      "image": "assets/lesson5/images/centriole.jpg",
    },
    {
      "question":
          "What simplifies or breaks down complex materials? Tap to answer.",
      "answer": "Lysosome",
      "definition":
          "Structure: It is a single membrane compartment containing powerful hydrolytic enzymes.\n\nFunction: Simplifies/Breaks down complex materials.",
      "image": "assets/lesson5/images/lysosome.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    // Ensure the first question is always about the cell
    var firstQuestion = questionAnswerPairs.removeAt(0);
    questionAnswerPairs.shuffle(Random());
    questionAnswerPairs.insert(0, firstQuestion);
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
                          'Introduction to the AR Cell Learning Module',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'In this module, you will learn about the different parts of a cell. Pay attention to the models and try to answer the questions correctly. Good luck!',
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
                          'You will be asked a series of questions related to the parts of a cell. Tap on the corresponding model to answer each question. If you answer incorrectly, it will be counted. Try your best to get them all right!',
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
                  itemCount: 15,
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

          // Add the table node
          var tableNode = ARNode(
            type: NodeType.localGLTF2,
            uri: "assets/lesson5/organelles/table.gltf",
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

// Add the nucleus parts node
              var nucleusPartsNode = ARNode(
                type: NodeType.localGLTF2,
                uri: "assets/lesson5/organelles/nucleusparts1.gltf",
                scale: vector.Vector3(
                    0.10, 0.10, 0.10), // Shortened scale for nucleus parts
                position: vector.Vector3(
                  translation.x + 0.20, // Moved slightly to the right

                  translation.y,
                  translation.z - 0.45,
                ),
                rotation: vector.Vector4(0, 1, 0, 0),
                name: "nucleusParts",
                canScale: false,
              );

              arObjectManager!
                  .addNode(nucleusPartsNode)
                  .then((didAddNucleusPartsNode) {
                if (didAddNucleusPartsNode!) {
                  nodes.add(nucleusPartsNode);
                }
              });

              arObjectManager!
                  .addNode(nucleusPartsNode)
                  .then((didAddNucleusPartsNode) {
                if (didAddNucleusPartsNode!) {
                  nodes.add(nucleusPartsNode);
                }
              });

              // Updated sceneNodes list
              List<SceneNode> sceneNodes = [
                // Cell1.gltf (first question, not randomized)
                SceneNode(
                  name: "Cell",
                  modelPath: "assets/lesson5/organelles/cell1.gltf",
                  position:
                      vector.Vector3(-0.10, 0.02, -0.45), // Moved downwards

                  scale: vector.Vector3(0.2, 0.2, 0.2),
                ),

                // Row 1
                SceneNode(
                  name: "Cell Wall",
                  modelPath: "assets/lesson5/organelles/cellwall1.gltf",
                  position: vector.Vector3(-0.15, 0.05, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Plasma Membrane",
                  modelPath: "assets/lesson5/organelles/plasma1.gltf",
                  position: vector.Vector3(-0.05, 0.05, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Mitochondrion",
                  modelPath: "assets/lesson5/organelles/mitochondria1.gltf",
                  position: vector.Vector3(0.05, 0.05, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Vacuole",
                  modelPath: "assets/lesson5/organelles/vacuole1.gltf",
                  position: vector.Vector3(0.15, 0.05, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Golgi Apparatus",
                  modelPath: "assets/lesson5/organelles/golgi1.gltf",
                  position: vector.Vector3(0.25, 0.05, -0.15),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),

                // Row 2
                SceneNode(
                  name: "Cytoplasm",
                  modelPath: "assets/lesson5/organelles/cytoplasm1.gltf",
                  position: vector.Vector3(-0.15, 0.05, -0.05),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Nuclear Membrane",
                  modelPath: "assets/lesson5/organelles/nuclearmembrane1.gltf",
                  position: vector.Vector3(-0.05, 0.05, -0.05),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Nucleolus",
                  modelPath: "assets/lesson5/organelles/nucleolus1.gltf",
                  position: vector.Vector3(0.05, 0.05, -0.05),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Nucleoplasm",
                  modelPath: "assets/lesson5/organelles/nucleoplasm1.gltf",
                  position: vector.Vector3(0.15, 0.05, -0.05),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Chromosomes",
                  modelPath: "assets/lesson5/organelles/dna4.gltf",
                  position: vector.Vector3(0.25, 0.05, -0.05),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),

                // Row 3
                SceneNode(
                  name: "Nucleus",
                  modelPath: "assets/lesson5/organelles/nucleus4.gltf",
                  position: vector.Vector3(-0.15, 0.05, 0.05),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Endoplasmic Reticulum",
                  modelPath: "assets/lesson5/organelles/ER1.gltf",
                  position: vector.Vector3(-0.05, 0.05, 0.05),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Chloroplastid",
                  modelPath: "assets/lesson5/organelles/chloroplast1.gltf",
                  position: vector.Vector3(0.05, 0.05, 0.05),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Centrioles",
                  modelPath: "assets/lesson5/organelles/centrioles1.gltf",
                  position: vector.Vector3(0.15, 0.05, 0.05),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Lysosome",
                  modelPath: "assets/lesson5/organelles/lysosome1.gltf",
                  position: vector.Vector3(0.25, 0.05, 0.05),
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
              ];

              loadModels(sceneNodes, translation, rotationQuaternion);
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
          _showDefinition(
            context,
            nodeName,
            questionAnswerPairs[currentQuestionIndex]['definition']!,
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

  void _showDefinition(
      BuildContext context, String part, String definition, String imagePath) {
    double dialogHeight;

    if (definition.length > 200) {
      dialogHeight = 300.0;
    } else if (definition.length > 100) {
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
                  MaterialPageRoute(
                      builder: (context) => Animal_and_Plant_TLA_3_2()),
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
