import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_Topics/Bacteria_Topic_4_1_1.dart';
import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_Topics/Bacteria_Topic_4_1_3.dart';
import 'package:capstone/categories/bacteria_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Bacteria_Topic_4_1_2 extends StatefulWidget {
  @override
  _Bacteria_Topic_4_1_2State createState() => _Bacteria_Topic_4_1_2State();
}

class _Bacteria_Topic_4_1_2State extends State<Bacteria_Topic_4_1_2> {
  final FlutterTts flutterTts = FlutterTts();
  bool isTTSEnabled = false;

  // Function to read the content aloud
  Future<void> speakText() async {
    if (isTTSEnabled) {
      String content = '''
      Microbiologists employ various techniques to classify bacteria. Observing the appearance of bacterial colonies in a petri dish can help identify species. 
      Bacteria fall into three morphological categories: cocci, bacilli, and spirilla. 
      Cocci are round bacterial cells that can exist singly, in pairs (diplococci), chains (streptococci), or clusters (staphylococci).
      Bacilli are rod-shaped bacteria, while spirilla are spiral-shaped bacteria, often flagellated and capable of movement.
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
                                  '4.1.2 - Bacterial Shapes and Cellular Arrangements',
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
                                          'Microbiologists employ a wide variety of techniques as they classify bacteria. Observing the appearance of the colony they form as they grow in a petri dish can help identify some bacterial species. A bacterial colony is a group of the same kind of bacteria growing together on a specific culture medium placed on a petri dish.',
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
                                          'Various staining processes are also used to identify their properties. The most advanced technique is to analyze the DNA structure of the bacterial species. However, the most basic method that microbiologists use in identifying bacteria is to view them under the microscope to identify their shapes, the cell arrangement or groupings that they form, and other features like the number and arrangement of the flagella.',
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
                                          'In terms of shape, bacteria fall into three morphological categories: ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'cocci, baccili, ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    TextSpan(
                                      text: 'and ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'spirilla. ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    TextSpan(
                                      text:
                                          'Cellular Arrangement pertains to how the bacterial cells are arranged or grouped after their cells divide, whether singly, in chains, or in clusters.',
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
                                  height: 250,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          'assets/images/bacteria/cocci.png',
                                          fit: BoxFit.contain,
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
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Cocci ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          '(Singular: coccus) are round bacterial cells. Cocci can exist singly or as diplococci (in pairs), as packs like tetrads (consisting of four cells), or as sarcinae (consisting of eight cells), as streptococci (in chains),and as staphylococci (in clusters like a bunch of grapes).',
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
                                          'The examples of medically important cocci are enumerated in the Table below.',
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
                                      text: 'Cellular Arrangement and Samples',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Table(
                                columnWidths: {
                                  0: FixedColumnWidth(120),
                                  1: FixedColumnWidth(190),
                                },
                                border: TableBorder.all(),
                                children: [
                                  TableRow(children: [
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child:
                                                Text('Cellular Arrangement')),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(child: Text('Example')),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Single'),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Chlamydia trachomatis',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Diplococcus'),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Neisseria meningitidis',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Tetrad'),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Micrococcus',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Sarcina (Octad)'),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Sarcina ventriculi',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Streptococcus'),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Streptococcus pyogenes',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Staphylococcus'),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Staphylococcus aureus',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child: Container(
                                  width: 600,
                                  height: 300,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          'assets/images/bacteria/bacilli.jpg',
                                          fit: BoxFit.contain,
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
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Bacilli ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          '(Singular: bacillus) are rod-shaped or cigar-shaped bacteria. The length of the cell varies according to age and environmental conditions. Bacilli, unlike the cocci bacteria, have fewer groupings since they only divide across their short axis. Thus, they only exist singly, as diplobaccilli, and as streptobacilli. Escherichia coli and Bacillis megaterium are respective examples of single and streptobacilli.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 30),
                              Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child: Container(
                                  width: 600,
                                  height: 250,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          'assets/images/bacteria/spirilla.jpg',
                                          fit: BoxFit.contain,
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
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Spirilla ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          '(Singular: spirillum) are curved (vibrio), twisted or spiral- shaped bacteria with fairly rigid bodies. Many species of spirilla are flagellated and are capable of movement. A group of spirilla known as spirochetes have helical bodies that are long, slender, and flexible.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
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
                        stopTextToSpeech(); // Stop TTS
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Bacteria_Topic_4_1_1(),
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
                        globalVariables.setTopic('lesson4', 4, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Bacteria_Topic_4_1_3(),
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
      body: Bacteria_Topic_4_1_2(),
    ),
  ));
}
