import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_ILO/Bacteria_ILO.dart';
import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_Topics/Bacteria_Topic_4_1_1.dart';
import 'package:capstone/categories/bacteria_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Bacteria_Topic_4_1 extends StatefulWidget {
  @override
  _Bacteria_Topic_4_1State createState() => _Bacteria_Topic_4_1State();
}

class _Bacteria_Topic_4_1State extends State<Bacteria_Topic_4_1> {
  final FlutterTts flutterTts = FlutterTts();
  bool isTTSEnabled = false;

  // Text-to-Speech function
  Future<void> speakText() async {
    if (isTTSEnabled) {
      String content = '''
      During the ancient time, bacteria and other forms of prokaryotes were thought of as simply "packs of enzymes" with no distinct structures. Knowledge about the structure of bacteria began in 1950 when the electron microscope was invented. It was then that biologists discovered that bacteria like any other organisms perform cellular functions that bring about the continuity of life.
     Bacteria are simple, unicellular organisms. There are about thousands of bacterial species on Earth and only few have been studied and identified. Bacteria obtain nutrients from their environment. Some species are free-living (saprotrophs), while others require the presence of hosts for survival (parasitic). As they invade the body of the hosts, they excrete waste materials and various types of toxins so as to invade the hosts\' tissues. The image shows the schematic diagram of a bacterium (bacillus type) viewed under an electron microscope.
     Bacterial cells have the following structural components:'
     The cell envelope encloses the contents of the cell. It consists of three layers:
     The cell wall provides strength and rigidity to the cell. It protects the cell from mechanical damage and resists cell rupture or lysis due to osmotic pressure.
     The plasma membrane that functions as the protective barrier of the cell\'s interior. Its composition is similar to that of the cells of eukaryotes.
     The capsule, which is a slimy layer or a biofilm, composed of polysaccharides deposited outside the cell wall that protects the cell from drying, for surface attachment, and as a carbohydrate reserve for future metabolism.
     The cytoplasm that fills the entire cell. It is the complex fluid that serves as the site where all metabolic reactions occur and where some non-membrane-bound organelles are located like:
     The chromosomes contain the DNA molecule for genetic instructions. It appears as a large, entangled loop located in the region of the cytoplasm called the nucleoid;
     The ribosomes are the organelles where protein synthesis occurs; and 
     Some storage granules and various forms of inclusions.
     Appendages such as:
     The flagella which are used for movement and surface attachment. The flagella are distributed over the surface of bacterial cells in genetically distinguishing patterns; and
     The pili or fimbriae, which are hairlike structures, function for adherence of bacteria to surfaces, substrates, and for attachment to the host and during sexual reproduction.
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
                    backgroundColor:
                        Color(0xFFFF6A6A), // Appbar background color
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
                                  '4.1 - Bacteria',
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
                                          'During the ancient time, bacteria and other forms of prokaryotes were thought of as simply "packs of enzymes" with no distinct structures. Knowledge about the structure of bacteria began in 1950 when the electron microscope was invented. It was then that biologists discovered that bacteria like any other organisms perform cellular functions that bring about the continuity of life.',
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
                                          'Bacteria are simple, unicellular organisms. There are about thousands of bacterial species on Earth and only few have been studied and identified. Bacteria obtain nutrients from their environment. Some species are free-living (saprotrophs), while others require the presence of hosts for survival (parasitic). As they invade the body of the hosts, they excrete waste materials and various types of toxins so as to invade the hosts\' tissues. The image shows the schematic diagram of a bacterium (bacillus type) viewed under an electron microscope.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 30),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 18.0), // Add left padding
                                child: Container(
                                  width: 600, // Adjust width as needed
                                  height: 350, // Adjust height as needed
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          'assets/images/bacteria/bactirum.jpg', // Updated image path
                                          fit: BoxFit
                                              .cover, // Ensure the image covers the entire space
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'A schematic diagram of a bacterium',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      // Add additional widgets below the text as needed
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 40),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'Bacterial cells have the following structural components:',
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
                                    TextSpan(
                                      text:
                                          '\u2022 The cell envelope encloses the contents of the cell. It consists of three layers:',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- The cell wall provides strength and rigidity to the cell. It protects the cell from mechanical damage and resists cell rupture or lysis due to osmotic pressure. ',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- The plasma membrane that functions as the protective barrier of the cell\'s interior. Its composition is similar to that of the cells of eukaryotes. ',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- The capsule, which is a slimy layer or a biofilm, composed of polysaccharides deposited outside the cell wall that protects the cell from drying, for surface attachment, and as a carbohydrate reserve for future metabolism.',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '\u2022 The cytoplasm that fills the entire cell. It is the complex fluid that serves as the site where all metabolic reactions occur and where some non-membrane-bound organelles are located like:',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- The chromosomes contain the DNA molecule for genetic instructions. It appears as a large, entangled loop located in the region of the cytoplasm called the nucleoid; ',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- The ribosomes are the organelles where protein synthesis occurs; and ',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- Some storage granules and various forms of inclusions.',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '\u2022 Appendages such as:',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- The flagella which are used for movement and surface attachment. The flagella are distributed over the surface of bacterial cells in genetically distinguishing patterns; and ',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- The pili or fimbriae, which are hairlike structures, function for adherence of bacteria to surfaces, substrates, and for attachment to the host and during sexual reproduction. ',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
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
                            builder: (context) => Bacteria_ILO_Screen(),
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
                        globalVariables.setTopic('lesson4', 2, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Bacteria_Topic_4_1_1(),
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
      body: Bacteria_Topic_4_1(),
    ),
  ));
}
