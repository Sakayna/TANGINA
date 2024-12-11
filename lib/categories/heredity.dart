import 'package:capstone/Module%20Contents/Heredity/Heredity_AT/Heredity_AT_5_1/Heredity_AT_5_1.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_AT/Heredity_AT_5_2/Heredity_AT_5_2.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_ILO/Heredity_ILO.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_TLA/Heredity_TLA_5_1.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_Topics/Heredity_Topic_5_1.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_Topics/Heredity_Topic_5_1_1.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_Topics/Heredity_Topic_5_1_2.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_Topics/Heredity_Topic_5_2.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_Topics/Heredity_Topic_5_2_1.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_Topics/Heredity_Topic_5_2_2.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_Topics/Heredity_Topic_5_2_3.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_Topics/Heredity_Topic_5_3.dart';
import 'package:capstone/main.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Heredity_Screen(),
    },
  ));
}

class Heredity_Screen extends StatefulWidget {
  @override
  _Heredity_ScreenState createState() => _Heredity_ScreenState();
}

class _Heredity_ScreenState extends State<Heredity_Screen> {
  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);
    var topics = globalVariables.getTopics('lesson5');

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(),
          ),
          (Route<dynamic> route) => false,
        );
        return false;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    margin: EdgeInsets.only(bottom: 2.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.black),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyApp(),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Heredity: Inheritance and Variation',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                RectangleBox(
                  title: 'Intended Learning Outcomes',
                  items: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          globalVariables.setTopic('lesson5', 1, true);
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Heredity_ILO_Screen(),
                        ));
                      },
                      child: Text(
                        'ILO 5.1',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                  iconData: Icons.info,
                ),
                SizedBox(height: 10.0),
                RectangleBox(
                  title: 'Topics',
                  items: [
                    GestureDetector(
                      onTap: topics[1]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson5', 2, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Heredity_Topic_5_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[1] ? 1 : 0.5,
                        child: const Text(
                          '5.1 - Sexual Reproduction',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: topics[2]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson5', 3, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Heredity_Topic_5_1_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[2] ? 1 : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '5.1.1 - Process of Fertilization',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: topics[3]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson5', 4, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Heredity_Topic_5_1_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[3] ? 1 : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '5.1.2 - Sexual Reproduction in Unicellular Organisms',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: topics[4]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson5', 5, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Heredity_Topic_5_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[4] ? 1 : 0.5,
                        child: Text(
                          '5.2 - Asexual Reproduction',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: topics[5]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson5', 6, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Heredity_Topic_5_2_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[5] ? 1 : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '5.2.1 - Examples of Asexual Reproduction',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: topics[6]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson5', 7, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Heredity_Topic_5_2_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[6] ? 1 : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '5.2.2 - Natural Vegetative Propagation',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: topics[7]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson5', 8, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Heredity_Topic_5_2_3(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[7] ? 1 : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '5.2.3 - Artificial Vegetative Propagation',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: topics[8]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson5', 9, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Heredity_Topic_5_3(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[8] ? 1 : 0.5,
                        child: Text(
                          '5.3 - Sexual Reproduction vs. Asexual Reproduction',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                  iconData: Icons.library_books,
                ),
                SizedBox(height: 10.0),
                RectangleBox(
                  title: 'Teaching and Learning Activities',
                  items: [
                    GestureDetector(
                      onTap: topics[9]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson5', 10, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Heredity_TLA_5_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[9] ? 1 : 0.5,
                        child: Text(
                          'Exercise 5.1 - Learn about the difference between asexual and sexual reproduction',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: topics[10]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson5', 11, true);
                                globalVariables.allowQuiz('lesson5',
                                    'quiz1'); // Allowing the quiz after TLA
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Heredity_TLA_5_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[10] ? 1 : 0.5,
                        child: Text(
                          'Exercise 5.2 - Learn about the process of Fertilization',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                  iconData: Icons.lightbulb_outline,
                ),
                SizedBox(height: 10.0),
                RectangleBox(
                  title: 'Assessment Tasks',
                  items: [
                    GestureDetector(
                      onTap: globalVariables.canTakeQuiz('lesson5', 'quiz1')
                          ? () {
                              setState(() {
                                globalVariables.allowQuiz('lesson5', 'quiz1');
                                globalVariables.setTopic('lesson5', 12, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Heredity_AT_5_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: globalVariables.canTakeQuiz('lesson5', 'quiz1')
                            ? 1
                            : 0.5,
                        child: Text(
                          'Assessment 5.1 - Asexual or Sexual? ',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: globalVariables.canTakeQuiz('lesson5', 'quiz2')
                          ? () {
                              setState(() {
                                globalVariables.allowQuiz('lesson5', 'quiz2');
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Heredity_AT_5_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: globalVariables.canTakeQuiz('lesson5', 'quiz2')
                            ? 1
                            : 0.5,
                        child: Text(
                          'Assessment 5.2 - Sequencing Fertilization Process',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                  iconData: Icons.assignment,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RectangleBox extends StatelessWidget {
  final String title;
  final List<Widget> items;
  final IconData? iconData;

  RectangleBox({
    required this.title,
    required this.items,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: 16.0, right: 16.0, bottom: 10.0), // Adjusted margin
      padding: EdgeInsets.all(8.0), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            spreadRadius: 0.01,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (iconData != null) ...[
            Row(
              children: [
                Icon(
                  iconData,
                  color: Color(0xFF64B6AC),
                ),
                SizedBox(width: 5.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF64B6AC),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            ..._buildItemsWithDivider(), // Call a helper method to build items with dividers
          ],
        ],
      ),
    );
  }

  List<Widget> _buildItemsWithDivider() {
    List<Widget> widgets = [];

    for (int i = 0; i < items.length; i++) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(
              left: 30.0), // Adjusted left padding of the items
          child: items[i],
        ),
      );

      // Add a Divider after each item except the last one
      if (i < items.length - 1) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(
                left: 30.0), // Adjusted left padding of the divider
            child: Divider(
              color: Color(0xFFD3D3D3), // Lighter gray color for the divider
              thickness: 0.25, // Thin thickness of the divider
              height: 20.0,
            ),
          ),
        );
      }
    }

    return widgets;
  }
}
