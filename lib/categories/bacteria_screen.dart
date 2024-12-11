import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_AT/Bactera_AT_4_2/Bacteria_AT_4_2.dart';
import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_ILO/Bacteria_ILO.dart';
import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_TLA/Bacteria_TLA_4_1.dart';
import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_Topics/Bacteria_Topic_4_1.dart';
import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_Topics/Bacteria_Topic_4_1_1.dart';
import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_Topics/Bacteria_Topic_4_1_2.dart';
import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_Topics/Bacteria_Topic_4_1_3.dart';
import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_Topics/Bacteria_Topic_4_1_4.dart';
import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_Topics/Bacteria_Topic_4_1_5.dart';
import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_Topics/Bacteria_Topic_4_2.dart';
import 'package:capstone/main.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Bacteria_Screen(),
    },
  ));
}

class Bacteria_Screen extends StatefulWidget {
  @override
  _Bacteria_ScreenState createState() => _Bacteria_ScreenState();
}

class _Bacteria_ScreenState extends State<Bacteria_Screen> {
  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);
    var topics = globalVariables.getTopics('lesson4');

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(),
          ),
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
                            'Funji, Protists, and Bacteria',
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
                          globalVariables.setTopic('lesson4', 1, true);
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Bacteria_ILO_Screen(),
                        ));
                      },
                      child: Text(
                        'ILO 4.1',
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
                                globalVariables.setTopic('lesson4', 2, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Bacteria_Topic_4_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[1] ? 1 : 0.5,
                        child: const Text(
                          '4.1 - Bacteria',
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
                                globalVariables.setTopic('lesson4', 3, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Bacteria_Topic_4_1_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[2] ? 1 : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '4.1.1 - Distinct Groups of Bacteria',
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
                                globalVariables.setTopic('lesson4', 4, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Bacteria_Topic_4_1_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[3] ? 1 : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '4.1.2 - Bacterial Shapes and Cellular Arrangements',
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
                                globalVariables.setTopic('lesson4', 5, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Bacteria_Topic_4_1_3(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[4] ? 1 : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '4.1.3 - Reproduction in Bacteria',
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
                                globalVariables.setTopic('lesson4', 6, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Bacteria_Topic_4_1_4(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[5] ? 1 : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '4.1.4 - Economic Importance of Bacteria',
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
                                globalVariables.setTopic('lesson4', 7, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Bacteria_Topic_4_1_5(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[6] ? 1 : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '4.1.5 - Harmful Effects of Bacteria',
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
                                globalVariables.setTopic('lesson4', 8, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Bacteria_Topic_4_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[7] ? 1 : 0.5,
                        child: Text(
                          '4.2 - Protists',
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
                      onTap: topics[8]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson4', 9, true);
                                globalVariables.allowQuiz('lesson4', 'quiz1');
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Bacteria_TLA_4_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[8] ? 1 : 0.5,
                        child: const Text(
                          'Exercise 4.1 - Identify beneficial and harmful microorganisms ',
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
                      onTap: topics[9]
                          ? () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Bacteria_AT_4_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[9] ? 1 : 0.5,
                        child: const Text(
                          'Assessment 4.1 - Beneficial or Harmful?',
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
                  color: Color(0xFFFF6A6A),
                ),
                SizedBox(width: 5.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6A6A),
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
