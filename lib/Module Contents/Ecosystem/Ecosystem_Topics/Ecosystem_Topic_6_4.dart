import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_3.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_4_1.dart';
import 'package:capstone/categories/ecosystem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class Ecosystem_Topic_6_4 extends StatefulWidget {
  @override
  _Ecosystem_Topic_6_4State createState() => _Ecosystem_Topic_6_4State();
}

class _Ecosystem_Topic_6_4State extends State<Ecosystem_Topic_6_4> {
  late FlutterTts flutterTts;
  bool isTTSEnabled = false;

  String content = '''
The sun is the ultimate source of energy. Energy enters the living system in the form of light. The transformation of energy begins when light is absorbed by photosynthetic autotrophs and is transformed into a high-energy chemical substance called ATP (Adenosine Triphosphate). ATP then is used in manufacturing food (glucose), another high-energy organic molecule. The process of making food is called photosynthesis. For this building-up process to go on continuously, there should be a constant supply of energy.

The raw materials of photosynthesis, carbon dioxide and water, as well as the other elements (phosphorus, calcium, nitrogen, carbon, etc.) that are essential to life, are obtained by living things from its environments—atmosphere, water, and soil—in a variety of ways. These materials are biochemically incorporated within the cells and tissues of living things as nutrients for healthy growth and development. Thus, these materials should always be available for all living things. With this, it can be said that for the ecosystem to function well and become stable, there should be a constant energy flow and materials should always be available for all living things to survive.
''';

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
  }

  Future<void> speakText() async {
    if (isTTSEnabled) {
      await flutterTts.speak(content);
    }
  }

  Future<void> stopTextToSpeech() async {
    await flutterTts.stop();
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
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
            builder: (context) => Ecosystem_Screen(),
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
                    backgroundColor: Color(0xFFA846A0),
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
                                  'Ecosystem',
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
                                  '6.4 - Functions of Ecosystem',
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
                          stopTextToSpeech();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Ecosystem_Screen(),
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
                                            'The sun is the ultimate source of energy. Energy enters the living system in the form of light. The transformation of energy begins when light is absorbed by photosynthetic autotrophs and is transformed into a high-energy chemical substance called ',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      TextSpan(
                                        text: 'ATP (Adenosine Triphosphate). ',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            'ATP then is used in manufacturing food (glucose), another high-energy organic molecule. The process of making food is called photosynthesis. For this building-up process to go on continuously, there should be a constant supply of energy.',
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
                                            'The raw materials of photosynthesis, carbon dioxide and water, as well as the other elements (phosphorus, calcium, nitrogen, carbon, etc.) that are essential to life, are obtained by living things from its environments-atmosphere, water, and soil-in a variety of ways. These materials are biochemically incorporated within the cells and tissues of living things as nutrients for healthy growth and development. Thus, these materials should always be available for all living things. With this, it can be said that for the ecosystem to function well and become stable, there should be a constant energy flow and materials should always be available for all living things to survive.',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(height: 20),
                              ]),
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
                        stopTextToSpeech();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Ecosystem_Topic_6_3(),
                          ),
                        );
                      },
                      heroTag: 'prevBtn',
                      child: Icon(Icons.navigate_before, color: Colors.white),
                      backgroundColor: Color(0xFFA846A0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        stopTextToSpeech();
                        globalVariables.setTopic('lesson6', 7, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Ecosystem_Topic_6_4_1(),
                          ),
                        );
                      },
                      heroTag: 'nextBtn',
                      child: Icon(Icons.navigate_next, color: Colors.white),
                      backgroundColor: Color(0xFFA846A0),
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
      body: Ecosystem_Topic_6_4(),
    ),
  ));
}
