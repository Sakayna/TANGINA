import 'package:capstone/Module%20Contents/Levels%20of%20Biological%20Organization/Levels_of_Biological_Organization_AT/Levels_of_Biological_Organization_AT_2_2/Levels_of_Biological_Organization_AT_2_2.dart';
import 'package:capstone/Module%20Contents/Levels%20of%20Biological%20Organization/Levels_of_Biological_Organization_ILO/Levels_of_Biological_Organization_ILO.dart';
import 'package:capstone/Module%20Contents/Levels%20of%20Biological%20Organization/Levels_of_Biological_Organization_TLA/Levels_of_Biological_Organization_TLA_2_1.dart';
import 'package:capstone/Module%20Contents/Levels%20of%20Biological%20Organization/Levels_of_Biological_Organization_Topics/Levels_of_Biological_Organization_Topic_2_1..dart';
import 'package:capstone/main.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Levels_of_biological_organization_Screen(),
    },
  ));
}

class Levels_of_biological_organization_Screen extends StatefulWidget {
  @override
  _Levels_of_biological_organization_ScreenState createState() =>
      _Levels_of_biological_organization_ScreenState();
}

class _Levels_of_biological_organization_ScreenState
    extends State<Levels_of_biological_organization_Screen> {
  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);
    var topics = globalVariables.getTopics('lesson2');

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
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Levels of Biological Organization',
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
                          globalVariables.setTopic('lesson2', 1, true);
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Biological_Organization_ILOScreen(),
                        ));
                      },
                      child: const Text(
                        'ILO 2.1',
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
                                globalVariables.setTopic('lesson2', 2, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Biological_Organization_Topic_2_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[1] ? 1 : 0.5,
                        child: const Text(
                          '2.1 - Organization',
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
                      onTap: topics[2]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson2', 3, true);
                                globalVariables.getQuizTaken(
                                    'lesson2', 'quiz1');
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Biological_Organization_TLA_2_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[2] ? 1 : 0.5,
                        child: const Text(
                          'Exercise 2.1 - The different levels of biological organization from cell to biosphere',
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
                      onTap: topics[3]
                          ? () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Biological_Organization_AT_2_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[3] ? 1 : 0.5,
                        child: const Text(
                          'Assessment 2.1 - Sequencing of Biological Levels',
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
                  color: Color(0xFF9463FF),
                ),
                SizedBox(width: 5.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9463FF),
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
