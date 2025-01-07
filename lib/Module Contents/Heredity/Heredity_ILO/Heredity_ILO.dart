import 'package:capstone/Module%20Contents/Heredity/Heredity_Topics/Heredity_Topic_5_1.dart';
import 'package:capstone/categories/heredity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Heredity_ILO_Screen extends StatefulWidget {
  @override
  _Heredity_ILO_ScreenState createState() => _Heredity_ILO_ScreenState();
}

class _Heredity_ILO_ScreenState extends State<Heredity_ILO_Screen> {
  late FlutterTts flutterTts;
  bool isTTSEnabled = false;

  @override
  void initState() {
    super.initState();

    // Initialize FlutterTTS
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
      Intended Learning Outcomes:
      At the end of this lesson, students should attain the following:
      1. Differentiate asexual from sexual reproduction in terms of:
        - Number of individuals involved.
        - Similarities of offspring to parents.
      2. Describe the process of fertilization.
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
            builder: (context) => Heredity_Screen(),
          ),
        );
        return false;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xFF64B6AC), // Background color of appbar
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
                      'Heredity: ', // Title text for the appbar
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
                      'ILO 5.1', // Additional text for the appbar
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
                        builder: (context) => Heredity_Screen(),
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
                            '• Differentiate asexual from sexual reproduction in terms of:',
                            style: TextStyle(fontSize: 14)),
                        SizedBox(height: 8), // Add space between the bullets
                        Text('      ○ 7.1 number of individuals involved;',
                            style: TextStyle(fontSize: 14)),
                        Text(
                            '      ○ 7.2 similarities of offspring to parents;',
                            style: TextStyle(fontSize: 14)),

                        SizedBox(height: 12),
                        Text('• Describe the process of fertilization;',
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
            globalVariables.setTopic('lesson5', 1, true);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Heredity_Topic_5_1(),
              ),
            );
          },
          child: const Icon(
            Icons.navigate_next,
            color: Colors.white, // Set icon color to white
          ),
          backgroundColor: Color(0xFF64B6AC), // Button color set to hex #729B79
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.endFloat, // Positioning the button
      ),
    );
  }
}
