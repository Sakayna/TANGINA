import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_TLA/Animal_and_Plant_Cells_TLA_3_1.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_Topics/Animal_and_Plant_Topic_3_3.dart';
import 'package:capstone/categories/animal_and_plant_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Animal_and_Plant_Topic_3_4 extends StatefulWidget {
  @override
  _Animal_and_Plant_Topic_3_4State createState() =>
      _Animal_and_Plant_Topic_3_4State();
}

class _Animal_and_Plant_Topic_3_4State
    extends State<Animal_and_Plant_Topic_3_4> {
  final FlutterTts flutterTts = FlutterTts();
  bool isTTSEnabled = false; // TTS toggle state

  // Function to handle text-to-speech
  Future<void> speakText() async {
    if (isTTSEnabled) {
      String content = '''
      Cells are the basic structural units of life. You have seen the shapes of the plant and animal cells. However, shapes of cells can vary widely. Cells have different shapes because they do different things. Their shapes enable them to perform the task assigned to them properly and efficiently. There are more than 200 different shapes and sizes of cells in your body doing many different jobs.
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
                    backgroundColor: Color(0xFFA1C084), // Background color
                    floating: false,
                    pinned: false,
                    snap: false,
                    expandedHeight: 120.0, // Adjusted expanded height
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
                                    top: 25.0, left: 50.0), // Add left padding
                                child: Text(
                                  'Animal and Plant Cells', // Title
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white, // Set text color
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(left: 50.0),
                                child: Text(
                                  'Topics', // Subtitle
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white, // Set text color
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 50.0, right: 18.0),
                                child: Text(
                                  '3.4: Shape of Cells', // Additional text
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white, // Set text color
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
                        color: Colors.white, // Icon color
                        onPressed: () {
                          stopTextToSpeech(); // Stop TTS
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
                                          'Cells are the basic structural units of life. You have seen the shapes of the plant and animal cells.However, shapes of cells can vary widely. Cells have different shapes because they do different things. Their shapes enable them to perform the task assigned to them properly and efficiently. There are more than 200 different shapes and sizes of cell in your body doing many different jobs. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 30),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Variation in Cell Shape',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0), // Add left padding
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Table(
                                      columnWidths: {
                                        0: FixedColumnWidth(
                                            120), // Width of the 1st column
                                        1: FixedColumnWidth(
                                            150), // Width of the 2nd column
                                        2: FixedColumnWidth(
                                            300), // Width of the 3rd column
                                      },
                                      border: TableBorder.all(
                                          width: 1.0,
                                          color:
                                              Colors.grey), // Thin grey border
                                      children: [
                                        TableRow(children: [
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Text('Cell Shapes')),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Text('Description')),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Text('Examples')),
                                            ),
                                          )
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('Spherical'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('Round or oval'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/cells/red blood cells.jpg',
                                                    width:
                                                        150, // Larger width for the image
                                                    height:
                                                        150, // Larger height for the image
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                      'Human red blood cells (erythrocytes)'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('Squamous'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('Flat or tilelike'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/cells/squamous cell.jpg',
                                                    width:
                                                        150, // Larger width for the image
                                                    height:
                                                        150, // Larger height for the image
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text('Human squamous cells'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('Stellate'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('Starlike'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/cells/neuron.jpg',
                                                    width:
                                                        150, // Larger width for the image
                                                    height:
                                                        150, // Larger height for the image
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text('Nerve cell or neuron'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('Spiderlike'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  'With several cytoplasmic extensions'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/cells/bone cell.jpg',
                                                    width:
                                                        150, // Larger width for the image
                                                    height:
                                                        150, // Larger height for the image
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text('Bone cells'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('Columnar'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  'Rectangular set upright'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/cells/columnar cell.jpg',
                                                    width:
                                                        150, // Larger width for the image
                                                    height:
                                                        150, // Larger height for the image
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text('Columnar cells'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text('Fusiform/Spindle'),
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    'Tapering at both ends'),
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/cells/smooth muscle cell.jpg',
                                                      width:
                                                          150, // Larger width for the image
                                                      height:
                                                          150, // Larger height for the image
                                                      fit: BoxFit.contain,
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text('Smooth muscle cells'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Add more rows here...
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
              color: Colors.white, // Set background color
              width: double.infinity, // Full screen width
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
                            builder: (context) => Animal_and_Plant_Topic_3_3(),
                          ),
                        );
                      },
                      heroTag: 'prevBtn',
                      child: Icon(Icons.navigate_before, color: Colors.white),
                      backgroundColor: Color(0xFFA1C084),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        stopTextToSpeech(); // Stop TTS
                        globalVariables.setTopic('lesson3', 5, true);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Animal_and_Plant_TLA_3_1(),
                          ),
                        );
                      },
                      heroTag: 'nextBtn',
                      child: Icon(Icons.navigate_next, color: Colors.white),
                      backgroundColor: Color(0xFFA1C084),
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
      body: Animal_and_Plant_Topic_3_4(),
    ),
  ));
}
