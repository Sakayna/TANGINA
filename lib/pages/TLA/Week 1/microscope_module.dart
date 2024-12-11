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
  runApp(MaterialApp(home: ModuleScreen()));
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

class ModuleScreen extends StatefulWidget {
  @override
  _ModuleScreenPage createState() => _ModuleScreenPage();
}

class _ModuleScreenPage extends State<ModuleScreen> {
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

  List<Map<String, String>> questionAnswerPairs = [
    {
      "question":
          "Which part magnifies the image of the specimen? Tap to answer.",
      "answer": "Eyepiece",
      "definition":
          "Eyepiece lens magnifies the image of the specimen. This part is also known as ocular. Most school microscopes have an eyepiece with 10X magnification.",
      "image": "assets/lesson1&2/assets/eye/eyepiece.png",
    },
    {
      "question": "Which part holds the eyepiece in place? Tap to answer.",
      "answer": "Eyepiece",
      "definition": "The tube holds the eyepiece.",
      "image": "assets/lesson1&2/assets/eye/eyetube.png",
    },
    {
      "question": "Which part holds the objective lenses? Tap to answer.",
      "answer": "Nosepiece",
      "definition":
          "Nosepiece holds the objective lenses and is sometimes called a revolving turret. You choose the objective lens by rotating to the specific lens one you want to use.",
      "image": "assets/lesson1&2/assets/nose/nose.png",
    },
    {
      "question":
          "Which part contains lenses of varying magnification power? Tap to answer.",
      "answer": "Objective Lenses",
      "definition": """
Most compound microscopes come with three or four objective lenses that revolve on the nosepiece. The most common objective lenses have power of 4X, 10X, and 40X. Combined with the magnification of the eyepiece, the resulting magnification is 40X, 100X, and 400X magnification. Total magnification is calculated by multiplying the power of the eyepiece by the power of the objective lens. (10X Eyepiece X 40X Objective = 400X Total Magnification). Some more advanced microscopes have an additional objective lens with 100X power. This results in 1,000X magnification.
""",
      "image": "assets/lesson1&2/assets/objective/objective.png",
      "lpo_image_4x": "assets/hologram/objective/4x.png",
      "lpo_image_10x": "assets/hologram/objective/10x.png",
      "hpo_image": "assets/hologram/objective/40x.png",
      "oio_image": "assets/hologram/objective/100x.png",
      "lpo_description":
          "LPO (Low Power Objective): Typically 4X and 10X magnification, used for general viewing and finding the specimen on the slide.",
      "hpo_description":
          "HPO (High Power Objective): Typically 40X magnification, used for observing fine details in the specimen.",
      "oio_description":
          "OIO (Oil Immersion Objective): Typically 100X magnification, used for viewing very fine details and requires a special oil to be placed between the lens and the slide."
    },
    {
      "question":
          "Which part connects the base to the nosepiece and eyepiece? Tap to answer.",
      "answer": "Arm",
      "definition":
          "The Arm connects the base to the nosepiece and eyepiece. It is the structural part that is also used to carry the microscope.",
      "image": "assets/lesson1&2/assets/arm/arm.png",
    },
    {
      "question":
          "Where is the specimen placed for observation? Tap to answer.",
      "answer": "Stage",
      "definition":
          "The stage is where the specimen is placed. This place is for observation.",
      "image": "assets/lesson1&2/assets/stage/stage1.png",
    },
    {
      "question":
          "Which part holds the slides in place on the stage? Tap to answer.",
      "answer": "Stage",
      "definition":
          "Stage clips are the supports that hold the slides in place on the stage.",
      "image": "assets/lesson1&2/assets/stage/clips.png",
    },
    {
      "question":
          "Which part controls the amount of light passing through the slide? Tap to answer.",
      "answer": "Diaphragm",
      "definition":
          "The diaphragm controls the amount of light passing through the slide. It is located below the stage and is usually controlled by a round dial. How to set the diaphragm is determined by the magnification, transparency of the specimen, and the degree of contrast you wish to have in your image. Also called the condenser diaphragm.",
      "image": "assets/lesson1&2/assets/diaphragm/diaphragm.png",
    },
    {
      "question": "Which part supplies light to the specimen? Tap to answer.",
      "answer": "Base",
      "definition":
          "Most light microscopes use a low voltage bulb which supplies light through the stage and onto the specimen. Mirrors are sometimes used instead of a built-in light. If your microscope has a mirror, it provides light reflected from ambient light sources like classroom lights or sunlight if outdoors.",
      "image": "assets/lesson1&2/assets/lamp/illuminator.png",
    },
    {
      "question":
          "Which part moves the stage for general focus? Tap to answer.",
      "answer": "Coarse Focus",
      "definition":
          "Coarse focus moves the stage to provide general focus on the specimen. When bringing a specimen into focus, the coarse dial is the first one used.",
      "image": "assets/lesson1&2/assets/coarse/coarse.png",
    },
    {
      "question":
          "Which part moves the stage in smaller increments for fine focus? Tap to answer.",
      "answer": "Fine Focus",
      "definition":
          "Fine focus moves the stage in smaller increments to provide a clear view of the specimen. When bringing a specimen into focus, the fine focus dial is the second one used.",
      "image": "assets/lesson1&2/assets/fine/fine.png",
    },
    {
      "question":
          "Which part provides the main support for the microscope? Tap to answer.",
      "answer": "Base",
      "definition":
          "The base is the main support of the microscope. The bottom, where all the other parts of the microscope stand.",
      "image": "assets/lesson1&2/assets/base/base.png",
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
                          'Introduction to the AR Learning Activity',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'In this module, you will learn about the different parts of a microscope. Pay attention to the models and try to answer the questions correctly. Good luck!',
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
                          'You will be asked a series of questions related to the parts of a microscope. Tap on the corresponding model to answer each question. If you answer incorrectly, it will be counted. Try your best to get them all right!',
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
                height: 120, // Lowered the height of the container
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 12, // Adjusted to 12 for the new question
                  itemBuilder: (context, index) {
                    String buttonText = questionAnswerPairs[index]['answer']!;
                    if (buttonText == "Base" &&
                        questionAnswerPairs[index]['image'] ==
                            "assets/lesson1&2/assets/lamp/illuminator.png") {
                      buttonText = "Illuminator";
                    }
                    if (buttonText == "Eyepiece" &&
                        questionAnswerPairs[index]['image'] ==
                            "assets/lesson1&2/assets/eye/eyetube.png") {
                      buttonText = "Eyepiece Tube";
                    }
                    if (buttonText == "Stage" &&
                        questionAnswerPairs[index]['image'] ==
                            "assets/lesson1&2/assets/stage/clips.png") {
                      buttonText = "Stage Clips";
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: unlockedButtons[index]
                                ? () {
                                    _showDefinition(
                                      context,
                                      buttonText, // Update to use buttonText
                                      questionAnswerPairs[index]['definition']!,
                                      questionAnswerPairs[index]['image']!,
                                      lpoImage4x: questionAnswerPairs[index]
                                          ['lpo_image_4x'],
                                      lpoImage10x: questionAnswerPairs[index]
                                          ['lpo_image_10x'],
                                      hpoImage: questionAnswerPairs[index]
                                          ['hpo_image'],
                                      oioImage: questionAnswerPairs[index]
                                          ['oio_image'],
                                      lpoDescription: questionAnswerPairs[index]
                                          ['lpo_description'],
                                      hpoDescription: questionAnswerPairs[index]
                                          ['hpo_description'],
                                      oioDescription: questionAnswerPairs[index]
                                          ['oio_description'],
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
                                        buttonText, // Updated button text
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
          showFeaturePoints: false, // Do not show feature points (box dots)
          showPlanes: true, // Show planes (white dots)
          showWorldOrigin: false,
          handlePans: false, // Disable dragging
          handleScale: true, // Enable zooming
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

          List<SceneNode> sceneNodes = [
            SceneNode(
              name: "Base",
              modelPath: "assets/hologram/base/base7.gltf",
              position: vector.Vector3(
                  -0.08, -0.0180516, 0.135067), // Moved to the left
              scale: vector.Vector3(1.0, 1.0, 1.0),
            ),
            SceneNode(
              name: "Arm",
              modelPath: "assets/hologram/arm/arm2.gltf",
              position: vector.Vector3(0.11, 0.0205984, 0.115067),
              scale: vector.Vector3(1.0, 1.0, 1.0),
            ),
            SceneNode(
              name: "Fine Focus",
              modelPath: "assets/hologram/fine/fine8.gltf",
              position: vector.Vector3(0.12, 0.08, 0.1078705),
              scale: vector.Vector3(1.0, 1.0, 1.0),
            ),
            SceneNode(
              name: "Coarse Focus",
              modelPath: "assets/hologram/coarse/coarse3.gltf",
              position: vector.Vector3(-0.05, 0.0704573, 0.085877),
              scale: vector.Vector3(1.0, 1.0, 1.0),
            ),
            SceneNode(
              name: "Eyepiece",
              modelPath: "assets/hologram/eyepiece/eye.gltf",
              position: vector.Vector3(-0.03, 0.222, 0.16),
              scale: vector.Vector3(1.0, 1.0, 1.0),
            ),
            SceneNode(
              name: "Diaphragm",
              modelPath: "assets/hologram/diaphragm/condenser4.gltf",
              position: vector.Vector3(0.12, 0.08, 0.16),
              scale: vector.Vector3(1.0, 1.0, 1.0),
            ),
            SceneNode(
              name: "Stage",
              modelPath: "assets/hologram/stage/stage2.gltf",
              position: vector.Vector3(0.15, 0.122, 0.145),
              scale: vector.Vector3(1.0, 1.0, 1.0),
            ),
            SceneNode(
              name: "Objective Lenses",
              modelPath: "assets/hologram/objective/objective1.gltf",
              position: vector.Vector3(0.12, 0.155, 0.175),
              scale: vector.Vector3(1.0, 1.0, 1.0),
            ),
            SceneNode(
              name: "Nosepiece",
              modelPath: "assets/hologram/nose/nose1.gltf",
              position: vector.Vector3(-0.025, 0.195, 0.175),
              scale: vector.Vector3(1.0, 1.0, 1.0),
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

        // Determine the proper title for multi-answer nodes
        String displayName = nodeName;
        if (nodeName == "Base") {
          // Base node has two contexts: "Base" and "Illuminator"
          if (question.contains("light") || question.contains("Illuminator")) {
            displayName = "Illuminator";
          } else {
            displayName = "Base";
          }
        } else if (nodeName == "Eyepiece") {
          // Eyepiece node has two contexts: "Eyepiece/Ocular Lens" and "Eyepiece Tube"
          if (question.contains("holds the eyepiece") ||
              question.contains("tube")) {
            displayName =
                "Eyepiece Tube"; // Use "Eyepiece Tube" for tube-related questions
          } else {
            displayName =
                "Eyepiece/Ocular Lens"; // Default to "Eyepiece/Ocular Lens"
          }
        } else if (nodeName == "Stage") {
          // Stage node has two contexts: "Stage" and "Stage Clips"
          if (question.contains("slides in place") ||
              question.contains("clips")) {
            displayName =
                "Stage Clips"; // Use "Stage Clips" for clip-related questions
          } else {
            displayName = "Stage"; // Default to "Stage"
          }
        }

        // Check if the tapped node matches the answer
        if (nodeName == answer) {
          _showDefinition(
            context,
            displayName, // Pass the dynamic name
            questionAnswerPairs[currentQuestionIndex]['definition']!,
            questionAnswerPairs[currentQuestionIndex]['image']!,
            lpoImage4x: questionAnswerPairs[currentQuestionIndex]
                ['lpo_image_4x'],
            lpoImage10x: questionAnswerPairs[currentQuestionIndex]
                ['lpo_image_10x'],
            hpoImage: questionAnswerPairs[currentQuestionIndex]['hpo_image'],
            oioImage: questionAnswerPairs[currentQuestionIndex]['oio_image'],
            lpoDescription: questionAnswerPairs[currentQuestionIndex]
                ['lpo_description'],
            hpoDescription: questionAnswerPairs[currentQuestionIndex]
                ['hpo_description'],
            oioDescription: questionAnswerPairs[currentQuestionIndex]
                ['oio_description'],
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
      BuildContext context, String part, String definition, String imagePath,
      {String? lpoImage4x,
      String? lpoImage10x,
      String? hpoImage,
      String? oioImage,
      String? lpoDescription,
      String? hpoDescription,
      String? oioDescription,
      bool isLastQuestion = false}) {
    double dialogHeight;

    // Adjust height based on content length
    if (definition.length > 200 ||
        lpoImage4x != null ||
        hpoImage != null ||
        oioImage != null) {
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
                  if (lpoImage4x != null) ...[
                    SizedBox(height: 10),
                    Text(lpoDescription ?? ''),
                    Image.asset(lpoImage4x),
                  ],
                  if (lpoImage10x != null) ...[
                    SizedBox(height: 10),
                    Image.asset(lpoImage10x),
                  ],
                  if (hpoImage != null) ...[
                    SizedBox(height: 10),
                    Text(hpoDescription ?? ''),
                    Image.asset(hpoImage),
                  ],
                  if (oioImage != null) ...[
                    SizedBox(height: 10),
                    Text(oioDescription ?? ''),
                    Image.asset(oioImage),
                  ],
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
                  MaterialPageRoute(builder: (context) => Microscopy_TLA_1_1()),
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
