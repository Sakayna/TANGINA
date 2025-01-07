import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_Topics/Bacteria_Topic_4_1.dart';
import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_Topics/Bacteria_Topic_4_1_2.dart';
import 'package:capstone/categories/bacteria_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Bacteria_Topic_4_1_1 extends StatefulWidget {
  @override
  _Bacteria_Topic_4_1_1State createState() => _Bacteria_Topic_4_1_1State();
}

class _Bacteria_Topic_4_1_1State extends State<Bacteria_Topic_4_1_1> {
  final FlutterTts flutterTts = FlutterTts();
  bool isTTSEnabled = false;

  // Text-to-Speech function
  Future<void> speakText() async {
    if (isTTSEnabled) {
      String content = '''
      Bacteria may be Gram-positive or Gram-negative. 
      Gram-positive bacteria retain the purple crystal violet stain when subjected to the Gram-staining procedure. 
      Gram-negative bacteria do not retain the crystal violet stain and are counterstained by safranin, giving them a reddish or pinkish color.
      This distinction is attributed to the composition of the bacterial cell wall, which is a vital structure and an important receptor site for the attack of antibiotics.
      Compared to Gram-positive bacteria, Gram-negative bacteria are more resistant to antibiotics due to their impenetrable walls.
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Color(0xFFFF6A6A), // Background color
                    floating: false,
                    pinned: false,
                    snap: false,
                    expandedHeight: 120.0,
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        final isTop =
                            constraints.biggest.height <= kToolbarHeight + 16.0;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isTop) ...[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 50.0),
                                child: Text(
                                  'Funji, Protists, and Bacteria',
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
                                  '4.1.1 - Distinct Groups of Bacteria',
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
                          stopTextToSpeech(); // Stop TTS
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Bacteria_Screen(),
                          ));
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
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Bacteria may be Gram positive or Gram negative. Such distinction can be observed when bacteria are subjected to the Gram-staining process. Hans C.J. Gram, a microbiologist, developed the Gram-stain technique. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'Gram-positive bacteria ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'are those that retain the purple crystal violet stain when subjected to the Gram-staining procedure. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'Gram-negative bacteria ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'in contrast, do not retain the crystal violet stain. Thus, they are counterstained by safranin, a dye that gives them the reddish or pinkish color.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child: Container(
                                  width: 600,
                                  height: 350,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          'assets/images/bacteria/gram positive and negative .jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Gram Positive and Negative Bacteria',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'This distinction is attributed to the composition of the bacterial cell wall. In bacteria, the cell wall is a very essential structure for a very important reason: it is an important receptor site for the attack of antibiotics and other drugs (for pathogenic bacteria).',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Research made about the composition of the bacterial cell walls revealed that the cell wall of Gram- positive bacteria is simple. It exists as a uniformly thick layer (15-80 nanometers) composed mainly of several layers of peptidoglycan (murein) complexed with teichoic acids, which are considered unique components of the Gram-positive cell wall.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'In contrast, the cell wall of Gram-negative bacteria is relatively thin (10 nanometers) but multilayered. It consists of a relatively thin layer of peptidoglycan (murein) and an outer membrane composed of phospholipid protein-lipopolysaccharide (LPS or endotoxin) that is very toxic to animals. The existence of this outer membrane prevents the penetration of the purple stain.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Compared to Gram-positive bacteria, Gram-negative bacteria are more resistant against antibodies because of their impenetrable wall. The existence of these two strains is the basis used by physicians in prescribing medicines to cure bacterial infections.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
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
                        stopTextToSpeech(); // Stop TTS
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Bacteria_Topic_4_1(),
                          ),
                        );
                      },
                      heroTag: 'prevBtn',
                      child: Icon(
                        Icons.navigate_before,
                        color: Colors.white,
                      ),
                      backgroundColor: Color(0xFFFF6A6A),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        stopTextToSpeech(); // Stop TTS
                        globalVariables.setTopic('lesson4', 3, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Bacteria_Topic_4_1_2(),
                          ),
                        );
                      },
                      heroTag: 'nextBtn',
                      child: Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                      ),
                      backgroundColor: Color(0xFFFF6A6A),
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

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Bacteria_Topic_4_1_1(),
    ),
  ));
}
