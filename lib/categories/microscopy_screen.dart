import 'package:capstone/Module%20Contents/Microscopy/Microscopy_AT/Microscopy_AT_1_2/Microscopy_AT_1_2.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_AT/Microscopy_AT_1_3/Microscopy_AT_1_3.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_ILO/Microscopy_ILO.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_TLA/Microscopy_TLA_1_1.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_TLA/Microscopy_TLA_1_2.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_Topics/Microscopy_Topic_1_1.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_Topics/Microscopy_Topic_1_2.dart';
import 'package:capstone/main.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => MicroscopyScreen(),
    },
  ));
}

class MicroscopyScreen extends StatefulWidget {
  @override
  _MicroscopyScreenState createState() => _MicroscopyScreenState();
}

class _MicroscopyScreenState extends State<MicroscopyScreen> {
  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);
    var topics = globalVariables.getTopics('lesson1');

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
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    margin: const EdgeInsets.only(bottom: 2.0),
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
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            '        Microscopy',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
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
                      onTap: topics[0]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson1', 1, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MicroscopyILOScreen(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[0] ? 1 : 0.5,
                        child: const Text(
                          'ILO 1.1 ',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                  iconData: Icons.info,
                ),
                const SizedBox(height: 10.0),
                RectangleBox(
                  title: 'Topics',
                  items: [
                    GestureDetector(
                      onTap: topics[1]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson1', 2, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Microscopy_Topic_1_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[1] ? 1 : 0.5,
                        child: const Text(
                          '1.1 - The Microscope and Its Historical Development',
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
                                globalVariables.setTopic('lesson1', 3, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Microscopy_Topic_1_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[2] ? 1 : 0.5,
                        child: const Text(
                          '1.2 - Parts and Functions of a Compound Light Microscope (CLM)',
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
                const SizedBox(height: 10.0),
                RectangleBox(
                  title: 'Teaching and Learning Activities',
                  items: [
                    GestureDetector(
                      onTap: topics[3]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson1', 4, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Microscopy_TLA_1_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[3] ? 1 : 0.5,
                        child: const Text(
                          'Exercise 1.1 - Introduction to Microscopy',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: topics[4]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson1', 5, true);
                              });
                              globalVariables.allowQuiz('lesson1', 'quiz1');
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Microscopy_TLA_1_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[4] ? 1 : 0.5,
                        child: const Text(
                          'Exercise 1.2 - Focus Specimens Using Compound Microscope',
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
                const SizedBox(height: 10.0),
                RectangleBox(
                  title: 'Assessment Tasks',
                  items: [
                    GestureDetector(
                      onTap: globalVariables.canTakeQuiz('lesson1', 'quiz1')
                          ? () {
                              globalVariables.setTopic('lesson1', 6, true);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Microscopy_AT_1_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: globalVariables.canTakeQuiz('lesson1', 'quiz1')
                            ? 1
                            : 0.5,
                        child: const Text(
                          'Assessment 1.1 - Labeling of Microscope Parts',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: globalVariables.canTakeQuiz('lesson1', 'quiz2')
                          ? () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Microscopy_AT_1_3(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: globalVariables.canTakeQuiz('lesson1', 'quiz2')
                            ? 1
                            : 0.5,
                        child: const Text(
                          'Assessment 1.2 - Sequencing of how to focus specimen on a compound microscope ',
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
                const SizedBox(height: 20),
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
                  color: Color(0xFFFFA551),
                ),
                SizedBox(width: 5.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFA551),
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
