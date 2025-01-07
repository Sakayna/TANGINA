import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_Topics/Bacteria_Topic_4_1.dart';
import 'package:capstone/categories/bacteria_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Bacteria_ILO_Screen extends StatefulWidget {
  @override
  _Bacteria_ILO_ScreenState createState() => _Bacteria_ILO_ScreenState();
}

class _Bacteria_ILO_ScreenState extends State<Bacteria_ILO_Screen> {
  final FlutterTts flutterTts = FlutterTts();
  bool isTTSEnabled = false;

  // Text-to-Speech function
  Future<void> speakText() async {
    if (isTTSEnabled) {
      String content = '''
      ILO: 
      At the end of this lesson, students should attain the following: 
      Identify beneficial and harmful microorganisms.
      ''';
      await flutterTts.speak(content);
    }
  }

  // Stop TTS
  Future<void> stopTextToSpeech() async {
    await flutterTts.stop();
  }

  @override
  void dispose() {
    stopTextToSpeech(); // Stop TTS when widget is disposed
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
            builder: (context) => Bacteria_Screen(),
          ),
        );
        return false;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xFFFF6A6A), // Appbar background color
              pinned: true,
              expandedHeight: 120.0,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 50,
                  right: 10,
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Funji, Protists, and Bacteria',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Intended Learning Outcomes',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'ILO 4.1',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    stopTextToSpeech(); // Stop TTS
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Bacteria_Screen(),
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
                    ),
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
                          '• Identify beneficial and harmful microorganisms;',
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
            stopTextToSpeech(); // Stop TTS
            globalVariables.setTopic('lesson4', 1, true);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Bacteria_Topic_4_1(),
              ),
            );
          },
          child: const Icon(
            Icons.navigate_next,
            color: Colors.white,
          ),
          backgroundColor: Color(0xFFFF6A6A),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Bacteria_ILO_Screen(),
    ),
  ));
}
