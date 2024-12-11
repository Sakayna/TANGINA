import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import '../../../classes/change_notifier.dart';
import '../../../classes/scenenode.dart';
import '../../../components/choice_button.dart';



class ModuleScreen extends StatefulWidget  {
  const ModuleScreen({super.key});

  _ModuleScreenPage createState() => _ModuleScreenPage();
}

class _ModuleScreenPage extends State<ModuleScreen> {

  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];
  List<Map<String, dynamic>> nodeOrder = [];
  String? currentNodeTapped;

  var singleHit = null;
  int objectBoardIndex = 1;
  List<SceneNode> sceneNodes = [
    SceneNode(name:"bot", modelPath: "assets/bot/scene.gltf", position: vector.Vector3(0.3, 0.4, 0.15), scale: vector.Vector3(0.5, 0.5, 0.3)),
    SceneNode(name:"1", modelPath:"assets/lesson3/assets/blocks/cells.gltf", position:vector.Vector3(0.0, 0, 0), scale:vector.Vector3(.15, .15, .15)),
    SceneNode(name:"2", modelPath:"assets/lesson3/assets/blocks/tissues.gltf", position:vector.Vector3(0.0, 0.1, 0), scale:vector.Vector3(.15, .15, .15)),
    SceneNode(name:"3", modelPath:"assets/lesson3/assets/blocks/organs.gltf", position:vector.Vector3(0.0, 0.2, 0.0), scale:vector.Vector3(.15, .15, .15)),
    SceneNode(name:"4", modelPath:"assets/lesson3/assets/blocks/organsystem.gltf", position:vector.Vector3(0.0, 0.3, 0.0), scale:vector.Vector3(.15, .15, .15)),
    SceneNode(name:"5", modelPath:"assets/lesson3/assets/blocks/organism.gltf", position:vector.Vector3(0.0, 0.4, 0.0), scale:vector.Vector3(.15, .15, .15)),
    SceneNode(name:"6", modelPath:"assets/lesson3/assets/blocks/population.gltf", position:vector.Vector3(0.0, 0.5, 0.0), scale:vector.Vector3(.15, .15, .15)),
    SceneNode(name:"7", modelPath:"assets/lesson3/assets/blocks/comm.gltf", position:vector.Vector3(0.0, 0.6, 0.0), scale:vector.Vector3(.15, .15, .15)),
    SceneNode(name:"8", modelPath:"assets/lesson3/assets/blocks/ecosystem.gltf", position:vector.Vector3(0.0, 0.7, 0.0), scale:vector.Vector3(.15, .15, .15)),
    SceneNode(name:"9", modelPath:"assets/lesson3/assets/blocks/biomes.gltf", position:vector.Vector3(0.0, 0.8, 0.0), scale:vector.Vector3(.15, .15, .15)),
    SceneNode(name:"10", modelPath:"assets/lesson3/assets/blocks/biosphere.gltf", position:vector.Vector3(0.0, 0.9, 0.0), scale:vector.Vector3(.15, .15, .15)),


  ];

  late UpdateNotify updateNotify;
  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    updateNotify = Provider.of<UpdateNotify>(context);
    updateNotify.onDescriptionChange = () {
      // print(objectBoardIndex);
      if (objectBoardIndex == 1) {
        addNodeToAnchor(sceneNodes[0]);
        addNodeToAnchor(sceneNodes[1]);
      }
      if (objectBoardIndex == 2) {
        addNodeToAnchor(sceneNodes[2]);
        addNodeToAnchor(sceneNodes[3]);
      }
      if (objectBoardIndex == 3) {
        addNodeToAnchor(sceneNodes[4]);
        addNodeToAnchor(sceneNodes[5]);
      }
      if (objectBoardIndex == 4) {
        addNodeToAnchor(sceneNodes[6]);
        addNodeToAnchor(sceneNodes[7]);
      }
      if (objectBoardIndex == 5) {
        addNodeToAnchor(sceneNodes[8]);
        addNodeToAnchor(sceneNodes[9]);
      }
      if (objectBoardIndex == 6) {
        addNodeToAnchor(sceneNodes[10]);
      }
      objectBoardIndex++;

      //  // Call addNodeToAnchor method whenever nextDescription is called
      //       if (objectBoardIndex == 0 || objectBoardIndex == 1 || objectBoardIndex == 14) {
      //         for (var anchor in anchors) {
      //           arAnchorManager!.removeAnchor(anchor);
      //         }
      //         anchors = [];
    };

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // Navigate back to previous page
            },
          ),
        ),
        body: Stack(
          children: [
            ARView(
              onARViewCreated: onARViewCreated,
              planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (updateNotify.currentDescription[1].length != 0)
                    Column(
                      children: List.generate(
                        updateNotify.currentDescription[1].length,
                            (index) => ChoiceButton(
                          choice: updateNotify.currentDescription[1][index],
                          onPressed: () {
                            updateNotify.chooseAnswer(updateNotify.currentDescription[1][index]);
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),

             Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: performUpAction,
                          child: const Text('Move it upwards'),
                        ),
                        ElevatedButton(
                          onPressed: performDownAction,
                          child: const Text('Move it downwards'),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child: Text(
                        updateNotify.currentDescription[0] ?? '',
                        style: const TextStyle(fontSize: 20.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );

  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      showWorldOrigin: false,
      // handlePans: true,
    );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
    this.arObjectManager!.onNodeTap = onNodeTapped;
    // this.arObjectManager!.onPanStart = onPanStarted;
    // this.arObjectManager!.onPanChange = onPanChanged;
    // this.arObjectManager!.onPanEnd = onPanEnded;
  }

  Future<void> onNodeTapped(List<String> nodeNames) async {
    for (var node in nodes) {
      if (node.name == nodeNames.first) {
        currentNodeTapped = node.name;
        arSessionManager!.onError('You selected $currentNodeTapped!');
      }
    }
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    var singleHitTestResult = hitTestResults.firstWhere(
            (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
    if (singleHit == null) {
      singleHit = singleHitTestResult;
      updateNotify.startTimer();
    }
  }

  bool isDone() {
    return nodeOrder.asMap().entries.every((entry) => entry.key + 1 == entry.value['order']);
  }

  void performUpAction() {
    if (currentNodeTapped != null) {
      // arSessionManager!.onError("here");
      // print(nodeOrder.length);
      // Find the tapped node
      for (int i = 0; i < nodeOrder.length; i++) {
        // arSessionManager!.onError("there");
        var element = nodeOrder[i];
        var na = element['name'];
        // arSessionManager!.onError(" $na $currentNodeTapped");
        if (element["name"] == currentNodeTapped) {
          vector.Vector3 currentNewPos = element["pos"];
          // Check if there is a next element in nodeOrder
          if (i + 1 < nodeOrder.length) {
            var nextElement = nodeOrder[i + 1];
            vector.Vector3 nextNewPos = nextElement["pos"];

            for (var anchor in anchors) {
              // arSessionManager!.onError(anchor.name);
              if (anchor.name == element["anchor"] || anchor.name == nextElement["anchor"]) {
                arAnchorManager!.removeAnchor(anchor);
              }
            }

            if(currentNewPos.y + 0.1 <= 0.9 && nextNewPos.y - 0.1 >= 0.0) {
              addNodeToAnchor(SceneNode(name: element["name"], modelPath: element["path"],
                  position: vector.Vector3(currentNewPos.x, nextNewPos.y, currentNewPos.z),
                  scale:vector.Vector3(.15, .15, .15)));
              addNodeToAnchor(SceneNode(name: nextElement["name"], modelPath: nextElement["path"],
                  position: vector.Vector3(nextNewPos.x, currentNewPos.y, nextNewPos.z),
                  scale:vector.Vector3(.15, .15, .15)));
              break;
            }
          }
        }
      }
      if (isDone()) {
        arSessionManager!.onError("done");
      }
    }
  }

  void performDownAction() {
    if (currentNodeTapped != null) {
      // Find the tapped node
      for (int i = 0; i < nodeOrder.length; i++) {
        var element = nodeOrder[i];
        if (element["name"] == currentNodeTapped) {
          vector.Vector3 currentNewPos = element["pos"];
          // Check if there is a next element in nodeOrder
          if (i - 1 > 0) {
            var nextElement = nodeOrder[i - 1];
            vector.Vector3 nextNewPos = nextElement["pos"];

            for (var anchor in anchors) {
              if (anchor.name == element["anchor"] || anchor.name == nextElement["anchor"]) {
                arAnchorManager!.removeAnchor(anchor);
              }
            }
            if(currentNewPos.y - 0.1 <= 0.9 && nextNewPos.y + 0.1 >= 0.0) {
              addNodeToAnchor(SceneNode(name: element["name"], modelPath: element["path"],
                  position: vector.Vector3(currentNewPos.x, nextNewPos.y, currentNewPos.z),
                  scale:vector.Vector3(.15, .15, .15)));
              addNodeToAnchor(SceneNode(name: nextElement["name"], modelPath: nextElement["path"],
                  position: vector.Vector3(nextNewPos.x, currentNewPos.y, nextNewPos.z),
                  scale:vector.Vector3(.15, .15, .15)));
              nodeOrder.removeAt(i);
              nodeOrder.removeAt(i - 1);
              break;
            }
          }
        }
      }
      if (isDone()) {
        arSessionManager!.onError("done");
      }
    }
  }
  Future<void> addNodeToAnchor(SceneNode sceneNode) async {
    var singleHitTestResult = singleHit;
    var newAnchor =
    ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
    bool? didAddAnchor = await arAnchorManager!.addAnchor(newAnchor);
    if (didAddAnchor!) {
      anchors.add(newAnchor);

      // Add note to anchor
      var newNode = ARNode(
          type: NodeType.localGLTF2,
          uri: sceneNode.modelPath,
          scale: sceneNode.scale,
          position: sceneNode.position,
          rotation: vector.Vector4(1.0, 0.0, 0.0, 0.0));
      bool? didAddNodeToAnchor =
      await arObjectManager!.addNode(newNode, planeAnchor: newAnchor);
      if (didAddNodeToAnchor!) {
        // arSessionManager!.onError(newAnchor.name);
        int order = int.parse(sceneNode.name);
        nodes.add(newNode);
        nodeOrder.add({
          'order': order,
          'name': newNode.name,
          'anchor': newAnchor.name,
          'path': sceneNode.modelPath,
          'pos': sceneNode.position,
        });
        print(nodeOrder.length);
      } else {
        arSessionManager!.onError("Adding Node to Anchor failed");
      }
    } else {
      arSessionManager!.onError("Adding Anchor failed");
    }
  }
  // onPanStarted(String nodeName) {
  //   print("Started panning node " + nodeName);
  // }
  //
  // onPanChanged(String nodeName) {
  //   print("Continued panning node " + nodeName);
  // }
  //
  // onPanEnded(String nodeName, Matrix4 newTransform) {
  //   print("Ended panning node " + nodeName);
  //   final pannedNode =
  //   nodes.firstWhere((element) => element.name == nodeName);
  //
  //   /*
  //   * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
  //   * (e.g. if you intend to share the nodes through the cloud)
  //   */
  //   //pannedNode.transform = newTransform;
  // }

}



