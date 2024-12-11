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

void main() {
  runApp(MaterialApp(home: ModuleScreen7()));
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

class ModuleScreen7 extends StatefulWidget {
  @override
  _ModuleScreen7Page createState() => _ModuleScreen7Page();
}

class _ModuleScreen7Page extends State<ModuleScreen7> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  ARLocationManager? arLocationManager;
  bool surfaceDetected = false;
  bool modelPlaced = false;
  bool showNextButton = false;
  int currentTextStep = 0;
  bool isAnswerCorrect = false;
  bool showIntroOnce = true;
  int correctAnswers = 0; // Counter for correct answers
  int wrongAnswers = 0; // Counter for wrong answers
  List<ARNode> nodes = [];
  int currentNodeIndex = 0;
  ARNode? activeNode;
  ARHitTestResult? lastHitTestResult;
  List<String> incorrectQuestions = []; // To store incorrect questions
  List<String> userAnswers = []; // To store user's answers

  void onNextAsexualNodePressed() async {
    if (activeNode != null) {
      await arObjectManager?.removeNode(activeNode!);
      nodes.remove(activeNode);
      activeNode = null;

      setState(() {
        modelPlaced = false;
        currentNodeIndex = (currentNodeIndex + 1) % asexualNodes.length;
      });

      if (lastHitTestResult != null) {
        var translation = lastHitTestResult!.worldTransform.getTranslation();
        var rotation = lastHitTestResult!.worldTransform.getRotation();
        var rotationQuaternion = vector.Quaternion.fromRotation(rotation);
        placeNode(
            asexualNodes[currentNodeIndex], translation, rotationQuaternion);
      }
    }
  }

  void replaceSexualNodesWithAsexualNodes() async {
    // Remove all Coraline-related nodes
    for (var node in nodes) {
      await arObjectManager?.removeNode(node);
    }
    nodes.clear(); // Clear all nodes from the list

    setState(() {
      currentNodeIndex = 0; // Reset node index for asexual nodes
      modelPlaced = false; // Ensure model is not placed
    });

    if (lastHitTestResult != null) {
      var translation = lastHitTestResult!.worldTransform.getTranslation();
      var rotation = lastHitTestResult!.worldTransform.getRotation();
      var rotationQuaternion = vector.Quaternion.fromRotation(rotation);
      placeNode(
          asexualNodes[currentNodeIndex], translation, rotationQuaternion);
    }
  }

  final List<SceneNode> sceneNodes = [
    SceneNode(
      name: "Sperm",
      modelPath: "assets/lesson7/sperm/sperm.gltf", // Updated model path
      position: vector.Vector3(-0.08, -0.3, -1.0),
      scale: vector.Vector3(0.2, 0.2, 0.2),
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "Zygote",
      modelPath: "assets/lesson7/zygote/zygote.gltf",
      position: vector.Vector3(-0.08, -0.3, -1.0),
      scale: vector.Vector3(0.2, 0.2, 0.2),
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "Embryo",
      modelPath: "assets/lesson7/embryo/embryo.gltf",
      position: vector.Vector3(-0.08, -0.3, -1.0),
      scale: vector.Vector3(0.5, 0.5, 0.5),
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "Baby",
      modelPath: "assets/lesson7/baby/baby.gltf",
      position: vector.Vector3(-0.08, -0.3, -1.0),
      scale: vector.Vector3(0.5, 0.5, 0.5),
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
  ];

  // Nodes to display together after Coraline introduction
  final List<SceneNode> parentNodes = [
    SceneNode(
      name: "Coraline Jones",
      modelPath: "assets/lesson7/coraline/coraline.gltf",
      position: vector.Vector3(
          -1.2, -0.3, -0.8), // Move Coraline closer to the camera
      scale: vector.Vector3(0.1, 0.1, 0.1), // Smaller size
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "The Beldam",
      modelPath: "assets/lesson7/beldam/beldam.gltf",
      position: vector.Vector3(-0.8, -0.3, -1.0), // Move Beldam forward
      scale: vector.Vector3(0.4, 0.4, 0.4), // Smaller size
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "Mel Jones",
      modelPath: "assets/lesson7/mama/realmama.gltf",
      position: vector.Vector3(-0.4, -0.3, -1.0), // Move Mel Jones forward
      scale: vector.Vector3(0.1, 0.1, 0.1), // Smaller size
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "Miss Spink",
      modelPath: "assets/lesson7/fake1/fake1.gltf",
      position: vector.Vector3(0.0, -0.3, -1.0), // Move Miss Spink forward
      scale: vector.Vector3(0.1, 0.1, 0.1), // Smaller size
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "Miss Forcible",
      modelPath: "assets/lesson7/fake2/fake2.gltf",
      position: vector.Vector3(0.4, -0.3, -1.0), // Move Miss Forcible forward
      scale: vector.Vector3(0.4, 0.4, 0.4), // Smaller size
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "Charlie Jones",
      modelPath: "assets/lesson7/papa/papa.gltf",
      position: vector.Vector3(0.8, -0.3, -1.5), // Charlie Jones stays behind
      scale: vector.Vector3(0.2, 0.2, 0.2), // Smaller size
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "Mr. Bobinsky",
      modelPath: "assets/lesson7/papa2/ratman.gltf",
      position:
          vector.Vector3(1.2, -0.3, -1.5), // Positioned next to Charlie Jones
      scale: vector.Vector3(0.3, 0.3, 0.3), // Smaller size
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
  ];

  // Nodes for Asexual Reproduction
  final List<SceneNode> asexualNodes = [
    SceneNode(
      name: "Hydra Parent",
      modelPath: "assets/lesson7/parent/hydra.gltf",
      position: vector.Vector3(-0.08, -0.3, -1.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "Bud Formation",
      modelPath: "assets/lesson7/parent/bud.gltf",
      position: vector.Vector3(-0.08, -0.3, -1.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "New Bud",
      modelPath: "assets/lesson7/parent/newbud.gltf",
      position: vector.Vector3(-0.08, -0.3, -1.0),
      scale: vector.Vector3(0.3, 0.3, 0.3),
      rotation: vector.Vector4(0, 1, 0, 0),
    ),
    SceneNode(
      name: "New Hydra",
      modelPath: "assets/lesson7/parent/newhydra.gltf",
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
      appBar: AppBar(
        title: Text(
          'Correct: $correctAnswers | Wrong: $wrongAnswers',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
        backgroundColor: Colors.black, // Keep the background color black
        iconTheme: IconThemeData(
            color: Colors.white), // Set the color of the back button to white
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
          // Sexual Reproduction Activity
          if (modelPlaced && currentTextStep == 0 && showIntroOnce)
            buildIntroductionText(
              'Welcome to the AR Learning Module!',
              'We are excited to guide you through this immersive experience to learn about sexual reproduction.',
              () {
                setState(() {
                  currentTextStep = 1; // Move to the explanation text
                });
              },
            ),
          if (modelPlaced && currentTextStep == 1 && showIntroOnce)
            buildIntroductionText(
              'Introduction to the AR Experience',
              'In this module, you will explore a 3D model of the process of sexual reproduction. This interactive experience will help you understand each part and its function.',
              () {
                setState(() {
                  currentTextStep = 2; // Move to the explanation text
                });
              },
            ),
          // Discussion and question for Sperm and Egg
          if (modelPlaced && currentTextStep == 2)
            buildDiscussionText(
              'Sperm and Egg Interaction',
              'Sexual reproduction involves two parents. The male produces sperm, and the female produces eggs. When a sperm successfully meets an egg, fertilization occurs. This union is the start of a new life. What do you think is the next step in this process?',
            ),
          if (currentTextStep == 3)
            buildQuestion(
              'What is the next step after the sperm meets the egg?',
              'Fertilization',
              ['Cell Division', 'Fertilization', 'Implantation'],
            ),
          if (isAnswerCorrect && currentTextStep == 4)
            buildCorrectAnswerText(
              'You are correct! The next step is fertilization, where the sperm fuses with the egg to form a zygote.',
              () {
                setState(() {
                  currentTextStep = 5; // Move to next discussion
                  showNextButton = false; // Hide the next button
                  onNextButtonPressed(); // Proceed to the next node
                });
              },
            ),
          // Discussion and question for Zygote
          if (modelPlaced && currentTextStep == 5)
            buildDiscussionText(
              'Zygote Formation',
              'After fertilization, a zygote is formed. A zygote is a single cell that contains genetic material from both parents. This ensures genetic diversity, which is a key advantage of sexual reproduction.',
            ),
          if (currentTextStep == 6)
            buildQuestion(
              'What happens after the formation of a zygote?',
              'Cell Division',
              ['Implantation', 'Cell Division', 'Embryogenesis'],
            ),
          if (isAnswerCorrect && currentTextStep == 7)
            buildCorrectAnswerText(
              'Correct! The zygote undergoes multiple rounds of cell division, leading to the formation of an embryo.',
              () {
                setState(() {
                  currentTextStep = 8; // Move to next discussion
                  showNextButton = false; // Hide the next button
                  onNextButtonPressed(); // Proceed to the next node
                });
              },
            ),
          // Discussion and question for Embryo
          if (modelPlaced && currentTextStep == 8)
            buildDiscussionText(
              'Embryo Development',
              'The zygote develops into an embryo. During this stage, cells rapidly divide and differentiate to form the various tissues and organs of the body. This is a critical phase in the development of the new organism.',
            ),
          if (currentTextStep == 9)
            buildQuestion(
              'What is the next stage after the embryo begins to develop?',
              'Fetal Development',
              ['Birth', 'Fetal Development', 'Organ Formation'],
            ),
          if (isAnswerCorrect && currentTextStep == 10)
            buildCorrectAnswerText(
              'Correct! The embryo continues to develop into a fetus, where all major organs begin to form and mature.',
              () {
                setState(() {
                  currentTextStep = 11; // Move to next discussion
                  showNextButton = false; // Hide the next button
                  onNextButtonPressed(); // Proceed to the next node
                });
              },
            ),
          // Discussion and question for Baby
          if (modelPlaced && currentTextStep == 11)
            buildDiscussionText(
              'Baby Development',
              'As the embryo grows, it eventually becomes a fetus. The fetus continues to develop in the womb until birth. Sexual reproduction results in offspring that are genetically different from both parents, contributing to diversity in a population.',
            ),
          if (currentTextStep == 12)
            buildQuestion(
              'What is the term used for the period from conception to birth?',
              'Gestation',
              ['Pregnancy', 'Gestation', 'Incubation'],
            ),
          if (isAnswerCorrect && currentTextStep == 13)
            buildCorrectAnswerText(
              'You are correct! Gestation is the period from conception to birth.',
              () {
                setState(() {
                  currentTextStep = 14; // Proceed to the next step
                });
              },
            ),
          // "Now that you learned" Text
          if (currentTextStep == 14)
            buildDiscussionText(
              'Now that you learned about sexual reproduction...',
              'You have completed the section on sexual reproduction. You learned about how two parents contribute to creating a genetically diverse offspring. Let\'s now move to the next activity to explore further.',
            ),
          // "Meet Coraline" Text
          if (currentTextStep == 15)
            buildIntroductionText(
              'Meet Coraline',
              'Coraline is the offspring resulting from the union of the sperm and egg cell you learned about earlier. In this next activity, we will explore her traits and find her parents. Let\'s start by learning more about Coraline and the traits she has inherited.',
              () {
                setState(() {
                  currentTextStep = 16; // Prepare to display the nodes
                  replaceBabyNodeWithParentNodes(); // Replace Baby node with parent nodes
                });
              },
            ),
          // Activity Instructions
          if (currentTextStep == 16)
            buildDiscussionText(
              'Activity Instruction',
              'Please tap on Coraline first, then tap on any of the women or men to learn about their traits.',
            ),
          if (currentTextStep == 17)
            buildDiscussionText(
              'Ready to Choose?',
              'If you are done looking at the traits of the possible parents, tap Next to answer the questions.',
            ),
          // Question about Coraline's Mother
          if (currentTextStep == 18)
            buildQuestion(
              'Based on the traits, who is most likely to be Coraline\'s mother?',
              'Mel Jones',
              ['The Beldam', 'Mel Jones', 'Miss Spink', 'Miss Forcible'],
            ),
          if (isAnswerCorrect && currentTextStep == 19)
            buildCorrectAnswerText(
              'Correct! Mel Jones is most likely Coraline\'s mother.',
              () {
                setState(() {
                  currentTextStep = 20; // Move to the next question
                });
              },
            ),
          // Question about Traits of Mel Jones and Coraline
          if (currentTextStep == 20)
            buildQuestion(
              'What are the traits of Mel Jones that are similar to Coraline?',
              'Brown Hair, Brown Eyes, Fair Skin Tone',
              [
                'Black Hair, Button Eyes, Pale Skin',
                'Orange Hair, Doll-like Appearance, Petite Build',
                'Brown Hair, Brown Eyes, Fair Skin Tone',
                'Blonde Hair, Puppet-like Movements, Sharp Chin'
              ],
            ),
          if (isAnswerCorrect && currentTextStep == 21)
            buildCorrectAnswerText(
              'You are correct! Coraline shares traits like brown hair, brown eyes, and fair skin tone with Mel Jones.',
              () {
                setState(() {
                  currentTextStep =
                      22; // Explanation of Mel Jones as Coraline's mother
                });
              },
            ),
          // Explanation of Why Mel Jones is Coraline's Mother
          if (currentTextStep == 22)
            buildDiscussionText(
              'Explanation',
              'Mel Jones is Coraline\'s mother because they share similar physical traits, such as brown hair and brown eyes. This demonstrates the inheritance of traits from parent to offspring in sexual reproduction, where genetic material from both parents is combined to produce a unique individual with characteristics of both.',
            ),
          // Question about Coraline's Father
          if (currentTextStep == 23)
            buildQuestion(
              'Based on the traits, who is most likely to be Coraline\'s father?',
              'Charlie Jones',
              ['Mr. Bobinsky', 'Charlie Jones'],
            ),
          if (isAnswerCorrect && currentTextStep == 24)
            buildCorrectAnswerText(
              'Correct! Charlie Jones is most likely Coraline\'s father.',
              () {
                setState(() {
                  currentTextStep = 25; // Move to the next question
                });
              },
            ),
          // Question about Traits of Charlie Jones and Coraline
          if (currentTextStep == 25)
            buildQuestion(
              'What are the traits of Charlie Jones that are similar to Coraline?',
              'Brown Hair, Brown Eyes, Fair Skin Tone',
              [
                'Blue Eyes, Pale Skin, Eccentric Personality',
                'Brown Hair, Brown Eyes, Fair Skin Tone',
                'Bald, Athletic Build, Pale Skin',
                'Blonde Hair, Button Eyes, Thin Lips'
              ],
            ),
          if (isAnswerCorrect && currentTextStep == 26)
            buildCorrectAnswerText(
              'You are correct! Coraline shares traits like brown hair, brown eyes, and fair skin tone with Charlie Jones.',
              () {
                setState(() {
                  currentTextStep =
                      27; // Explanation of Charlie Jones as Coraline's father
                });
              },
            ),
          // Explanation of Why Charlie Jones is Coraline's Father
          if (currentTextStep == 27)
            buildDiscussionText(
              'Explanation',
              'Charlie Jones is Coraline\'s father because they share traits such as brown hair and brown eyes. This also demonstrates the inheritance of traits from parent to offspring, where the genetic material from both parents is combined to create a unique individual with characteristics of both.',
            ),
          // Introduction to Asexual Reproduction
          if (currentTextStep == 28)
            buildIntroductionText(
              'Introduction to Asexual Reproduction',
              'Now that you have learned about sexual reproduction and how traits are inherited from both parents, we will move on to explore asexual reproduction, a process where a single organism can reproduce without the need for a partner. Let\'s dive into this new topic!',
              () {
                setState(() {
                  currentTextStep =
                      29; // Start with the first asexual reproduction node
                  replaceSexualNodesWithAsexualNodes(); // Replace nodes with asexual reproduction nodes
                });
              },
            ),
          // Asexual Reproduction Activity
          if (modelPlaced && currentTextStep == 29)
            buildDiscussionText(
              'Asexual Reproduction: Hydra',
              'In asexual reproduction, a single organism can reproduce on its own. Here, a Hydra, a simple freshwater animal, reproduces by budding. The process begins with the parent hydra.',
            ),
          if (currentTextStep == 30)
            buildQuestion(
              'What is the initial stage of asexual reproduction in Hydra?',
              'Bud Formation',
              ['Bud Formation', 'Egg Laying', 'Sperm Release'],
            ),
          if (isAnswerCorrect && currentTextStep == 31)
            buildCorrectAnswerText(
              'Correct! The process starts with the formation of a bud on the parent Hydra.',
              () {
                setState(() {
                  currentTextStep = 32; // Move to next node
                  showNextButton = false;
                  onNextAsexualNodePressed(); // Proceed to the next node
                });
              },
            ),
          // Discussion for Asexual Reproduction - Bud Formation
          if (modelPlaced && currentTextStep == 32)
            buildDiscussionText(
              'Bud Formation in Hydra',
              'The bud develops as a small outgrowth on the parent Hydra. This is the early stage of creating a new individual that will eventually separate from the parent.',
            ),
          if (currentTextStep == 33)
            buildQuestion(
              'What is the next stage after the bud is formed?',
              'New Bud',
              ['New Bud', 'New Parent', 'New Hydra'],
            ),
          if (isAnswerCorrect && currentTextStep == 34)
            buildCorrectAnswerText(
              'Correct! The bud continues to develop until it is ready to detach.',
              () {
                setState(() {
                  currentTextStep = 35; // Move to next node
                  showNextButton = false;
                  onNextAsexualNodePressed(); // Proceed to the next node
                });
              },
            ),
          // Discussion for Asexual Reproduction - New Bud
          if (modelPlaced && currentTextStep == 35)
            buildDiscussionText(
              'New Bud Development',
              'The new bud grows while attached to the parent. When it is fully formed, it will separate and become a new individual Hydra.',
            ),
          if (currentTextStep == 36)
            buildQuestion(
              'What happens when the bud is fully developed?',
              'New Hydra',
              ['New Hydra', 'Egg Laying', 'Mating'],
            ),
          if (isAnswerCorrect && currentTextStep == 37)
            buildCorrectAnswerText(
              'Correct! The fully developed bud detaches and becomes a new Hydra.',
              () {
                setState(() {
                  currentTextStep = 38; // Move to next node
                  showNextButton = false;
                  onNextAsexualNodePressed(); // Proceed to the next node
                });
              },
            ),
          // Discussion for Asexual Reproduction - New Hydra
          if (modelPlaced && currentTextStep == 38)
            buildDiscussionText(
              'New Hydra Formation',
              'The new Hydra is genetically identical to the parent. This process demonstrates how asexual reproduction creates offspring that are clones of the parent, ensuring genetic consistency.',
            ),
          if (currentTextStep == 39)
            buildIntroductionText(
              'Conclusion of Asexual Reproduction',
              'Asexual reproduction allows for rapid population growth and is effective in stable environments. Now, you understand both sexual and asexual reproduction, their processes, and their advantages.',
              () {
                setState(() {
                  showFinalResults();
                });
              },
            ),
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

  Widget buildDiscussionText(String title, String content) {
    return Positioned(
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
              title,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
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
              onPressed: () {
                setState(() {
                  currentTextStep++; // Move to the next step
                });
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuestion(
      String question, String correctAnswer, List<String> options) {
    return Positioned(
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
              question,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ...options.map((option) {
              return ElevatedButton(
                onPressed: () {
                  checkAnswer(option, correctAnswer, question);
                },
                child: Text(option),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget buildCorrectAnswerText(String text, VoidCallback onNext) {
    return Positioned(
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
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: onNext,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  void checkAnswer(
      String selectedAnswer, String correctAnswer, String question) {
    setState(() {
      userAnswers.add(selectedAnswer); // Store user's answer
      if (selectedAnswer == correctAnswer) {
        isAnswerCorrect = true;
        correctAnswers++; // Increment correct answers
        showNextButton = true; // Show the next button only when correct
        currentTextStep++; // Move to correct answer confirmation step
      } else {
        isAnswerCorrect = false;
        wrongAnswers++; // Increment wrong answers
        incorrectQuestions.add(question); // Store incorrect question
      }
    });
  }

  void showFinalResults() {
    int totalScore = correctAnswers - wrongAnswers; // Calculate total score
    totalScore = totalScore < 0 ? 0 : totalScore; // Ensure no negative score

    String resultText = "Correct: $correctAnswers\nWrong: $wrongAnswers\n";
    resultText += "Total Score: $totalScore\n\n"; // Display total score

    // Pass or fail criteria updated to totalScore >= 8
    String passOrFail =
        totalScore >= 8 ? "You Passed!" : "You Did Not Pass. Try Again!";
    resultText += "$passOrFail\n\n";

    if (wrongAnswers > 0) {
      resultText += "Questions you got wrong:\n";
      for (var i = 0; i < incorrectQuestions.length; i++) {
        resultText +=
            "${incorrectQuestions[i]} - Your answer: ${userAnswers[i]}\n";
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Final Results'),
          content: Text(resultText),
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

    this.arObjectManager!.onNodeTap = onNodeTap; // Add the node tap handler

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

  void replaceBabyNodeWithParentNodes() async {
    if (activeNode != null) {
      await arObjectManager?.removeNode(activeNode!);
      nodes.remove(activeNode);
      activeNode = null;
    }

    placeAllParentNodes(); // Place all the parent nodes
  }

  void placeAllParentNodes() async {
    if (lastHitTestResult != null) {
      for (var parentNode in parentNodes) {
        var translation = lastHitTestResult!.worldTransform.getTranslation();
        var rotation = lastHitTestResult!.worldTransform.getRotation();
        var rotationQuaternion = vector.Quaternion.fromRotation(rotation);
        await placeNode(parentNode, translation, rotationQuaternion);
      }
    }
  }

  void onNodeTap(List<String> nodeNames) {
    String nodeName = nodeNames.isNotEmpty ? nodeNames.first : 'Unknown';

    // List of non-interactive nodes
    final nonInteractiveNodes = [
      'Sperm',
      'Zygote',
      'Embryo',
      'Baby',
      'Hydra Parent',
      'Bud Formation',
      'New Bud',
      'New Hydra'
    ];

    // Skip processing if the node is non-interactive
    if (nonInteractiveNodes.contains(nodeName)) {
      return; // Do nothing for these nodes
    }

    // Existing logic for interactive nodes
    String description;
    switch (nodeName) {
      case 'Coraline Jones':
        description = '''
Hair: Brown, dyed blue; Eyes: Brown; Skin: Fair with freckles.
Personality: Curious, brave, and stubborn.
''';
        break;
      case 'The Beldam':
        description = '''
Hair: Black, bob cut; Eyes: Black buttons; Skin: Pale, skeletal appearance.
Personality: Manipulative and predatory.
''';
        break;
      case 'Mel Jones':
        description = '''
Hair: Brown; Eyes: Brown; Skin: Fair.
Personality: Practical, strict, but caring.
''';
        break;
      case 'Miss Spink':
        description = '''
Hair: Orange curls; Eyes: Black buttons; Appearance: Doll-like.
Personality: Cheerful, but unsettling.
''';
        break;
      case 'Miss Forcible':
        description = '''
Hair: Blonde bob; Eyes: Black buttons; Appearance: Doll-like.
Personality: Dramatic and unnerving.
''';
        break;
      case 'Charlie Jones':
        description = '''
Hair: Brown; Eyes: Brown; Skin: Fair.
Personality: Kind, supportive, and creative.
''';
        break;
      case 'Mr. Bobinsky':
        description = '''
Hair: Bald; Eyes: Blue; Skin: Pale.
Personality: Eccentric, mysterious, and athletic.
''';
        break;
      default:
        description = 'Unknown node';
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(nodeName),
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
  }

  void onNextButtonPressed() async {
    if (activeNode != null) {
      await arObjectManager?.removeNode(activeNode!);
      nodes.remove(activeNode);
      activeNode = null;

      setState(() {
        modelPlaced = false;
        currentNodeIndex =
            (currentNodeIndex + 1) % sceneNodes.length; // Move to the next node
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
