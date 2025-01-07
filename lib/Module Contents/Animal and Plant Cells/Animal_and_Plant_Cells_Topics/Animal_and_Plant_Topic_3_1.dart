import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_ILO/Animal_and_Plant_Cells_ILO.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_Topics/Animal_and_Plant_Topic_3_2.dart';
import 'package:capstone/categories/animal_and_plant_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Animal_and_Plant_Topic_3_1 extends StatefulWidget {
  @override
  State<Animal_and_Plant_Topic_3_1> createState() =>
      _Animal_and_Plant_Topic_3_1State();
}

class _Animal_and_Plant_Topic_3_1State
    extends State<Animal_and_Plant_Topic_3_1> {
  final FlutterTts flutterTts = FlutterTts();
  bool isTTSEnabled = false; // TTS toggle state

  // Function to speak text
  Future<void> speakText() async {
    if (isTTSEnabled) {
      String content = '''
      Living things vary in terms of the number of cells they have. Some living things are multicellular, made up of many cells. Others are single-celled or unicellular. 
      Two types of cells compose living things. Some living things, as in the case of bacteria and cyanobacteria, have prokaryotic cells. These organisms are called prokaryotes. Prokaryotic cells lack distinct nuclei and have few organelles that are not membrane-bound. In contrast, eukaryotic cells have distinct nuclei and contain several membrane-bound organelles. Animals, plants, fungi, and protists have eukaryotic cells; and they are called eukaryotes.
      However, whether the cells are prokaryotic or eukaryotic, they share some common features. Take note of the location of the DNA molecule. The DNA molecule in both cells is contained within the chromosomes. In plant cells, the chromosomes are in the nucleus, which is bound by a double membrane. Bacterial cells have their chromosomes in a non-membrane-bound region called the nucleoid. This indicates that the internal organization of eukaryotic cells is more complex than prokaryotic cells.
      What are the common features of the two cells? The functions of these structures found in both cells will be discussed later in this section. Take note of the location of the DNA molecule. The DNA molecule in both cells is contained within the chromosomes. However, in the plant cell, the chromosomes are contained within the nucleus that is bound by a double membrane, and there are numerous organelles that are also membrane-bound. Whereas in the bacterial cell, the chromosomes are simply contained in a non-membrane-bound region called the nucleoid, and there are few organelles found in the cell. This tells us that the internal organization of the cells of eukaryotes is more complex than the cells of prokaryotes. 
      ''';
      await flutterTts.speak(content);
    }
  }

  // Function to stop TTS
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
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Animal_and_Plant_Screen(),
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
                    backgroundColor: Color(0xFFA1C084),
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
                                  'Animal and Plant Cells',
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
                                  '3.1 - Types of Cells Found in Living Things',
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
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: () {
                          stopTextToSpeech();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Animal_and_Plant_Screen(),
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
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 80.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(width: 40),
                                    ),
                                    TextSpan(
                                      text:
                                          'Living things vary in terms of the number of cells they have. Some living things are ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'multicellular ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'made up of many cells. Others are single-celled or ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'unicellular ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
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
                                      child: SizedBox(width: 40),
                                    ),
                                    TextSpan(
                                      text:
                                          'Two types of cells compose living things. Some living things as in the case of bacteria and cyanobacteria have prokaryotic cells (pro = before; karyon = nucleus). These organisms are called prokaryotes. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'Prokaryotic cells ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'lack distinct nuclei and have few organelles that are not membrane-bound. In contrast, ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'Eukaryotic cells ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          '(eu = true; karyon = nucleus) have distinct nuclei and contain several membrane-bound organelles. Animals, plants, fungi, and protists have eukaryotic cells; and they are called eukaryotes. ',
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
                                      child: SizedBox(width: 40),
                                    ),
                                    TextSpan(
                                      text:
                                          'However, whether the cells are prokaryotic or eukaryotic, they share some common features. Take a look at the image below that shows the cell structure of a bacterium representing a prokaryotic cell and a plant cell representing a eukaryotic cell. ',
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
                                      child: SizedBox(width: 40),
                                    ),
                                    TextSpan(
                                      text:
                                          'What are the common features of the two cells? The functions of these structures found in both cells will be discussed later in this section. Take note of the location of the DNA molecule. The DNA molecule in both cells is contained within the chromosomes. However, in the plant cell, the chromosomes are contained within the nucleus that is bound by a double membrane, and there are numerous organelles that are also membrane-bound. Whereas in the bacterial cell, the chromosomes are simply contained in a non-membrane-bound region called the nucleoid, and there are few organelles found in the cell. This tells us that the internal organization of the cells of eukaryotes is more complex than the cells of prokaryotes. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors
                                              .grey[300]!, // Thin grey border
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/cells/bacteria cell.png',
                                            height:
                                                150, // Adjust height as needed
                                            width: double
                                                .infinity, // Take full width of the container
                                            fit: BoxFit
                                                .contain, // Ensure the image is fully visible
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            ' (A) Bacteria Cell',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10), // Space between cells
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors
                                              .grey[300]!, // Thin grey border
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/cells/plant cell.png',
                                            height:
                                                150, // Adjust height as needed
                                            width: double
                                                .infinity, // Take full width of the container
                                            fit: BoxFit
                                                .contain, // Ensure the image is fully visible
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '(B) Plant Cell',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            10), // Space between cells and the text
                                    Text(
                                      'Comparison of a prokaryotic cell (A) and a eukaryotic cell (B)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height:
                                      20), // Space between cells and the text
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
                  FloatingActionButton(
                    onPressed: () {
                      stopTextToSpeech(); // Stop TTS before navigating back
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Animal_and_Plant_ILO_Screen(),
                        ),
                      );
                    },
                    heroTag: 'prevBtn',
                    child: Icon(Icons.navigate_before, color: Colors.white),
                    backgroundColor: Color(0xFFA1C084),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      stopTextToSpeech(); // Stop TTS before navigating to the next screen
                      globalVariables.setTopic('lesson3', 2, true);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Animal_and_Plant_Topic_3_2(),
                        ),
                      );
                    },
                    heroTag: 'nextBtn',
                    child: Icon(Icons.navigate_next, color: Colors.white),
                    backgroundColor: Color(0xFFA1C084),
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
      body: Animal_and_Plant_Topic_3_1(),
    ),
  ));
}
