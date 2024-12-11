import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/AT1/Animal_and_Plant_Cells_AT_3_1.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1/Ecosystem_AT_6_1.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1_2/Ecosystem_AT_6_1_2.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_1_3/Ecosystem_AT_6_1_3.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_AT/Heredity_AT_5_1/Heredity_AT_5_1.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_AT/Microscopy_AT_1_2/Microscopy_AT_1_2.dart';
import 'package:capstone/Record%20Module/RecordModule_Main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_AT/Microscopy_AT_1_3/Microscopy_AT_1_3.dart';
import 'package:capstone/Module%20Contents/Levels%20of%20Biological%20Organization/Levels_of_Biological_Organization_AT/Levels_of_Biological_Organization_AT_2_2/Levels_of_Biological_Organization_AT_2_2.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/Animal_and_Plant_Cells_AT_3_2/Animal_and_Plant_Cells_AT_3_2.dart';
import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_AT/Bactera_AT_4_2/Bacteria_AT_4_2.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_AT/Heredity_AT_5_2/Heredity_AT_5_2.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_AT/Ecosystem_AT_6_2/Ecosystem_AT_6_2.dart';
import 'package:capstone/navbar/Category.dart';
import 'package:capstone/navbar/CustomBottomNavigationBar.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final globalVariables = Provider.of<GlobalVariables>(context);

    final List<Map<String, dynamic>> quizData = [
      {
        'lesson': 1,
        'quiz': 1,
        'title': 'Quiz 1 - Microscopy',
        'key': 'quiz1',
        'route': Microscopy_AT_1_2(),
        'color': Color(0xFFFFA551),
        'image': 'assets/images/quiz/quiz_icons/microscope.png'
      },
      {
        'lesson': 1,
        'quiz': 2,
        'title': 'Quiz 2 - Microscopy',
        'key': 'quiz2',
        'route': Microscopy_AT_1_3(),
        'color': Color(0xFFFFA551),
        'image': 'assets/images/quiz/quiz_icons/microscope.png'
      },
      {
        'lesson': 2,
        'quiz': 1,
        'title': 'Quiz 1 - Levels of Biological Organization',
        'key': 'quiz3',
        'route': Biological_Organization_AT_2_2(),
        'color': Color(0xFF9463FF),
        'image': 'assets/images/quiz/quiz_icons/organization.png'
      },
      {
        'lesson': 3,
        'quiz': 1,
        'title': 'Quiz 1 - Animal and Plant Cells',
        'key': 'quiz4',
        'route': Animal_and_Plant_AT_3_1(),
        'color': Color(0xFFA1C084),
        'image': 'assets/images/quiz/quiz_icons/plant-cell.png'
      },
      {
        'lesson': 3,
        'quiz': 2,
        'title': 'Quiz 2 - Animal and Plant Cells',
        'key': 'quiz5',
        'route': Animal_and_Plant_AT_3_2(),
        'color': Color(0xFFA1C084),
        'image': 'assets/images/quiz/quiz_icons/plant-cell.png'
      },
      {
        'lesson': 4,
        'quiz': 1,
        'title': 'Quiz 1 - Fungi, Protists, and Bacteria',
        'key': 'quiz6',
        'route': Bacteria_AT_4_2(),
        'color': Color(0xFFFF6A6A),
        'image': 'assets/images/quiz/quiz_icons/bacteria.png'
      },
      {
        'lesson': 5,
        'quiz': 1,
        'title': 'Quiz 1 - Heredity: Inheritance and Variation',
        'key': 'quiz7',
        'route': Heredity_AT_5_1(),
        'color': Color(0xFF64B6AC),
        'image': 'assets/images/quiz/quiz_icons/heredity .png'
      },
      {
        'lesson': 5,
        'quiz': 2,
        'title': 'Quiz 2 - Heredity: Inheritance and Variation',
        'key': 'quiz8',
        'route': Heredity_AT_5_2(),
        'color': Color(0xFF64B6AC),
        'image': 'assets/images/quiz/quiz_icons/heredity .png'
      },
      {
        'lesson': 6,
        'quiz': 1,
        'title': 'Quiz 1 - Ecosystem',
        'key': 'quiz9',
        'route': Ecosystem_AT_6_1(),
        'color': Color(0xFFA846A0),
        'image': 'assets/images/quiz/quiz_icons/eco.png'
      },
      {
        'lesson': 6,
        'quiz': 2,
        'title': 'Quiz 2 - Ecosystem',
        'key': 'quiz10',
        'route': Ecosystem_AT_6_1_2(),
        'color': Color(0xFFA846A0),
        'image': 'assets/images/quiz/quiz_icons/eco.png'
      },
      {
        'lesson': 6,
        'quiz': 3,
        'title': 'Quiz 3 - Ecosystem',
        'key': 'quiz11',
        'route': Ecosystem_AT_6_1_3(),
        'color': Color(0xFFA846A0),
        'image': 'assets/images/quiz/quiz_icons/eco.png'
      },
      {
        'lesson': 6,
        'quiz': 4,
        'title': 'Quiz 4 - Ecosystem',
        'key': 'quiz12',
        'route': Ecosystem_AT_6_2(),
        'color': Color(0xFFA846A0),
        'image': 'assets/images/quiz/quiz_icons/eco.png'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.0),
              ...quizData.map((quiz) {
                final isLocked = !globalVariables.canTakeQuiz(
                    'lesson${quiz['lesson']}', 'quiz${quiz['quiz']}');

                return RectangleBox(
                  longText: quiz['title'],
                  lessonText: 'Lesson ${quiz['lesson']}',
                  color: quiz['color'],
                  imagePath: quiz['image'],
                  isLocked: isLocked,
                  onTap: () {
                    if (!isLocked) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => quiz['route']),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Quiz Locked'),
                          content: Text(
                              'This quiz is locked. Complete the previous quizzes to unlock it.'),
                          actions: [
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              }).toList(),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
        onNavItemTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).popUntil((route) => route.isFirst);
              break;
            case 1:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const CategoryScreen()),
              );
              break;
            case 3:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => RecordModuleLesson1()),
              );
              break;
          }
        },
      ),
    );
  }
}

class RectangleBox extends StatelessWidget {
  final String longText;
  final String lessonText;
  final Color color;
  final String imagePath;
  final VoidCallback onTap;
  final bool isLocked;

  RectangleBox({
    required this.longText,
    required this.lessonText,
    required this.color,
    required this.imagePath,
    required this.onTap,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isLocked ? 0.5 : 1.0,
        child: Container(
          height: 100,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Stack(
            children: [
              // Outer White Background
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.01),
                        spreadRadius: 0.01,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
              // Inner Square with Image
              Positioned(
                left: 12,
                top: 12,
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              // Text 1 (Long Text)
              Positioned(
                left: 100,
                top: 15,
                child: Container(
                  width: 200,
                  child: Text(
                    longText,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              // Text 2 (Lesson Text)
              Positioned(
                left: 100,
                top: 50,
                child: Container(
                  width: 200,
                  child: Text(
                    lessonText,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF00B4D8),
                    ),
                  ),
                ),
              ),
              // Lock Icon
              if (isLocked)
                Positioned(
                  right: 12,
                  top: 12,
                  child: Icon(Icons.lock, color: Colors.grey, size: 24.0),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
