import 'package:capstone/Record%20Module/AT/leson%206.dart';
import 'package:capstone/Record%20Module/AT/lesson1.dart';
import 'package:capstone/Record%20Module/AT/lesson2.dart';
import 'package:capstone/Record%20Module/AT/lesson3.dart';
import 'package:capstone/Record%20Module/AT/lesson4.dart';
import 'package:capstone/Record%20Module/AT/lesson5.dart';
import 'package:flutter/material.dart';
import 'package:capstone/navbar/Quiz.dart';
import 'package:capstone/navbar/Category.dart';
import 'package:capstone/navbar/CustomBottomNavigationBar.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class RecordModuleLesson1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Module'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progress & Graphs',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildLessonCard(
                    context,
                    'Lesson 1 Quizzes',
                    LessonRecordAT1(),
                    0,
                  ),
                  _buildLessonCard(
                    context,
                    'Lesson 2 Quizzes',
                    LessonRecordAT2(),
                    1,
                  ),
                  _buildLessonCard(
                    context,
                    'Lesson 3 Quizzes',
                    LessonRecordAT3(),
                    2,
                  ),
                  _buildLessonCard(
                    context,
                    'Lesson 4 Quizzes',
                    LessonRecordAT4(),
                    3,
                  ),
                  _buildLessonCard(
                    context,
                    'Lesson 5 Quizzes',
                    LessonRecordAT5(),
                    4,
                  ),
                  _buildLessonCard(
                    context,
                    'Lesson 6 Quizzes',
                    LessonRecordAT6(),
                    5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
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
            case 2:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const QuizScreen()),
              );
              break;
            case 3:
              break; // Already on the Record Module screen
          }
        },
      ),
    );
  }

  Widget _buildLessonCard(
      BuildContext context, String title, Widget destination, int index) {
    final globalVariables = Provider.of<GlobalVariables>(context);

    bool isLocked = !globalVariables.isLessonComplete('lesson${index + 1}');

    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          if (isLocked) {
            _showLockedDialog(context);
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => destination),
            );
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      color: _getBoxColor(index),
                      width: double.infinity,
                      height: 130.0, // Adjusted height for smaller size
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset(
                          _getImagePath(index),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0, // Adjusted font size
                    ),
                  ),
                ],
              ),
            ),
            if (isLocked)
              Positioned(
                right: 10,
                top: 10,
                child: Icon(
                  Icons.lock,
                  color: Colors.grey,
                  size: 24.0, // Adjusted lock icon size
                ),
              ),
            if (isLocked)
              Positioned.fill(
                child: Container(
                  color: Colors.white.withOpacity(0.6), // Locked overlay
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showLockedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lesson Locked'),
        content: const Text(
            'Please complete the previous lesson before accessing this one.'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  String _getImagePath(int index) {
    switch (index) {
      case 0:
        return 'assets/images/homepage/1microscopy.png';
      case 1:
        return 'assets/images/homepage/2biological.png';
      case 2:
        return 'assets/images/homepage/3cells.png';
      case 3:
        return 'assets/images/homepage/4bacteria.png';
      case 4:
        return 'assets/images/homepage/5dna.png';
      case 5:
        return 'assets/images/homepage/6ecosystem.png';
      default:
        return 'assets/images/homepage/ecosystem-no-bg.png';
    }
  }

  Color _getBoxColor(int index) {
    switch (index) {
      case 0:
        return Color(0xFFFFA551);
      case 1:
        return Color(0xFF9463FF);
      case 2:
        return Color(0xFFA1C084);
      case 3:
        return Color(0xFFFF6A6A);
      case 4:
        return Color(0xFF64B6AC);
      case 5:
        return Color(0xFFA846A0);
      default:
        return Colors.grey;
    }
  }
}
