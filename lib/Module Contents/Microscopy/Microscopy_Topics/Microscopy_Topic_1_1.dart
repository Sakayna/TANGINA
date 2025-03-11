import 'package:capstone/Module%20Contents/Microscopy/Microscopy_ILO/Microscopy_ILO.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_Topics/Microscopy_Topic_1_2.dart';
import 'package:capstone/categories/microscopy_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Microscopy_Topic_1_1 extends StatefulWidget {
  @override
  State<Microscopy_Topic_1_1> createState() => _Microscopy_Topic_1_1State();
}

class _Microscopy_Topic_1_1State extends State<Microscopy_Topic_1_1> {
  final FlutterTts flutterTts = FlutterTts();
  bool isTTSEnabled = false; // Toggle for Text-to-Speech

  // Function to read text aloud
  Future<void> speakText(String content) async {
    if (isTTSEnabled) {
      await flutterTts.speak(content);
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

    // Combine all TTS text content
    final List<String> ttsContents = [
      'How Can We See the Details of Bacteria?',
      'With the naked eye, bacteria just look like a slimy smear on a petri dish. The invention of the microscope allows us to see bacteria, cells, and other microscopic structures.'
          'The Microscope',
      'Microscopes are essential tools in biology. They help us study objects that are too small to be seen by the human eye. Microscopy is the study of small objects using microscopes.'
          'Invention of the Microscope',
      'Over 400 years ago, Zacharias Janssen and his son Hans experimented with lenses and discovered magnification. '
          'This led to the creation of the first compound microscope.'
          'Robert Hooke and the Discovery of Cells',
      'In 1665, Robert Hooke used a microscope to examine cork. He discovered small structures, which he called "cells," '
          'leading to the development of cell theory.'
          'Antonie van Leeuwenhoek and Microorganisms',
      'Antonie van Leeuwenhoek created one of the first microscopes. '
          'He observed bacteria, single-celled protists, and sperm cells, pioneering microbiology.'
    ];

    return WillPopScope(
      onWillPop: () async {
        stopTextToSpeech(); // Stop TTS when navigating back
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MicroscopyScreen(),
          ),
          (Route<dynamic> route) => false,
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Color(0xFFFFA551),
                    floating: false,
                    pinned: false,
                    snap: false,
                    expandedHeight: 120.0,
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        final isTop = constraints.biggest.height <=
                            kToolbarHeight + 16.0; // Margin size
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isTop) ...[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 50.0),
                                child: Text(
                                  'Microscopy',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(left: 50.0),
                                child: Text(
                                  'Topics',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 50.0, right: 18.0),
                                child: Text(
                                  '1.1 - The Microscope and Its Historical Development',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: () {
                          stopTextToSpeech(); // Stop TTS before navigating back
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MicroscopyScreen(),
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
                              speakText(ttsContents.join(' ')); // Read all TTS
                            } else {
                              stopTextToSpeech(); // Stop reading
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
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 80.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildLessonText(
                                  'How Can We See the Details of Bacteria?',
                                  'With the naked eye, bacteria just look like a slimy smear on a petri dish. The invention of the microscope allows us to see bacteria, cells, and other microscopic structures.'),

                              buildLessonText('The Microscope',
                                  'Microscopes are essential tools in biology. They help us study objects that are too small to be seen by the human eye. Microscopy is the study of small objects using microscopes.'),

                              buildLessonText(
                                  'Invention of the Microscope',
                                  'Over 400 years ago, Zacharias Janssen and his son Hans experimented with lenses and discovered magnification. '
                                      'This led to the creation of the first compound microscope.'),

                              buildImage(
                                  'assets/images/Microscopy/Zacharias.jpg',
                                  'Zacharias Janssen'),
                              SizedBox(height: 10),

                              buildLessonText(
                                  'Robert Hooke and the Discovery of Cells',
                                  'In 1665, Robert Hooke used a microscope to examine cork. He discovered small structures, which he called "cells," '
                                      'leading to the development of cell theory.'),
                              SizedBox(height: 10),

                              buildImage('assets/images/Microscopy/Collage.png',
                                  'Robert Hooke\'s Discovery of Cells'),
                              SizedBox(height: 10),

                              buildLessonText(
                                  'Antonie van Leeuwenhoek and Microorganisms',
                                  'Antonie van Leeuwenhoek created one of the first microscopes. '
                                      'He observed bacteria, single-celled protists, and sperm cells, pioneering microbiology.'),

                              SizedBox(height: 20),

                              // Website Reference
                              Text(
                                'Reference: https://flexbooks.ck12.org/cbook/ck-12-middle-school-life-science-2.0/section/1.6/primary/lesson/microscopes-ms-ls/',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MicroscopyILOScreen(),
                          ),
                        );
                      },
                      heroTag: 'prevBtn',
                      child: Icon(
                        Icons.navigate_before,
                        color: Colors.white,
                      ),
                      backgroundColor: Color(0xFFFFA551),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        stopTextToSpeech(); // Stop TTS before moving forward
                        globalVariables.setTopic('lesson1', 2, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Microscopy_Topic_1_2(),
                          ),
                        );
                      },
                      heroTag: 'nextBtn',
                      child: Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                      ),
                      backgroundColor: Color(0xFFFFA551),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper function for lesson text
Widget buildLessonText(String title, String content) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: '$title\n',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          TextSpan(text: content, style: TextStyle(fontSize: 14)),
        ],
      ),
      textAlign: TextAlign.justify,
    ),
  );
}

// Helper function for images
Widget buildImage(String imagePath, String caption) {
  return Column(
    children: [
      Image.asset(imagePath,
          width: double.infinity, height: 250, fit: BoxFit.contain),
      SizedBox(height: 10),
      Text(caption,
          textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
    ],
  );
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Microscopy_Topic_1_1(),
    ),
  ));
}
