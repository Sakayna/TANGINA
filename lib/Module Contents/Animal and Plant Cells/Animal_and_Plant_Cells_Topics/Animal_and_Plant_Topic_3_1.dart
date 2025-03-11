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
      String content = 
      
                                          'Cells function differently in unicellular and multicellular organisms. A unicellular organism depends upon just one cell for all of its functions while a multicellular organism has cells specialized to perform different functions that collectively support the organism. '
                                                                                    'Biotic components of the environment include all forms of life from minute bacteria to towering giant Sequoias. However, at the microscopic level, all living organisms are made up of the same basic unit – the cell.'
                                                                                                                              'As a result, the cell is referred to as the structural and functional unit of all living organisms. The word cell has its origins in Latin, and when translated, it means “small room” and was first observed by Robert Hooke – an English natural philosopher in the year 1665. '
                                                                                                                                                                        'Eventual advancements in science and technology shed more light into the cell, with new findings and discoveries about its structure and cellular components. During the 1950s, scientists postulated the concept of prokaryotic cells and eukaryotic cells, with earlier groundwork being laid by Edouard Chatton, a French Biologist in 1925.'
                                                                                                                                                                                                                  'Eventual advancements in science and technology shed more light into the cell, with new findings and discoveries about its structure and cellular components. During the 1950s, scientists postulated the concept of prokaryotic cells and eukaryotic cells, with earlier groundwork being laid by Edouard Chatton, a French Biologist in 1925.'
                                                                                                                                                                                                                        
      
      
      ;
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
                                          'Cells function differently in unicellular and multicellular organisms. A unicellular organism depends upon just one cell for all of its functions while a multicellular organism has cells specialized to perform different functions that collectively support the organism. ',
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
                                          'Biotic components of the environment include all forms of life from minute bacteria to towering giant Sequoias. However, at the microscopic level, all living organisms are made up of the same basic unit – the cell.',
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
                                          'As a result, the cell is referred to as the structural and functional unit of all living organisms. The word cell has its origins in Latin, and when translated, it means “small room” and was first observed by Robert Hooke – an English natural philosopher in the year 1665. ',
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
                                          'Eventual advancements in science and technology shed more light into the cell, with new findings and discoveries about its structure and cellular components. During the 1950s, scientists postulated the concept of prokaryotic cells and eukaryotic cells, with earlier groundwork being laid by Edouard Chatton, a French Biologist in 1925.'
                                          'Anatomically, cells vary with respect to their classification, therefore, prokaryotic cells and eukaryotic cells differ from each other quite drastically. Read on to explore how they differ from each other. ',
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

                              Text(
                                'Reference: https://byjus.com/biology/prokaryotic-and-eukaryotic-cells/',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
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
