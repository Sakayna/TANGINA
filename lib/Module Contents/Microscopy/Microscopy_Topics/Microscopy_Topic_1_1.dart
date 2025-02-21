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
      'The microscope is a precision instrument and the commonly used tool in conducting biological researches and in studying objects or organisms or parts of organisms that are invisible or only slightly visible to the naked eye. '
          'This part will discuss the historical development of the microscope, the parts and functions of a light compound microscope, and their proper use and care.',
      'The discovery of lenses started during the first century AD when glass had been invented. The Romans discovered that clear glass shaped like a lentil bean could enlarge objects. They called it lens.',
      'In 1590, Zaccharias Janssen and his brother Hans invented the compound microscope.',
      'Anton Van Leeuwenhoek made a simple microscope with powerful magnification and observed bacteria, yeasts, and red blood cells. He was called the Father of Microscopy.',
      'Robert Hooke discovered compartments in cork using a compound microscope and called them cells.'
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
                                      text: 'The ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'microscope',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          ' is a precision instrument and the commonly used tool in conducting biological researches and in studying objects or organisms or parts of organisms that are invisible or only slightly visible to the naked eye. '
                                          'This part will discuss the historical development of the microscope, the parts and functions of a light compound microscope, and their proper use and care.',
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
                                          ' The discovery of lenses started during the first century AD (year 100), when glass had been invented. The Romans, after looking through and testing the different shapes of glasses, were able to discover a clear glass that was thick in the middle and thin on the edges. They discovered that if you look through an object using this glass, the object would look larger. They called this clear glass ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'lens',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    TextSpan(
                                      text: ', derived from the Latin term ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'lentil',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    TextSpan(
                                      text:
                                          ' because it resembled the shape of a lentil bean.',
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
                                          'In 1590, two Dutch eyeglass makers named ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'Zaccharias Janssen',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          ' and his brother Hans started experimenting using lenses. They got a tube and put lenses on each end and started observing objects. The Janssens were amazed that the object they observed was greatly enlarged, much larger than a magnifying glass can enlarge. The Janssen brothers made a very important discovery, a compound microscope. Compound because it uses two or more lenses.',
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
                                      text: 'Anton Van Leeuwenhoek',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          ' (1632-1723) during his time was able to make a simple microscope, and he made several biological breakthroughs using it. Although Leeuwenhoek\'s microscope is composed only of a single lens, its magnification is so powerful that it can enlarge objects 270 times. He was the first to observe bacteria, yeasts, red blood cells, and he described colonies of protozoans teeming in a drop of rainwater which he called ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'animalcules',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    TextSpan(
                                      text:
                                          '. These breakthroughs earned him the title "Father of Microscopy."',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 30.0), // Add left padding
                                child: Container(
                                  width: 300, // Adjust width as needed
                                  height: 350, // Adjust height as needed
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/Microscopy/Zacharias.jpg',
                                        height: 250, // Adjust height as needed
                                        width: 300, // Adjust width as needed
                                        fit: BoxFit
                                            .contain, // Ensure the image is fully visible
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Zaccharias Janssen',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 18.0), // Add left padding
                                child: Container(
                                  width: 400, // Adjust width as needed
                                  height: 250, // Adjust height as needed
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/Microscopy/compound_.jpg',
                                          height:
                                              200, // Adjust height as needed
                                          width: 400, // Adjust width as needed
                                          fit: BoxFit
                                              .contain, // Ensure the image is fully visible
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Janssen\'s compound microscope',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Robert Hooke',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ', an Englishman, also spent much of his life working with microscopes improving their design and capabilities. Hooke, using his improved compound microscope, discovered tiny compartments in a thin slice of cork. He called these compartments ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'cells.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 18.0), // Add left padding
                                child: Container(
                                  width: 400, // Adjust width as needed
                                  height: 200, // Adjust height as needed
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/Microscopy/Collage.png',
                                          height:
                                              200, // Adjust height as needed
                                          width: 400, // Adjust width as needed
                                          fit: BoxFit
                                              .contain, // Ensure the image is fully visible
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Microscopy_Topic_1_1(),
    ),
  ));
}
