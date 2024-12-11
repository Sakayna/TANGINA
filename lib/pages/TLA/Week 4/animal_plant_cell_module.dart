import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_TLA/Animal_and_Plant_Cells_TLA_3_1.dart';
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
  runApp(MaterialApp(home: ModuleScreen4()));
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

class ModuleScreen4 extends StatefulWidget {
  @override
  _ModuleScreen4Page createState() => _ModuleScreen4Page();
}

class _ModuleScreen4Page extends State<ModuleScreen4> {
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
  int pairProgress = 0; // Track pair progress (e.g., 0/2, 1/2)
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

  List<Map<String, dynamic>> questionAnswerPairs = [
    // Plant Cell-Specific Organelles (Cell Wall)
    {
      "question":
          "Which structure is present only in the plant cell and is purple in color? Compare the organelles in the plant and animal cells.",
      "answers": ["Cell Wall"],
      "definition":
          "A rigid, protective layer outside the cell membrane made of cellulose. It provides structural support and protection to plant cells.",
      "buttonImages": ["assets/lesson4/png/plant/cellwall.png"],
      "discussionImages": ["assets/lesson4/plant2/Cell-Wall.png"]
    },

    // Plant Cell-Specific Organelles (Chloroplast)
    {
      "question":
          "Which green structure is present only in the plant cell and is responsible for photosynthesis? Compare the organelles in the plant and animal cells.",
      "answers": ["Chloroplast"],
      "definition":
          "Organelles that contain chlorophyll and carry out photosynthesis, converting sunlight into energy. Plastids also store pigments and other important substances in plant cells.",
      "buttonImages": ["assets/lesson4/png/plant/chloroplast.png"],
      "discussionImages": ["assets/lesson4/plant2/chloroplast.png"]
    },

    // Animal Cell-Specific Organelles (Centrioles)
    {
      "question":
          "Which structure is present only in the animal cell and is purple in color? Compare the organelles in the plant and animal cells.",
      "answers": ["Centrioles2"],
      "definition":
          "A cylindrical organelle composed of microtubules that plays a role in cell division by helping organize the mitotic spindle. Centrioles are key in forming cilia and flagella.",
      "buttonImages": ["assets/lesson4/png/animal/centrioles.png"],
      "discussionImages": ["assets/lesson4/animal2/centriole.jpg"]
    },

    // Cytoplasm
    {
      "question":
          "Which yellow, jelly-like substance is found in both plant and animal cells and holds the organelles in place?",
      "answers": ["Cytoplasm", "Cytoplasm2"],
      "definition":
          "The jelly-like substance inside the cell that surrounds the organelles. It provides a medium for chemical reactions and helps maintain cell structure.",
      "buttonImages": [
        "assets/lesson4/png/plant/cytoplasm.png",
        "assets/lesson4/png/animal/cytoplasm.png"
      ],
      "discussionImages": [
        "assets/lesson4/plant2/cytoplasm.jpg",
        "assets/lesson4/animal2/cytoplasm.jpg"
      ]
    },

    // Cell Membrane
    {
      "question":
          "Which structure controls the movement of substances in and out of both plant and animal cells and is green in plant cells but orange in animal cells?",
      "answers": ["Cell Membrane", "Cytoplasm2"],
      "definition":
          "A flexible, semi-permeable membrane that surrounds the cell, controlling the movement of substances in and out of the cell. It is composed of a lipid bilayer with embedded proteins.",
      "buttonImages": [
        "assets/lesson4/png/plant/cellmembrane.png",
        "assets/lesson4/png/animal/cell membrane.png"
      ],
      "discussionImages": [
        "assets/lesson4/plant2/cellmembrane.jpg",
        "assets/lesson4/animal2/cell membrane.jpg"
      ]
    },

    // Ribosomes
    {
      "question":
          "Which small red structure is responsible for making proteins in both plant and animal cells?",
      "answers": ["Ribosomes", "Ribosomes2"],
      "definition":
          "Small structures made of RNA and proteins that are responsible for synthesizing proteins by translating messenger RNA.",
      "buttonImages": [
        "assets/lesson4/png/plant/ribosomes.png",
        "assets/lesson4/png/animal/ribosomes.png"
      ],
      "discussionImages": [
        "assets/lesson4/plant2/Ribosomes.png",
        "assets/lesson4/animal2/RIBOSOME.png"
      ]
    },

    // Nucleus
    {
      "question":
          "Which light green structure, found in both plant and animal cells, contains the cell's genetic material?",
      "answers": ["Nucleus", "Nucleus2"],
      "definition":
          "The control center of the cell that contains DNA, which carries genetic information. It regulates cellular activities and functions.",
      "buttonImages": [
        "assets/lesson4/png/plant/nucleus.png",
        "assets/lesson4/png/animal/nucleus.png"
      ],
      "discussionImages": [
        "assets/lesson4/plant2/Nucleus.jpg",
        "assets/lesson4/animal2/nucleus.jpg"
      ]
    },

    // Endoplasmic Reticulum (ER)
    {
      "question":
          "Which structure, involved in synthesizing proteins and lipids, is light purple in plant cells and yellow in animal cells?",
      "answers": ["Endoplasmic Reticulum", "Endoplasmic Reticulum2"],
      "definition":
          "A network of membranes involved in the synthesis, folding, modification, and transport of proteins (rough ER) and lipids (smooth ER).",
      "buttonImages": [
        "assets/lesson4/png/plant/endoplasmic.png",
        "assets/lesson4/png/animal/ER.png"
      ],
      "discussionImages": [
        "assets/lesson4/plant2/er.jpg",
        "assets/lesson4/animal2/endoplasmic.jpg"
      ]
    },

    // Golgi Apparatus
    {
      "question":
          "Which structure, responsible for modifying, sorting, and packaging proteins and lipids, is red in plant cells and blue in animal cells?",
      "answers": ["Golgi Apparatus", "Golgi Apparatus2"],
      "definition":
          "A stack of membrane-bound vesicles responsible for modifying, sorting, and packaging proteins and lipids for transport or secretion.",
      "buttonImages": [
        "assets/lesson4/png/plant/golgi.png",
        "assets/lesson4/png/animal/golgi.png"
      ],
      "discussionImages": [
        "assets/lesson4/plant2/golgi_body.jpg",
        "assets/lesson4/animal2/Golgi-Apparatus.jpg"
      ]
    },

    // Lysosomes
    {
      "question":
          "Which structure, containing digestive enzymes, is orange in plant cells and yellow in animal cells?",
      "answers": ["Lysosomes", "Lysosomes2"],
      "definition":
          "Membrane-bound organelles containing digestive enzymes that break down waste materials, cellular debris, and foreign invaders in the cell.",
      "buttonImages": [
        "assets/lesson4/png/plant/lysosomespng.png",
        "assets/lesson4/png/animal/Lysosomes.png"
      ],
      "discussionImages": [
        "assets/lesson4/plant2/Lysosomes.png",
        "assets/lesson4/animal2/lysosome.jpg"
      ]
    },

    // Vacuole
    {
      "question":
          "Which structure, responsible for storing nutrients and waste, is white in plant cells and green in animal cells?",
      "answers": ["Vacuole", "Vacuole2"],
      "definition":
          "Membrane-bound sacs used for storage, digestion, and waste removal. Plant cells typically have a large central vacuole, while animal cells have smaller, often multiple vacuoles.",
      "buttonImages": [
        "assets/lesson4/png/animal/vacuole.png",
        "assets/lesson4/png/animal/vacuole.png"
      ],
      "discussionImages": [
        "assets/lesson4/plant2/vacuole.jpg",
        "assets/lesson4/animal2/vacuole.gif"
      ]
    },

    // Mitochondria
    {
      "question":
          "Which structure, known as the powerhouse of the cell, is yellow in plant cells and red in animal cells?",
      "answers": ["Mitochondria", "Mitochondria2"],
      "definition":
          "Organelles known as the 'powerhouses' of the cell, where cellular respiration occurs to produce energy (ATP) from nutrients.",
      "buttonImages": [
        "assets/lesson4/png/plant/mitochondria.png",
        "assets/lesson4/png/animal/mitochondria.png"
      ],
      "discussionImages": [
        "assets/lesson4/plant2/mitochondria.jpg",
        "assets/lesson4/animal2/mitochondria.jpg"
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    questionAnswerPairs.shuffle(Random());
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
                          'Introduction to the AR Plant Cell Learning Module',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'In this activity, you will explore the unique organelles found in plant and animal cells, as well as their similarities. Pay close attention to the models and aim to answer the questions accurately. Good luck!',
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
                          'You will be presented with a series of questions about the organelles in plant and animal cells. Tap on the correct model to answer each question. If you make a mistake, it will be counted. Do your best to answer them all correctly!',
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
                child: Text(
                  "${questionAnswerPairs[currentQuestionIndex]['question']} ($pairProgress/${questionAnswerPairs[currentQuestionIndex]['answers'].length})",
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
                height:
                    120, // Adjusted to match the height of the one-pair buttons
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 12, // Adjust to the actual number of items
                  itemBuilder: (context, index) {
                    String organelleName = questionAnswerPairs[index]
                            ['answers']![0]
                        .replaceAll(RegExp(r'\d'), '');
                    bool hasPair =
                        questionAnswerPairs[index]['answers']!.length > 1;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 100, // Set a fixed height for all buttons
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: unlockedButtons[index]
                                  ? () {
                                      _showDefinition(
                                        context,
                                        organelleName,
                                        questionAnswerPairs[index]
                                            ['definition']!,
                                        questionAnswerPairs[index]
                                            ['discussionImages']!,
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
                                        if (questionAnswerPairs[index]
                                                    ['buttonImages']!
                                                .length >
                                            1)
                                          Row(
                                            children: questionAnswerPairs[index]
                                                    ['buttonImages']!
                                                .map<Widget>((imagePath) =>
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 2.0),
                                                      child: Image.asset(
                                                        imagePath,
                                                        width: 30,
                                                        height: 30,
                                                      ),
                                                    ))
                                                .toList(),
                                          )
                                        else
                                          Image.asset(
                                            questionAnswerPairs[index]
                                                ['buttonImages']![0],
                                            width: 60,
                                            height:
                                                60, // Ensure consistent height
                                          ),
                                        Text(
                                          organelleName,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    )
                                  : Icon(Icons.help_outline, size: 40),
                            ),
                          ],
                        ),
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
            uri: "assets/lesson4/table.gltf",
            scale: vector.Vector3(1.5, 1.0, 1.0), // Adjusted table width
            position: vector.Vector3(
              translation.x +
                  0.15, // Moved the table to the right by increasing the x value
              translation.y - 0.25, // Kept the table at the same height
              translation.z -
                  0.20, // Moved the table slightly forward by decreasing the subtraction value
            ), // Adjusted position rightwards and forwards
            rotation: vector.Vector4(
                0, 1, 0, 1.5708), // Rotate 90 degrees around Y-axis
            name: "table",
            canScale: false,
          );

          arObjectManager!.addNode(tableNode).then((didAddTableNode) {
            if (didAddTableNode!) {
              nodes.add(tableNode);
// Add plant cell and animal cell display nodes behind the table

              var plantCellNode = ARNode(
                type: NodeType.localGLTF2,
                uri: "assets/lesson4/plant2/plantcell3.gltf",
                scale: vector.Vector3(
                    0.2, 0.2, 0.2), // Increased scale for plant cell
                position: vector.Vector3(
                  translation.x - 0.2, // Moved further right along the x-axis
                  translation.y, // Position adjusted upwards
                  translation.z - 0.4, // Moved forward along the z-axis
                ),
                rotation: vector.Vector4(0, 1, 0, 0), // No rotation
                name: "plantCell",
                canScale: false,
              );

              var animalCellNode = ARNode(
                type: NodeType.localGLTF2,
                uri: "assets/lesson4/animal2/animalcell.gltf",
                scale: vector.Vector3(
                    0.2, 0.2, 0.2), // Increased scale for animal cell
                position: vector.Vector3(
                  translation.x + 0.3, // Moved further right along the x-axis
                  translation.y, // Position adjusted upwards
                  translation.z - 0.4, // Moved forward along the z-axis
                ),
                rotation: vector.Vector4(0, 1, 0, 0), // No rotation
                name: "animalCell",
                canScale: false,
              );

              arObjectManager!
                  .addNode(plantCellNode)
                  .then((didAddPlantCellNode) {
                if (didAddPlantCellNode!) {
                  nodes.add(plantCellNode);
                }
              });

              arObjectManager!
                  .addNode(animalCellNode)
                  .then((didAddAnimalCellNode) {
                if (didAddAnimalCellNode!) {
                  nodes.add(animalCellNode);
                }
              });

              // Plant cell nodes
              List<SceneNode> plantSceneNodes = [
                SceneNode(
                  name: "Cell Wall",
                  modelPath: "assets/lesson4/plant2/cellwall.gltf",
                  position:
                      vector.Vector3(-0.35, 0.05, -0.15), // Row 1, Column 1
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Chloroplast",
                  modelPath: "assets/lesson4/plant2/chloroplast.gltf",
                  position:
                      vector.Vector3(-0.25, 0.05, -0.15), // Row 1, Column 2
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Cell Membrane",
                  modelPath: "assets/lesson4/plant2/cellmembrane.gltf",
                  position:
                      vector.Vector3(-0.15, 0.05, -0.15), // Row 1, Column 3
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Cytoplasm",
                  modelPath: "assets/lesson4/plant2/cytoplasm.gltf",
                  position:
                      vector.Vector3(-0.05, 0.05, -0.15), // Row 1, Column 4
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Endoplasmic Reticulum",
                  modelPath: "assets/lesson4/plant2/endoplasmic.gltf",
                  position:
                      vector.Vector3(-0.35, 0.05, -0.05), // Row 2, Column 1
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Golgi Apparatus",
                  modelPath: "assets/lesson4/plant2/golgi.gltf",
                  position:
                      vector.Vector3(-0.25, 0.05, -0.05), // Row 2, Column 2
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Lysosomes",
                  modelPath: "assets/lesson4/plant2/lysosomes.gltf",
                  position:
                      vector.Vector3(-0.15, 0.05, -0.05), // Row 2, Column 3
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Mitochondria",
                  modelPath: "assets/lesson4/plant2/mitochondria.gltf",
                  position:
                      vector.Vector3(-0.05, 0.05, -0.05), // Row 2, Column 4
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Nucleus",
                  modelPath: "assets/lesson4/plant2/nucleus.gltf",
                  position:
                      vector.Vector3(-0.35, 0.05, 0.05), // Row 3, Column 1
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Ribosomes",
                  modelPath: "assets/lesson4/plant2/ribosomes.gltf",
                  position:
                      vector.Vector3(-0.25, 0.05, 0.05), // Row 3, Column 2
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Vacuole",
                  modelPath: "assets/lesson4/plant2/vacuole.gltf",
                  position:
                      vector.Vector3(-0.15, 0.05, 0.05), // Row 3, Column 3
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
              ];

              // Animal cell nodes
              List<SceneNode> animalSceneNodes = [
                SceneNode(
                  name: "Cytoplasm2",
                  modelPath: "assets/lesson4/animal2/cytoplasm.gltf",
                  position:
                      vector.Vector3(0.35, 0.05, -0.15), // Moved further right
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Endoplasmic Reticulum2",
                  modelPath: "assets/lesson4/animal2/er.gltf",
                  position:
                      vector.Vector3(0.45, 0.05, -0.15), // Moved further right
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Golgi Apparatus2",
                  modelPath: "assets/lesson4/animal2/golgi.gltf",
                  position:
                      vector.Vector3(0.55, 0.05, -0.15), // Moved further right
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Lysosomes2",
                  modelPath: "assets/lesson4/animal2/lysosomes.gltf",
                  position:
                      vector.Vector3(0.35, 0.05, -0.05), // Moved further right
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Mitochondria2",
                  modelPath: "assets/lesson4/animal2/mitochondria.gltf",
                  position:
                      vector.Vector3(0.45, 0.05, -0.05), // Moved further right
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Nucleus2",
                  modelPath: "assets/lesson4/animal2/nucleus.gltf",
                  position:
                      vector.Vector3(0.55, 0.05, -0.05), // Moved further right
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Ribosomes2",
                  modelPath: "assets/lesson4/animal2/robosomes.gltf",
                  position:
                      vector.Vector3(0.35, 0.05, 0.05), // Moved further right
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Vacuole2",
                  modelPath: "assets/lesson4/animal2/vacuole.gltf",
                  position:
                      vector.Vector3(0.45, 0.05, 0.05), // Moved further right
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
                SceneNode(
                  name: "Centrioles2",
                  modelPath: "assets/lesson4/animal2/centrioles.gltf",
                  position:
                      vector.Vector3(0.55, 0.05, 0.05), // Moved further right
                  scale: vector.Vector3(0.04, 0.04, 0.04),
                ),
              ];

              loadModels(plantSceneNodes, translation, rotationQuaternion);
              loadModels(animalSceneNodes, translation, rotationQuaternion);
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
        List<String> answers = List<String>.from(
            questionAnswerPairs[currentQuestionIndex]['answers']!);

        // Check if the tapped node is a correct answer and hasn't been tapped before
        if (answers.contains(nodeName)) {
          setState(() {
            pairProgress++; // Increment pair progress
            answers.remove(
                nodeName); // Remove the tapped node from the answers list

            // Update the question text to reflect the current progress
            feedbackMessage =
                "Correct! ($pairProgress/${questionAnswerPairs[currentQuestionIndex]['answers'].length})";
            feedbackColor = Colors.green;
            showFeedback = true;

            // Show the definition immediately when all correct answers are tapped
            if (pairProgress ==
                questionAnswerPairs[currentQuestionIndex]['answers'].length) {
              correctAnswers++;
              unlockedButtons[currentQuestionIndex] = true;
              _showDefinition(
                context,
                nodeName,
                questionAnswerPairs[currentQuestionIndex]['definition']!,
                questionAnswerPairs[currentQuestionIndex]['discussionImages']!,
                isLastQuestion:
                    currentQuestionIndex == questionAnswerPairs.length - 1,
              );
              currentQuestionIndex++;
              pairProgress = 0; // Reset pair progress for the next question
            }
          });
        } else {
          setState(() {
            incorrectAnswers++;
            feedbackMessage = 'Wrong! You tapped on $nodeName';
            feedbackColor = Colors.red;
            wrongAnswers.add(
                'Q: ${questionAnswerPairs[currentQuestionIndex]['question']} - Your answer: $nodeName');
            showFeedback = true;
          });
        }

        // Hide feedback after a short delay
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            showFeedback = false;
            feedbackMessage = '';
          });
        });
      });
    };
  }

  void _showDefinition(
    BuildContext context,
    String part,
    String definition,
    List<String> imagePaths, {
    bool isLastQuestion = false,
  }) {
    // Mapping of organelle names to their titles
    Map<String, String> organelleTitles = {
      "Cell Wall": "Cell Wall",
      "Chloroplast": "Chloroplast",
      "Centrioles2": "Centriole/Plastids",
      "Cell Membrane": "Cell Membrane",
      "Ribosomes": "Ribosomes",
      "Ribosomes2": "Ribosomes",
      "Nucleus": "Nucleus",
      "Nucleus2": "Nucleus",
      "Endoplasmic Reticulum": "Endoplasmic Reticulum",
      "Endoplasmic Reticulum2": "Endoplasmic Reticulum",
      "Golgi Apparatus": "Golgi Apparatus",
      "Golgi Apparatus2": "Golgi Apparatus",
      "Lysosomes": "Lysosomes",
      "Lysosomes2": "Lysosomes",
      "Vacuole": "Vacuole",
      "Vacuole2": "Vacuole",
      "Mitochondria": "Mitochondria",
      "Mitochondria2": "Mitochondria",
      "Cytoplasm": "Cytoplasm",
      "Cytoplasm2": "Cytoplasm",
    };

    // Mapping to determine if the image is for plant or animal
    Map<String, String> imageLabels = {
      "plant": "in Plant Cell",
      "animal": "in Animal Cell",
    };

    double dialogHeight;

    // Adjust height based on content length
    if (definition.length > 200) {
      dialogHeight = 300.0; // Fixed height for long discussions
    } else if (definition.length > 100) {
      dialogHeight = 200.0; // Intermediate height for medium discussions
    } else {
      dialogHeight = 150.0; // Slightly larger height for short discussions
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(organelleTitles[part] ?? part),
          content: SizedBox(
            height:
                dialogHeight, // Adaptive height for the discussion container
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(definition),
                  SizedBox(height: 10),
                  for (var imagePath in imagePaths)
                    Column(
                      children: [
                        Image.asset(imagePath),
                        SizedBox(height: 5), // Space between image and text
                        Text(
                          "${organelleTitles[part]} ${imagePath.contains('plant') ? imageLabels['plant'] : imageLabels['animal']}",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 20), // Space between each image block
                      ],
                    ),
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
                      builder: (context) => Animal_and_Plant_TLA_3_1()),
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
