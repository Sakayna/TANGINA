import 'package:capstone/Module%20Contents/Heredity/Heredity_Topics/Heredity_Topic_5_2_1.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_Topics/Heredity_Topic_5_2_3.dart';
import 'package:capstone/categories/heredity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class Heredity_Topic_5_2_2 extends StatefulWidget {
  @override
  _Heredity_Topic_5_2_2State createState() => _Heredity_Topic_5_2_2State();
}

class _Heredity_Topic_5_2_2State extends State<Heredity_Topic_5_2_2> {
  late FlutterTts flutterTts;
  bool isTTSEnabled = false;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> speakText() async {
    if (isTTSEnabled) {
      String content = '''
Natural vegetative propagation is common among herbaceous and woody plants. It involves structural modifications of any plant parts (leaf, stem, or root) that can contribute to the survival and expansion in the population of the plant species. The new plants that emerged by this method are clones of the original plant. Natural means of vegetative propagation include:
Runners/Stolons: Slender prostate branches with nodes and internodes that grow above the ground. The nodes develop roots and buds that grow into a new plant. Examples are strawberry and grass plants.
Suckers: New stems grow from the root base of the existing plant. This new stem develops into a new plant. Examples are banana, dandelion, and rose plants.
Tubers: Swollen parts of an underground stem with pits or "eyes" where buds grow and develop into new plants. Examples are potato tubers, sweet potato, yam, carrot, and cassava.
Corms: Short, vertical underground stems with nodes and internodes where buds grow and develop into new plants. Examples are taro, cocoyam, and arrowhead.
Rhizomes: Long, horizontal underground stems with nodes and internodes. An example is ginger.
Bulbs: Short, underground stems with fleshy leaves (called scales) that store food. Examples are tulip and onion.
Notches: Structures found at the margins of some leaves where new tiny buds emerge. The buds develop into new plants that detach from the notch and live an independent existence. Examples are begonia and bryophyllum (also called kalanchoe).
''';
      await flutterTts.speak(content);
    }
  }

  Future<void> stopTextToSpeech() async {
    await flutterTts.stop();
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
            builder: (context) => Heredity_Screen(),
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
                    backgroundColor: Color(0xFF64B6AC),
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
                                  'Heredity',
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
                                  '5.2.2 - Natural Vegetative Propagation',
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
                            builder: (context) => Heredity_Screen(),
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
                                          'Natural vegetative propagation is common among herbaceous and woody plants. It involves structural modifications of any plant parts (leaf, stem, or root) that can contribute to the survival and expansion in the population of the plant species. The new plants that emerged by this method are clones of the original plant. Natural means of vegetative propagation includes:',
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
                                          '\u2022 Runners/Stolons - slender prostate branch with nodes and internodes that grow above the ground. The nodes develop roots and buds that grow into a new plant. Examples are strawberry and grass plants. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '\u2022 Suckers - new stems grow from the root base of the existing plant. This new stem develops into a new plant. Examples are banana, dandelion, and rose plants. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '\u2022 Tubers - swollen parts of an underground stem with pits or "eyes" where buds grow and develop into new plants. Examples are potato tubers that may also come from swollen roots (called root tubers), sweet potato, yam, carrot, and cassava. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '\u2022 Corms - short, vertical underground stems with nodes and internodes where buds grow and develop into new plants. Examples are taro, cocoyam, and arrowhead. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '\u2022 Rhizomes - long, horizontal underground stems with nodes and internodes. An example is ginger. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '\u2022 Bulbs - short, underground stems with fleshy leaves (called scales) that store food. Examples are tulip and onion.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '\u2022 Notches - structures found at the margins of some leaves where new tiny buds emerge. The buds develop into new plants that detach from the notch and live an independent existence. Examples are begonia and bryophyllum (also called kalanchoe).',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/images/heredity/run.jpg',
                                                  fit: BoxFit.cover,
                                                  width: 200,
                                                  height: 150,
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  'Runners from strawberry',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/images/heredity/suckers.jpg',
                                                  fit: BoxFit.cover,
                                                  width: 200,
                                                  height: 150,
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  'Sucker from banana plant',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/images/heredity/tubers.jpg',
                                                  fit: BoxFit.cover,
                                                  width: 200,
                                                  height: 120,
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  'Tubers (potato)',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/images/heredity/taro.jpg',
                                                  fit: BoxFit.cover,
                                                  width: 150,
                                                  height: 120,
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  'Corm (Taro)',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/images/heredity/re.jpg',
                                                  fit: BoxFit.cover,
                                                  width: 200,
                                                  height: 130,
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  'Rhizome (Ginger)',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/images/heredity/o.jpg',
                                                  fit: BoxFit.cover,
                                                  width: 200,
                                                  height: 130,
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  'Bulb (Onion)',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
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
                            builder: (context) => Heredity_Topic_5_2_1(),
                          ),
                        );
                      },
                      heroTag: 'prevBtn',
                      child: Icon(Icons.navigate_before, color: Colors.white),
                      backgroundColor: Color(0xFF64B6AC),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        stopTextToSpeech();
                        globalVariables.setTopic('lesson5', 7, true);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Heredity_Topic_5_2_3(),
                          ),
                        );
                      },
                      heroTag: 'nextBtn',
                      child: Icon(Icons.navigate_next, color: Colors.white),
                      backgroundColor: Color(0xFF64B6AC),
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
      body: Heredity_Topic_5_2_2(),
    ),
  ));
}
