import 'package:capstone/Record%20Module/RecordModule_Main.dart';
import 'package:capstone/categories/Microscopy_Screen.dart';
import 'package:capstone/categories/animal_and_plant_screen.dart';
import 'package:capstone/categories/bacteria_screen.dart';
import 'package:capstone/categories/ecosystem.dart';
import 'package:capstone/categories/heredity.dart';
import 'package:capstone/categories/levels_of_biological_organization_screen.dart';
import 'package:capstone/navbar/Quiz.dart';
import 'package:capstone/navbar/CustomBottomNavigationBar.dart';
import 'package:capstone/Record%20Module/AT/lesson1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                padding: EdgeInsets.all(16.0),
                childAspectRatio:
                    0.78, // Adjust this value to change the height of the boxes
                children: [
                  buildBoxWidget(
                    color: Color(0xFFFFA551),
                    image: 'assets/images/homepage/1microscopy.png',
                    text: 'Microscopy',
                    lessonId: 'lesson1',
                    context: context,
                    screen: MicroscopyScreen(),
                  ),
                  buildBoxWidget(
                    color: Color(0xFF9463FF),
                    image: 'assets/images/homepage/2biological.png',
                    text: 'Levels of Biological Organization',
                    lessonId: 'lesson2',
                    context: context,
                    screen: Levels_of_biological_organization_Screen(),
                  ),
                  buildBoxWidget(
                    color: Color(0xFFA1C084),
                    image: 'assets/images/homepage/3cells.png',
                    text: 'Animal and Plant Cells',
                    lessonId: 'lesson3',
                    context: context,
                    screen: Animal_and_Plant_Screen(),
                  ),
                  buildBoxWidget(
                    color: Color(0xFFFF6A6A),
                    image: 'assets/images/homepage/4bacteria.png',
                    text: 'Funji, Protists, and Bacteria',
                    lessonId: 'lesson4',
                    context: context,
                    screen: Bacteria_Screen(),
                  ),
                  buildBoxWidget(
                    color: Color(0xFF64B6AC),
                    image: 'assets/images/homepage/5dna.png',
                    text: 'Heredity: Inheritance and Variation',
                    lessonId: 'lesson5',
                    context: context,
                    screen: Heredity_Screen(),
                  ),
                  buildBoxWidget(
                    color: Color(0xFFA846A0),
                    image: 'assets/images/homepage/6ecosystem.png',
                    text: 'Ecosystem',
                    lessonId: 'lesson6',
                    context: context,
                    screen: Ecosystem_Screen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onNavItemTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).popUntil((route) => route.isFirst);
              break;
            case 1:
              break;
            case 2:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => QuizScreen()),
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

  Widget buildBoxWidget({
    required Color color,
    required String image,
    required String text,
    required String lessonId,
    required BuildContext context,
    required Widget screen,
  }) {
    final globalVariables =
        Provider.of<GlobalVariables>(context, listen: false);
    final isLessonComplete = globalVariables.isLessonComplete(lessonId);

    return GestureDetector(
      onTap: () {
        if (isLessonComplete) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => screen),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Lesson Locked'),
              content: Text('Please complete the previous lesson first.'),
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
      child: Opacity(
        opacity: isLessonComplete ? 1.0 : 0.5,
        child: Container(
          height: 350, // Adjust the height as needed
          decoration: BoxDecoration(
            color: color,
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
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    image,
                    height: 80,
                  ),
                ),
              ),
              Align(
                alignment: Alignment
                    .center, // Center the text vertically and horizontally
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 100.0), // Add a small space above the text
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: 150), // Adjust max width if needed
                    child: Text(
                      text,
                      textAlign:
                          TextAlign.center, // Center align text horizontally
                      style: TextStyle(
                        fontSize: 12.0, // Adjust font size
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              if (!isLessonComplete)
                Center(
                  child: Icon(Icons.lock, color: Colors.white, size: 50.0),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
