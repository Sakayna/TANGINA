import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_1.dart';
import 'package:capstone/categories/ecosystem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class Ecosystem_ILO_Screen extends StatefulWidget {
  @override
  _Ecosystem_ILO_ScreenState createState() => _Ecosystem_ILO_ScreenState();
}

class _Ecosystem_ILO_ScreenState extends State<Ecosystem_ILO_Screen> {
  late FlutterTts flutterTts;
  bool isTTSEnabled = false;

  @override
  void initState() {
    super.initState();

    // Initialize the TTS controller
    flutterTts = FlutterTts();
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> speakText() async {
    if (isTTSEnabled) {
      String content = '''
ILO At the end of this lesson, students should attain the following:
• Differentiate biotic from abiotic components of an ecosystem;
• Describe the different ecological relationships found in an ecosystem;
• Predict the effect of changes in one population on other populations in the ecosystem;
• Predict the effect of changes in abiotic factors on the ecosystem.
''';
      await flutterTts.speak(content);
    }
  }

  Future<void> stopTextToSpeech() async {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    return WillPopScope(
      onWillPop: () async {
        stopTextToSpeech();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Ecosystem_Screen(),
          ),
        );
        return false;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xFFA846A0), // Background color of appbar
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
                      'Ecosystem', // Title text for the appbar
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
                      'ILO 6.1', // Additional text for the appbar
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
                    stopTextToSpeech();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Ecosystem_Screen(),
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
                            '• Differentiate biotic from abiotic components of an ecosystem;',
                            style: TextStyle(fontSize: 14)),
                        SizedBox(height: 12),
                        Text(
                            '• Describe the different ecological relationships found in an ecosystem;',
                            style: TextStyle(fontSize: 14)),
                        SizedBox(height: 12),
                        Text(
                            '• Predict the effect of changes in one population on other populations in the ecosystem; ',
                            style: TextStyle(fontSize: 14)),
                        SizedBox(height: 12),
                        Text(
                            '• Predict the effect of changes in abiotic factors on the ecosystem.',
                            style: TextStyle(fontSize: 14)),
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
            stopTextToSpeech();
            globalVariables.setTopic('lesson6', 1, true);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Ecosystem_Topic_6_1(),
              ),
            );
          },
          child: const Icon(
            Icons.navigate_next,
            color: Colors.white, // Set icon color to white
          ),
          backgroundColor: Color(0xFFA846A0), // Button color set to hex #729B79
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.endFloat, // Positioning the
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Ecosystem_ILO_Screen(),
    ),
  ));
}
