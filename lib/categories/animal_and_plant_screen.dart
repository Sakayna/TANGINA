import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/AT1/Animal_and_Plant_Cells_AT_3_1.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/Animal_and_Plant_Cells_AT_3_2/Animal_and_Plant_Cells_AT_3_2.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_ILO/Animal_and_Plant_Cells_ILO.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_TLA/Animal_and_Plant_Cells_TLA_3_1.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_TLA/Animal_and_Plant_Cells_TLA_3_2.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_Topics/Animal_and_Plant_Topic_3_1.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_Topics/Animal_and_Plant_Topic_3_2.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_Topics/Animal_and_Plant_Topic_3_3.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_Topics/Animal_and_Plant_Topic_3_4.dart';

import 'package:capstone/main.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Animal_and_Plant_Screen(),
    },
  ));
}

class Animal_and_Plant_Screen extends StatefulWidget {
  @override
  _Animal_and_Plant_ScreenState createState() =>
      _Animal_and_Plant_ScreenState();
}

class _Animal_and_Plant_ScreenState extends State<Animal_and_Plant_Screen> {
  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);
    var topics = globalVariables.getTopics('lesson3');

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
                            'Animal and Plant Cells',
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
                            globalVariables.setTopic('lesson3', 1, true);
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Animal_and_Plant_ILO_Screen(),
                          ));
                        },
                        child: const Text(
                          'ILO 3.1',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        )),
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
                                globalVariables.setTopic('lesson3', 2, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Animal_and_Plant_Topic_3_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[1] ? 1 : 0.5,
                        child: const Text(
                          '3.1 - Types of Cells Found in Living Things',
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
                                globalVariables.setTopic('lesson3', 3, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Animal_and_Plant_Topic_3_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[2] ? 1 : 0.5,
                        child: const Text(
                          '3.2 - Parts and Functions of Typical Cell',
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
                                globalVariables.setTopic('lesson3', 4, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Animal_and_Plant_Topic_3_3(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[3] ? 1 : 0.5,
                        child: const Text(
                          '3.3 - Comparison of a Plant Cell and an Animal Cell',
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
                                globalVariables.setTopic('lesson3', 5, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Animal_and_Plant_Topic_3_4(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[4] ? 1 : 0.5,
                        child: const Text(
                          '3.4 - Shapes of Cells',
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
                      onTap: topics[5]
                          ? () {
                              setState(() {
                                globalVariables.setTopic('lesson3', 6, true);
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Animal_and_Plant_TLA_3_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[5] ? 1 : 0.5,
                        child: const Text(
                          'Exercise 3.1 - Differentiate plant and animal cells according to presence or absence of certain organelles',
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
                                globalVariables.setTopic('lesson3', 7, true);
                                globalVariables.allowQuiz('lesson3', 'quiz1');
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Animal_and_Plant_TLA_3_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: topics[6] ? 1 : 0.5,
                        child: const Text(
                          'Exercise 3.2 - Learn about why the cell is cconsidered as the basic unit of life',
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
                      onTap: globalVariables.canTakeQuiz('lesson3', 'quiz1')
                          ? () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Animal_and_Plant_AT_3_1(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity: globalVariables.canTakeQuiz('lesson3', 'quiz1')
                            ? 1
                            : 0.5,
                        child: const Text(
                          'Assessment 3.1 - Categorizing Cell Organelles ',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: globalVariables.getQuizTaken('lesson3', 'quiz1')
                          ? () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Animal_and_Plant_AT_3_2(),
                              ));
                            }
                          : null,
                      child: Opacity(
                        opacity:
                            globalVariables.getQuizTaken('lesson3', 'quiz1')
                                ? 1
                                : 0.5,
                        child: const Text(
                          'Assessment 3.2 - Cell Functions and Significance',
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
                  color: Color(0xFFA1C084),
                ),
                SizedBox(width: 5.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFA1C084),
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
