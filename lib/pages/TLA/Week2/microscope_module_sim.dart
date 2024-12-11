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
import 'dart:ui';

void main() {
  runApp(MaterialApp(home: ModuleScreen1()));
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

class AgendaItem {
  final String title;
  bool isCompleted;

  AgendaItem({
    required this.title,
    this.isCompleted = false,
  });
}

class ModuleScreen1 extends StatefulWidget {
  @override
  _ModuleScreen1Page createState() => _ModuleScreen1Page();
}

class _ModuleScreen1Page extends State<ModuleScreen1> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  ARLocationManager? arLocationManager;
  bool surfaceDetected = false;
  bool modelPlaced = false;
  bool welcomeMessageShown = false;
  bool agendaViewed = false;
  bool readyToProceed = false;
  bool microscopeTurnedOn = false;
  bool show10xImage = false;
  bool show40xImage = false;
  bool show100xImage = false;
  bool showCoarseFocusSlider = false;
  bool showFineFocusSlider = false;
  bool showInstructions = false;
  bool showAgendaList = false;
  bool showCoarseFocusInstruction = false;
  bool showObjective10xInstruction = false;
  bool showObjective40xInstruction = false;
  bool showObjective100xInstruction = false;
  bool showCoarseFocusButtonText = false;
  bool showFineFocusButtonText = false;
  bool show10xDiscussion = false;
  bool showNextTextFor40x = false;
  bool show40xDiscussion = false;
  bool showNextTextFor100x = false;
  bool show40xFineFocusInstruction = false;
  bool show100xFineFocusInstruction = false;
  bool show100xDiscussion = false;
  bool showActivityRecap = false;
  bool showEndText = false;
  bool showNewButton = false;
  bool showNewQuestionText = false;
  bool showClickButtonInstruction = false;
  bool showRotateNosepieceText = false;
  bool showNextTextForOilButton = false;
  bool showEyepiece10x = true;
  bool showEyepiece40x = false;
  bool showEyepiece100x = false;
  bool showObjectives = true;
  bool showStageText = false;
  bool showOilExplanationText = false;
  bool showTotalScore = false;

  double blurValue = 0.0;
  double secondBlurValue = 0.0;
  bool showNewSlider = false;
  double newSliderValue = 0.0;

  int correctAnswers = 0;
  int wrongAnswers = 0;
  List<String> wrongAgendas = []; // Store wrong agenda items here

  List<ARNode> nodes = [];

  List<AgendaItem> agendas = [
    AgendaItem(title: "Turn on the microscope"),
    AgendaItem(title: "Turn on the illuminator"),
    AgendaItem(title: "Click on the 10x objective"),
    AgendaItem(title: "Fix the viewing of the specimen in 10x"),
    AgendaItem(title: "Click on the 40x objective"),
    AgendaItem(title: "Fix the viewing of the specimen in 40x"),
    AgendaItem(title: "Rotate the nosepiece away"),
    AgendaItem(title: "Click on the oil button"),
    AgendaItem(title: "Click on the specimen on the stage"), // New Agenda Item
    AgendaItem(title: "Click on the 100x objective"),
    AgendaItem(title: "Fix the viewing of the specimen in 100x"),
  ];

  @override
  void dispose() {
    super.dispose();
    arSessionManager?.dispose();
  }

  void updateAgendaStatus(String title, bool isCompleted) {
    setState(() {
      final agenda = agendas.firstWhere((agenda) => agenda.title == title);
      if (!agenda.isCompleted && isCompleted) {
        agenda.isCompleted = true;
        correctAnswers++;
      } else if (!isCompleted) {
        // If the agenda item was not completed correctly, store it as wrong
        wrongAgendas.add(title);
        wrongAnswers++;
      }
    });
  }

  void handleNodeTap(String nodeName) {
    if (!modelPlaced) return;

    String currentTask =
        agendas.firstWhere((agenda) => !agenda.isCompleted).title;

    if (currentTask == "Turn on the microscope" && nodeName == "base") {
      updateAgendaStatus(currentTask, true);
      handleCorrectNodeTap(nodeName);
    } else if (currentTask == "Turn on the illuminator" &&
        nodeName == "illuminator") {
      updateAgendaStatus(currentTask, true);
      handleCorrectNodeTap(nodeName);
    } else if (nodeName == "bakit" && showStageText) {
      // Check if the current task is to click the stage
      if (currentTask == "Click on the specimen on the stage") {
        updateAgendaStatus(currentTask, true);
      }

      // Updated node name to "bakit"
      setState(() {
        showStageText = false; // Hide the stage text
        showOilExplanationText = true; // Show the oil explanation text
      });
    } else if (currentTask == "Click on the 10x objective" &&
        nodeName == "objective_10x") {
      updateAgendaStatus(currentTask, true);
      handleCorrectNodeTap(nodeName);
    } else if (currentTask == "Click on the 40x objective" &&
        nodeName == "objective_40x") {
      updateAgendaStatus(currentTask, true);
      handleCorrectNodeTap(nodeName);
    } else if (currentTask == "Click on the 100x objective" &&
        nodeName == "objective_102x") {
      updateAgendaStatus(currentTask, true);
      handleCorrectNodeTap(nodeName);
    } else {
      setState(() {
        wrongAnswers++;
      });
    }
  }

  void handleCorrectNodeTap(String nodeName) {
    if (nodeName == "base") {
      setState(() {
        microscopeTurnedOn = true;
        showClickButtonInstruction = true;
        enableOnlyNode("objective_10x");
      });
    } else if (nodeName == "objective_10x") {
      setState(() {
        show10xImage = true;
        showCoarseFocusSlider = false;
        showCoarseFocusInstruction = true;
        showCoarseFocusButtonText = true;
        showObjective10xInstruction = false;
      });
    } else if (nodeName == "objective_40x") {
      setState(() {
        show40xImage = true;
        showEyepiece40x =
            true; // Add this line to ensure the 40x eyepiece view is shown
        showFineFocusSlider = false;
        showFineFocusButtonText = true;
        showObjective40xInstruction = false;
        show40xFineFocusInstruction = true;
        showNextTextFor40x = false;
      });
    } else if (nodeName == "objective_102x") {
      setState(() {
        show100xImage =
            true; // Ensure this is set to true when 100x is selected
        showFineFocusSlider = false;
        showObjective100xInstruction = false;
        show100xFineFocusInstruction = true;
        showNextTextFor100x = false;
        showEyepiece100x = true; // Display the 100x eyepiece image
      });
    }
  }

  void enableOnlyNode(String nodeName) {
    arObjectManager!.onNodeTap = (tappedNodes) {
      tappedNodes.forEach((name) {
        handleNodeTap(name);
      });
    };
  }

  void handleButtonPress(String buttonType) {
    if (!modelPlaced) return;

    if (buttonType == "coarse_focus") {
      if (show10xImage) {
        setState(() {
          showCoarseFocusSlider = !showCoarseFocusSlider;
          showFineFocusSlider = false;
          showNewSlider = false; // Ensure other sliders are hidden
        });
      } else {
        setState(() {
          wrongAnswers++;
        });
      }
    } else if (buttonType == "fine_focus") {
      if (show40xImage || show100xImage) {
        setState(() {
          showCoarseFocusSlider = false;
          showFineFocusSlider = !showFineFocusSlider;
          showNewSlider = false; // Ensure other sliders are hidden
          showNewButton =
              true; // Display the illuminator button after fine focus
          showClickButtonInstruction =
              true; // Show instruction to click the new button
        });
      } else {
        setState(() {
          wrongAnswers++;
        });
      }
    } else if (buttonType == "new_button") {
      setState(() {
        showNewSlider = !showNewSlider; // Toggle the illuminator slider
        showCoarseFocusSlider = false; // Ensure other sliders are hidden
        showFineFocusSlider = false;
        showClickButtonInstruction = false; // Hide instruction after clicking
        updateAgendaStatus("Turn on the illuminator", true); // Update agenda
      });
    } else if (buttonType == "10x" && microscopeTurnedOn) {
      handleNodeTap("objective_10x");
    } else if (buttonType == "40x" && showNextTextFor40x) {
      handleNodeTap("objective_40x");
    } else if (buttonType == "100x" && showNextTextFor100x) {
      handleNodeTap("objective_102x");
    } else if (buttonType == "oil_button") {
      setState(() {
        showStageText = true; // Show the text to tap on the stage
        showNextTextForOilButton = false; // Hide the oil button text
      });
    } else {
      setState(() {
        wrongAnswers++;
      });
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
                'Correct: $correctAnswers   Wrong: $wrongAnswers',
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
              icon: Icon(Icons.list, color: Colors.white),
              onPressed: () {
                setState(() {
                  showAgendaList = !showAgendaList;
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
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          if (!welcomeMessageShown && modelPlaced)
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
                          'Welcome to the AR Microscope Learning Module!',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'You will learn about viewing specimens using both low and high objectives. Tap the screen to proceed.',
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
                              welcomeMessageShown = true;
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
          if (showInstructions)
            Positioned(
              top: 100,
              right: 16,
              left: 16,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Instructions',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // Add instructions here
                  ],
                ),
              ),
            ),
          if (showAgendaList)
            Positioned(
              top: 0, // Align to the top
              right: 0, // Align to the right edge
              child: Container(
                width: 172,
                height: 200, // Set a fixed height for the container
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tasks to complete',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                          height:
                              4), // Add some space between the title and the new text
                      Text(
                        'Scroll down to view more',
                        style: TextStyle(
                          fontSize: 10, // Smaller font size
                          color: Colors.grey, // Light gray color
                        ),
                      ),
                      SizedBox(
                          height:
                              8), // Add some space before the list of agendas
                      ...agendas.map((agenda) {
                        return Row(
                          children: [
                            Icon(
                              agenda.isCompleted
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                agenda.title,
                                style: TextStyle(
                                  fontSize: 8,
                                  color: agenda.isCompleted
                                      ? Colors.green
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
          if (welcomeMessageShown && !agendaViewed)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Click on the agenda icon at the top right corner to view the tasks you need to complete.',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          agendaViewed = true;
                        });
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          if (agendaViewed && !readyToProceed)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'In this activity, you will learn to view specimens using both low and high objectives. Are you ready to proceed with the learning activity?',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          readyToProceed = true;
                          enableOnlyNode("base");
                        });
                      },
                      child: Text('Start'),
                    ),
                  ],
                ),
              ),
            ),
          if (readyToProceed && !microscopeTurnedOn)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Turn on the microscope by clicking on the power on.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          if (microscopeTurnedOn &&
              showClickButtonInstruction &&
              !showNewQuestionText)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Click the Illuminator Button to adjust the lighting to 5.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          if (showNewSlider)
            Positioned(
              top: MediaQuery.of(context).size.height /
                  1.6, // Adjust this value to move it downwards
              right: 16,
              left: 16,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Illuminator Intensity: ${newSliderValue.round()}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Slider(
                      value: newSliderValue,
                      min: 0,
                      max: 10,
                      divisions: 10,
                      label: newSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          newSliderValue = value;
                          if (newSliderValue == 5) {
                            showNewQuestionText = true;
                            showNewSlider = false;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          if (showNewQuestionText &&
              microscopeTurnedOn &&
              !show10xImage &&
              !showObjective10xInstruction)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'There is a blood specimen on the stage. Start by clicking on the lowest objective, 10x objective to view it.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          if (show10xImage)
            Stack(
              children: [
                if (showEyepiece10x)
                  Positioned(
                    top: 0, // Move upwards
                    left: 0, // Align to the top left
                    child: ClipRect(
                      child: Container(
                        color: Colors.black,
                        margin: EdgeInsets.only(bottom: 16),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: getBlurSigma(blurValue, 8),
                                sigmaY: getBlurSigma(blurValue, 8),
                              ),
                              child: Image.asset(
                                'assets/lesson1&2/10x.png',
                                width: 172,
                                height: 150,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '10x eyepiece view',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (showCoarseFocusInstruction)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Click on the coarse focus button and adjust the focusing to view the specimen clearly.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                if (showCoarseFocusSlider && !showFineFocusSlider)
                  Positioned(
                    top: MediaQuery.of(context).size.height /
                        1.6, // Adjust this value to move it downwards
                    right: 16,
                    left: 16,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Coarse Focus Scale: ${blurValue.round()}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Slider(
                            value: blurValue,
                            min: 0,
                            max: 10,
                            divisions: 10,
                            label: blurValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                blurValue = value;
                                if (blurValue == 8) {
                                  show10xDiscussion = true;
                                  showObjective10xInstruction = false;
                                  showCoarseFocusInstruction = false;
                                  showCoarseFocusButtonText = false;
                                  showNextTextFor40x = false;
                                  updateAgendaStatus(
                                      "Fix the viewing of the specimen in 10x",
                                      true);
                                  enableOnlyNode("objective_40x");
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                if (show10xDiscussion && !showNextTextFor40x)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Take a look at the view of the specimen at 10x. Notice the details you can observe at this magnification.',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showNextTextFor40x = true;
                                show10xDiscussion = false;
                              });
                            },
                            child: Text('Next'),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (showNextTextFor40x && !showObjective40xInstruction)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Now let’s try to look at the specimen at low objective 40x. Click on the 40x objective to proceed.',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          if (show40xImage)
            Stack(
              children: [
                if (showEyepiece40x)
                  Positioned(
                    top: 0, // Move upwards
                    left: 0, // Align to the top left
                    child: ClipRect(
                      child: Container(
                        color: Colors.black,
                        margin: EdgeInsets.only(bottom: 16),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: getBlurSigma(blurValue, 8) +
                                    getBlurSigma(secondBlurValue, 5),
                                sigmaY: getBlurSigma(blurValue, 8) +
                                    getBlurSigma(secondBlurValue, 5),
                              ),
                              child: Image.asset(
                                'assets/lesson1&2/40x.png',
                                width: 172,
                                height: 150,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '40x eyepiece view',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (show40xFineFocusInstruction)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Click on the fine focus button and adjust the focusing to view the specimen clearly.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                if (showFineFocusSlider)
                  Positioned(
                    top: MediaQuery.of(context).size.height /
                        1.6, // Adjust this value to move it downwards
                    right: 16,
                    left: 16,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Fine Focus Scale: ${secondBlurValue.round()}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Slider(
                            value: secondBlurValue,
                            min: 0,
                            max: 10,
                            divisions: 10,
                            label: secondBlurValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                secondBlurValue = value;
                                if (blurValue == 8 && secondBlurValue == 5) {
                                  show40xDiscussion = true;
                                  showObjective40xInstruction = false;
                                  showFineFocusButtonText = false;
                                  show40xFineFocusInstruction = false;
                                  updateAgendaStatus(
                                      "Fix the viewing of the specimen in 40x",
                                      true);
                                  enableOnlyNode("objective_102x");
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                if (show40xDiscussion && !showRotateNosepieceText)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Take a look at the view of the specimen at 40x. Notice the increased details at this higher magnification.',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showRotateNosepieceText = true;
                                show40xDiscussion = false;
                              });
                            },
                            child: Text('Next'),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (showRotateNosepieceText && !showNextTextFor100x)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Rotate the nosepiece away.',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Tap the button below to proceed.',
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
                                updateAgendaStatus(
                                    "Rotate the nosepiece away", true);

                                showNextTextForOilButton = true;
                                showRotateNosepieceText = false;
                                showEyepiece10x =
                                    false; // Hide 10x eyepiece image
                                showEyepiece40x =
                                    false; // Hide 40x eyepiece image
                              });
                            },
                            child: Text('Rotate Nosepiece'),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          if (showNextTextForOilButton)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Click on the oil button.',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          if (showStageText)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Tap on the stage.',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          if (showOilExplanationText)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Oil immersion has now been applied to the specimen on the stage.',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showOilExplanationText =
                              false; // Hide this text after explaining
                          showNextTextFor100x =
                              true; // Show the next step for 100x
                          enableOnlyNode(
                              "objective_102x"); // Enable the 100x objective
                        });
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          if (showNextTextFor100x && !showObjective100xInstruction)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Now let’s try to look at the specimen at the highest objective, 100x. Click on the 100x objective to proceed.',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          if (show100xImage)
            Stack(
              children: [
                if (showEyepiece100x)
                  Positioned(
                    top: 0, // Move upwards
                    left: 0, // Align to the top left
                    child: ClipRect(
                      child: Container(
                        color: Colors.black,
                        margin: EdgeInsets.only(bottom: 16),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: getBlurSigma(blurValue, 8) +
                                    getBlurSigma(secondBlurValue, 9),
                                sigmaY: getBlurSigma(blurValue, 8) +
                                    getBlurSigma(secondBlurValue, 9),
                              ),
                              child: Image.asset(
                                'assets/lesson1&2/100x.png',
                                width: 172,
                                height: 150,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '100x eyepiece view',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (show100xFineFocusInstruction)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Click on the fine focus button and adjust the focusing to view the specimen clearly.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                if (showFineFocusSlider)
                  Positioned(
                    top: MediaQuery.of(context).size.height /
                        1.6, // Adjust this value to move it downwards
                    right: 16,
                    left: 16,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Fine Focus Scale: ${secondBlurValue.round()}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Slider(
                            value: secondBlurValue,
                            min: 0,
                            max: 10,
                            divisions: 10,
                            label: secondBlurValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                secondBlurValue = value;
                                if (blurValue == 8 && secondBlurValue == 9) {
                                  show100xDiscussion = true;
                                  showObjective100xInstruction = false;
                                  showFineFocusButtonText = false;
                                  show100xFineFocusInstruction = false;
                                  updateAgendaStatus(
                                      "Fix the viewing of the specimen in 100x",
                                      true);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                if (show100xDiscussion && !showTotalScore)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Take a look at the view of the specimen at 100x. Notice the increased details at this highest magnification.',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showTotalScore = true;
                                show100xDiscussion = false;
                              });
                            },
                            child: Text('Next'),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (showTotalScore && !showActivityRecap)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Quiz Completed!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Your Score: ${correctAnswers - wrongAnswers} / ${agendas.length}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            correctAnswers - wrongAnswers >= 7
                                ? 'You Passed!'
                                : 'You Did Not Pass. Try Again.',
                            style: TextStyle(
                              fontSize: 20,
                              color: correctAnswers - wrongAnswers >= 7
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          if (wrongAgendas.isNotEmpty) ...[
                            Text(
                              'Incorrect Answers:',
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            ),
                            SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var wrongAgenda in wrongAgendas)
                                  Text(
                                    wrongAgenda,
                                    style: TextStyle(color: Colors.red),
                                  ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showActivityRecap = true;
                                showTotalScore = false;
                              });
                            },
                            child: Text('Next'),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (showActivityRecap && !showEndText)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'You have learned to view specimens using different magnifications (10x, 40x, 100x) and adjusted the focus for clear viewing.',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showEndText = true;
                                showActivityRecap = false;
                              });
                            },
                            child: Text('Next'),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (showEndText)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'This concludes the activity. Click the button below to exit and proceed with the next AR activity.',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Exit'),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          if (modelPlaced && welcomeMessageShown)
            Positioned(
              bottom: 200,
              left: 16,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        handleButtonPress("coarse_focus");
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/lesson1&2/assets/coarse/coarse.png',
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                        ),
                        Text(
                          'Coarse Focus',
                          style: TextStyle(fontSize: 4),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(4),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        handleButtonPress("fine_focus");
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/lesson1&2/assets/fine/fine.png',
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                        ),
                        Text(
                          'Fine Focus',
                          style: TextStyle(fontSize: 4),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(4),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        handleButtonPress("new_button");
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/lesson1&2/assets/lamp/illuminator.png',
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                        ),
                        Text(
                          'Lamp',
                          style: TextStyle(fontSize: 4),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(4),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Add the action for the oil button here
                      setState(() {
                        updateAgendaStatus("Click on the oil button", true);

                        handleButtonPress("oil_button");
                      });
                    },
                    child: Column(
                      children: [
                        Icon(Icons.opacity,
                            size: 40), // Example icon for the oil button
                        Text(
                          'Oil',
                          style: TextStyle(fontSize: 4),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(4),
                    ),
                  ),
                ],
              ),
            ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!surfaceDetected || (surfaceDetected && !modelPlaced))
                  Column(
                    children: [
                      Icon(Icons.camera, size: 100, color: Colors.white),
                      SizedBox(height: 20),
                      Text(
                        'Scan the surface and Tap the screen to place the models',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          backgroundColor: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (modelPlaced && welcomeMessageShown)
            Positioned(
              bottom: 180,
              right: 16,
              child: Column(
                children: [
                  if (showObjectives)
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              handleButtonPress("10x");
                            });
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/hologram/objective/10x.png',
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                              Text(
                                '10x',
                                style: TextStyle(fontSize: 4),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(6),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              handleButtonPress("40x");
                            });
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/hologram/objective/40x.png',
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                              Text(
                                '40x',
                                style: TextStyle(fontSize: 4),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(6),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              handleButtonPress("100x");
                            });
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/hologram/objective/100x.png',
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                              Text(
                                '100x',
                                style: TextStyle(fontSize: 4),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(6),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 20),
                ],
              ),
            ),
        ],
      ),
    );
  }

  double getBlurSigma(double value, double clearValue) {
    return (clearValue - value).abs();
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
      if (!surfaceDetected) {
        setState(() {
          surfaceDetected = true;
        });
      } else if (!modelPlaced) {
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
              name: "Objective Lenses",
              modelPath: "assets/hologram/objective/objective3.gltf",
              position:
                  vector.Vector3(0.04, 0.10, 0.175), // Further moved left (X)
              scale: vector.Vector3(1.0, 1.0, 1.0),
            ),
            SceneNode(
              name: "base",
              modelPath: "assets/hologram/objective/base2.gltf",
              position: vector.Vector3(0.1, -0.0180516, 0.135067),
              scale: vector.Vector3(0.1, 0.1, 0.1),
            ),
            SceneNode(
              name: "bakit", // The stage node
              modelPath: "assets/hologram/stage/bakit2.gltf",
              position: vector.Vector3(0.05, 0.06, 0.15),
              scale: vector.Vector3(0.1, 0.1, 0.1),
            ),
            SceneNode(
              name: "eye1",
              modelPath: "assets/hologram/eyepiece/eye2.gltf",
              position: vector.Vector3(-0.03, 0.16, 0.17),
              scale: vector.Vector3(0.1, 0.1, 0.1),
            ),
            SceneNode(
              name: "nose",
              modelPath: "assets/hologram/nose/nose2.gltf",
              position: vector.Vector3(-0.02, 0.14, 0.17),
              scale: vector.Vector3(0.1, 0.1, 0.1),
            ),
            SceneNode(
              name: "coarse_focus",
              modelPath: "assets/hologram/coarse/coarse2.gltf",
              position: vector.Vector3(-0.05, 0.0704573, 0.085877),
              scale: vector.Vector3(0.1, 0.1, 0.1),
            ),
            SceneNode(
              name: "fine_focus",
              modelPath: "assets/hologram/fine/fine4.gltf",
              position: vector.Vector3(0.12, 0.01, 0.1078705),
              scale: vector.Vector3(0.1, 0.1, 0.1),
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
        rotation: vector.Vector4(0, 1, 0, 6.2832),
        name: sceneNode.name,
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
        // Handle model taps here if needed
      });
    };
  }
}
