import 'package:capstone/Module%20Contents/Levels%20of%20Biological%20Organization/Levels_of_Biological_Organization_Topics/Levels_of_Biological_Organization_Topic_2_1..dart';
import 'package:capstone/categories/levels_of_biological_organization_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Biological_Organization_ILOScreen extends StatefulWidget {
  @override
  _Biological_Organization_ILOScreenState createState() =>
      _Biological_Organization_ILOScreenState();
}

class _Biological_Organization_ILOScreenState
    extends State<Biological_Organization_ILOScreen> {
  final FlutterTts flutterTts = FlutterTts();
  bool isTTSEnabled = false; // Toggle for TTS

  // TTS Content
  final String ttsContent =
      'ILO: At the end of this lesson, students should attain the following: '
      'Describe the different levels of biological organization from cell to biosphere.';

  // Function to speak text
  Future<void> speakText() async {
    if (isTTSEnabled) {
      await flutterTts.speak(ttsContent);
    }
  }

  // Function to stop TTS
  Future<void> stopTextToSpeech() async {
    await flutterTts.stop();
  }

  @override
  void dispose() {
    stopTextToSpeech(); // Ensure TTS stops when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    return WillPopScope(
      onWillPop: () async {
        stopTextToSpeech(); // Stop TTS when navigating back
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Levels_of_biological_organization_Screen(),
          ),
          (Route<dynamic> route) => false,
        );
        return false;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xFF9463FF), // Background color of appbar
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
                      'Levels of Biological Organization', // Title text for the appbar
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
                      'ILO 2.1', // Additional text for the appbar
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
                    stopTextToSpeech(); // Stop TTS when navigating back
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Levels_of_biological_organization_Screen(),
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
                        speakText();
                      } else {
                        stopTextToSpeech();
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
                          '• Describe the different levels of biological organization from cell to biosphere;',
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
            stopTextToSpeech(); // Stop TTS before navigating forward
            globalVariables.setTopic('lesson2', 1, true);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Biological_Organization_Topic_2_1(),
              ),
            );
          },
          child: const Icon(
            Icons.navigate_next,
            color: Colors.white, // Set icon color to white
          ),
          backgroundColor: Color(0xFF9463FF), // Button color set to hex #729B79
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
