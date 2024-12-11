import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1/Ecosystem_AT_6_1.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1_2/Ecosystem_AT_6_1_2.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1_3/Ecosystem_AT_6_1_3.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_2/Ecosystem_AT_6_2.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_ILO/Ecosystem_ILO.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_TLA/Ecosystem_TLA_6_1.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_TLA/Ecosystem_TLA_6_2.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_TLA/Ecosystem_TLA_6_3.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_TLA/Ecosystem_TLA_6_4.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_1.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_2.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_2_1.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_2_2.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_3.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_4.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_4_1.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_4_2.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_4_3.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_5.dart';
import 'package:capstone/main.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Ecosystem_Screen(),
    },
  ));
}

class Ecosystem_Screen extends StatefulWidget {
  @override
  _Ecosystem_ScreenState createState() => _Ecosystem_ScreenState();
}

class _Ecosystem_ScreenState extends State<Ecosystem_Screen> {
  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);
    var topics = globalVariables.getTopics('lesson6');

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
                            'Ecosystem',
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
                SizedBox(height: 10.0),
                RectangleBox(
                  title: 'Intended Learning Outcomes',
                  items: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          globalVariables.setTopic('lesson6', 1, true);
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Ecosystem_ILO_Screen(),
                        ));
                      },
                      child: Text(
                        'ILO 6.1',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
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
                                globalVariables.setTopic('lesson6', 2, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_Topic_6_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[1] ? 1 : 0.5,
                        child: Text(
                          '6.1 - Components of an Ecosystem',
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
                                globalVariables.setTopic('lesson6', 3, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_Topic_6_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[2] ? 1 : 0.5,
                        child: Text(
                          '6.2 - The Abiotic Factors',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: topics[3]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson6', 4, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_Topic_6_2_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[3] ? 1 : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '6.2.1 - Climatic Factors',
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
                                globalVariables.setTopic('lesson6', 5, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_Topic_6_2_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[4] ? 1 : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '6.2.2 - Edaphic Factors and Physiographic Factors',
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
                      onTap: topics[5]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson6', 6, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_Topic_6_3(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[5] ? 1 : 0.5,
                        child: Text(
                          '6.3 - The Biotic Factors',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: topics[6]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson6', 7, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_Topic_6_4(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[6] ? 1 : 0.5,
                        child: Text(
                          '6.4 - Functions of Ecosystem',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: topics[7]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson6', 8, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_Topic_6_4_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[7] ? 1 : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '6.4.1 - Food Chain',
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
                                globalVariables.setTopic('lesson6', 9, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_Topic_6_4_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[8] ? 1 : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '6.4.2 - Food Web',
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
                      onTap: topics[9]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson6', 10, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_Topic_6_4_3(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[9] ? 1 : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '6.4.3 - Ecological Balance',
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
                      onTap: topics[10]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson6', 11, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_Topic_6_5(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[10] ? 1 : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '6.5 - Interactions in an Ecosystem',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
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
                      onTap: topics[11]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson6', 12, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_TLA_6_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[11] ? 1 : 0.5,
                        child: Text(
                          'Exercise 6.1 - Learn about Biotic and Abiotic ',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: topics[12]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson6', 13, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_TLA_6_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[12] ? 1 : 0.5,
                        child: Text(
                          'Exercise 6.2 - Learn about the different ecological relationships found in an ecosystem',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: topics[13]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson6', 14, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_TLA_6_3(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[13] ? 1 : 0.5,
                        child: Text(
                          'Exercise 6.3 - Learn about the effect of changes in one population on other populations in the ecosystem',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: topics[14]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson6', 15, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_TLA_6_4(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[14] ? 1 : 0.5,
                        child: Text(
                          'Exercise 6.4 - Learn about the effect of changes in abiotic factors on the ecosystem',
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
                      onTap: globalVariables.canTakeQuiz('lesson6', 'quiz1')
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson6', 16, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_AT_6_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: globalVariables.canTakeQuiz('lesson6', 'quiz1')
                            ? 1
                            : 0.5,
                        child: Text(
                          'Assessment 6.1 - Biotic or Abiotic?',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: globalVariables.canTakeQuiz('lesson6', 'quiz2')
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson6', 17, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_AT_6_1_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: globalVariables.canTakeQuiz('lesson6', 'quiz2')
                            ? 1
                            : 0.5,
                        child: Text(
                          'Assessment 6.2 - Predator or Prey?',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: globalVariables.canTakeQuiz('lesson6', 'quiz3')
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson6', 18, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_AT_6_1_3(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: globalVariables.canTakeQuiz('lesson6', 'quiz3')
                            ? 1
                            : 0.5,
                        child: Text(
                          'Assessment 6.3 - Effect of Population Changes',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: globalVariables.canTakeQuiz('lesson6', 'quiz4')
                          ? () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Ecosystem_AT_6_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: globalVariables.canTakeQuiz('lesson6', 'quiz4')
                            ? 1
                            : 0.5,
                        child: Text(
                          'Assessment 6.4 - Effects of Abiotic Factors',
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
                  color: Color(0xFFA846A0),
                ),
                SizedBox(width: 5.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFA846A0),
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
