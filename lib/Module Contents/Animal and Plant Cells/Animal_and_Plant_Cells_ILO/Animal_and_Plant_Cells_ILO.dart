import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_Topics/Animal_and_Plant_Topic_3_1.dart';
import 'package:capstone/categories/animal_and_plant_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Animal_and_Plant_ILO_Screen extends StatefulWidget {
  @override
  State<Animal_and_Plant_ILO_Screen> createState() =>
      _Animal_and_Plant_ILO_ScreenState();
}

class _Animal_and_Plant_ILO_ScreenState
    extends State<Animal_and_Plant_ILO_Screen> {
  final FlutterTts flutterTts = FlutterTts();
  bool isTTSEnabled = false; // TTS toggle state

  // Function to start text-to-speech
  Future<void> speakText() async {
    if (isTTSEnabled) {
      String content = '''
        ILO: At the end of this lesson, students should attain the following:
        • Differentiate plant and animal cells according to presence or absence of certain organelles;
        • Explain why the cell is considered the basic structural and functional unit of all organisms;
      ''';
      await flutterTts.speak(content);
    }
  }

  // Function to stop text-to-speech
  Future<void> stopTextToSpeech() async {
    await flutterTts.stop();
  }

  @override
  void dispose() {
    stopTextToSpeech(); // Stop TTS when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    return WillPopScope(
      onWillPop: () async {
        stopTextToSpeech(); // Stop TTS when navigating back
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Animal_and_Plant_Screen(),
          ),
        );
        return false;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xFFA1C084), // Background color of appbar
              pinned: true, // Make the appbar pinned
              expandedHeight: 120.0, // Height of the appbar
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 50, // Adjusted left padding
                  right: 10, // Adjusted right padding
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:
                      MainAxisAlignment.end, // Align title at the bottom
                  children: [
                    Text(
                      'Animal and Plant Cells', // Title text for the appbar
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                    SizedBox(height: 5), // Adjusted spacing between texts
                    Text(
                      'Intended Learning Outcomes', // Subtitle text for the appbar
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'ILO 3.1', // Additional text for the appbar
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                  ],
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(
                  top: 20, // Adjusted top padding of the leading icon
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios), // Back button icon
                  color: Colors.white, // Back button icon
                  onPressed: () {
                    stopTextToSpeech(); // Stop TTS before navigating back
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Animal_and_Plant_Screen(),
                      ),
                    );
                  },
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    isTTSEnabled ? Icons.volume_up : Icons.volume_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isTTSEnabled = !isTTSEnabled;
                      if (isTTSEnabled) {
                        speakText(); // Start TTS when enabled
                      } else {
                        stopTextToSpeech(); // Stop TTS when disabled
                      }
                    });
                  },
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      25.0,
                      30.0,
                      25.0,
                      80.0,
                    ), // Padding for content
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ILO: At the end of this lesson, students should attain the following:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        Text(
                          '• Differentiate plant and animal cells according to presence or absence of certain organelles;',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 12),
                        Text(
                          '• Explain why the cell is considered the basic structural and functional unit of all organisms;',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            stopTextToSpeech(); // Stop TTS before navigating to the next page
            globalVariables.setTopic('lesson3', 1, true);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Animal_and_Plant_Topic_3_1(),
              ),
            );
          },
          child: const Icon(
            Icons.navigate_next,
            color: Colors.white, // Set icon color to white
          ),
          backgroundColor: Color(0xFFA1C084), // Button color set to hex #729B79
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.endFloat, // Positioning the button
      ),
    );
  }
}
