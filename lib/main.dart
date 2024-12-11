import 'package:capstone/Record%20Module/RecordModule_Main.dart';
import 'package:capstone/categories/animal_and_plant_screen.dart';
import 'package:capstone/categories/bacteria_screen.dart';
import 'package:capstone/categories/ecosystem.dart';
import 'package:capstone/categories/heredity.dart';
import 'package:capstone/categories/levels_of_biological_organization_screen.dart';
import 'package:capstone/categories/microscopy_screen.dart';
import 'package:capstone/navbar/ARTutorial.dart';
import 'package:capstone/navbar/Quiz.dart';
import 'package:capstone/navbar/Category.dart';
import 'package:capstone/navbar/CustomBottomNavigationBar.dart';
import 'package:capstone/Record%20Module/AT/lesson1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_AT/Microscopy_AT_1_3/Microscopy_AT_1_3.dart';
import 'package:capstone/Module%20Contents/Levels%20of%20Biological%20Organization/Levels_of_Biological_Organization_AT/Levels_of_Biological_Organization_AT_2_2/Levels_of_Biological_Organization_AT_2_2.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_AT/Animal_and_Plant_Cells_AT_3_2/Animal_and_Plant_Cells_AT_3_2.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GlobalVariables(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                const Padding(
                  padding: EdgeInsets.fromLTRB(
                      16.0, 50.0, 16.0, 16.0), // Added top padding
                  child: Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),

                // Lesson Module with See All
                Builder(
                  builder: (BuildContext context) => Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lesson Module',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const CategoryScreen()),
                            );
                          },
                          child: Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                HorizontalScrollableList(),
                // QUIZ HEADER
                Builder(
                  builder: (BuildContext context) => Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quiz Module',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => QuizScreen()),
                            );
                          },
                          child: Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // QUIZ CONTAINER
                RectangleBox(
                  lessonId: 'lesson1',
                  longText: 'Quiz 1 - Microscopy',
                  lessonText: 'Lesson 1',
                  color: const Color(0xFFFFB703),
                  imagePath: 'assets/images/quiz/quiz_icons/microscope.png',
                  screen: Microscopy_AT_1_3(),
                  quizKey: 'quiz1',
                ),
                RectangleBox(
                  lessonId: 'lesson2',
                  longText: 'Quiz 2 - Levels of Biological Organization',
                  lessonText: 'Lesson 2',
                  color: const Color(0xFFA846A0),
                  imagePath: 'assets/images/quiz/quiz_icons/organization.png',
                  screen: Biological_Organization_AT_2_2(),
                  quizKey: 'quiz1',
                ),
                RectangleBox(
                  lessonId: 'lesson3',
                  longText: 'Quiz 3 - Animal and Plant Cells',
                  lessonText: 'Lesson 3',
                  color: const Color(0xFFA1C084),
                  imagePath: 'assets/images/quiz/quiz_icons/plant-cell.png',
                  screen: Animal_and_Plant_AT_3_2(),
                  quizKey: 'quiz1',
                ),
                // First Bigger Rectangle
                FirstBigRectangle(color: Colors.red),
                // Second Bigger Rectangle
                SecondBigRectangle(color: Colors.blue),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Builder(
          builder: (BuildContext context) {
            // NAVIGATION BAR
            return CustomBottomNavigationBar(
              currentIndex: 0,
              onNavItemTap: (index) {
                if (index == 0) {
                  // Home
                  // Navigate to Home screen or perform relevant action
                  print('Navigate to Home');
                } else if (index == 1) {
                  // Categories
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const CategoryScreen()),
                  );
                } else if (index == 2) {
                  // Quiz Screen
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => QuizScreen()),
                  );
                } else if (index == 3) {
                  // About Us
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => RecordModuleLesson1()),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

// LESSONS WIDGETS
class HorizontalScrollableList extends StatefulWidget {
  @override
  _HorizontalScrollableListState createState() =>
      _HorizontalScrollableListState();
}

class _HorizontalScrollableListState extends State<HorizontalScrollableList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalVariables>(
      builder: (context, globalVariables, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              6,
              (index) => GestureDetector(
                onTap: () {
                  if (globalVariables.isLessonComplete('lesson${index + 1}')) {
                    navigateToLessonScreen(context, index);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Lesson Locked'),
                          content: Text(
                              'Please complete the previous Lesson before proceeding to this lesson.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Opacity(
                  opacity:
                      globalVariables.isLessonComplete('lesson${index + 1}')
                          ? 1.0
                          : 0.5,
                  child: Card(
                    color: getBoxColor(index),
                    child: Container(
                      width: 160,
                      height: 220,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                getImagePath(index),
                                fit: BoxFit.fitWidth,
                              ),
                              if (!globalVariables
                                  .isLessonComplete('lesson${index + 1}'))
                                Icon(Icons.lock, color: Colors.white, size: 50),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            getBoxText(index),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color getBoxColor(int index) {
    switch (index) {
      case 1:
        return Color(0xFF9463FF); // Box 2 color
      case 2:
        return Color(0xFFA1C084); // Box 3 color
      case 3:
        return Color(0xFFFF6A6A); // Box 4 color
      case 4:
        return Color(0xFF64B6AC); // Box 5 color
      case 5:
        return Color(0xFFA846A0); // Box 5 color

      default:
        return Color(0xFFFFA551); // Default color for other boxes
    }
  }

  String getLessonName(int index) {
    switch (index) {
      case 0:
        return 'Lesson 1';
      case 1:
        return 'Lesson 2';
      case 2:
        return 'Lesson 3';
      case 3:
        return 'Lesson 4';
      case 4:
        return 'Lesson 5';
      case 5:
        return 'Lesson 6';
      default:
        return 'Unknown Text';
    }
  }

  String getImagePath(int index) {
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

  String getBoxText(int index) {
    switch (index) {
      case 0:
        return 'Microscopy';
      case 1:
        return 'Levels of Biological Organization';
      case 2:
        return 'Animal and Plant Cells';
      case 3:
        return 'Fungi, Protists, and Bacteria';
      case 4:
        return 'Heredity: Inheritance and Variation';
      case 5:
        return 'Ecosystem';
      default:
        return 'Unknown';
    }
  }

  void navigateToLessonScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MicroscopyScreen()));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Levels_of_biological_organization_Screen()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Animal_and_Plant_Screen()));
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Bacteria_Screen()));
        break;
      case 4:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Heredity_Screen()));
        break;
      case 5:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Ecosystem_Screen()));
        break;
      default:
        break;
    }
  }
}
// END OF LESSONS WIDGETS

// QUIZ WIDGETS
class RectangleBox extends StatelessWidget {
  final String lessonId;
  final String longText;
  final String lessonText;
  final Color color;
  final String imagePath;
  final Widget screen;
  final String quizKey; // Added to determine which quiz is being taken

  RectangleBox({
    required this.lessonId,
    required this.longText,
    required this.lessonText,
    required this.color,
    required this.imagePath,
    required this.screen,
    required this.quizKey, // Added to manage locking logic for specific quiz
  });

  @override
  Widget build(BuildContext context) {
    final globalVariables = Provider.of<GlobalVariables>(context);

    final bool isQuizLocked = !globalVariables.canTakeQuiz(lessonId, quizKey);

    return GestureDetector(
      onTap: () {
        if (!isQuizLocked) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => screen,
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Quiz Locked'),
              content: const Text(
                  'Please complete the lesson before taking the quiz.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }
      },
      child: Opacity(
        opacity: isQuizLocked ? 0.5 : 1.0, // Adjust opacity if locked
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
              // Inner Square
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
                      color: Color(0xFF00B4D8), // Lesson Text color
                    ),
                  ),
                ),
              ),
              // Lock Icon if quiz is locked
              if (isQuizLocked)
                Positioned(
                  right: 12,
                  top: 12,
                  child: Icon(Icons.lock, color: Colors.grey, size: 20),
                ),
            ],
          ),
        ),
      ),
    );
  }
} // END OF QUIZ WIDGETS

class FirstBigRectangle extends StatelessWidget {
  final Color color;

  FirstBigRectangle({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150, // Reduced height
      margin: EdgeInsets.symmetric(vertical: 16.0),
      child: Stack(
        children: [
          // Outer Background
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFE5F55), // Background color
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.01),
                    spreadRadius: 0.01,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
          // Positioned Image
          Positioned(
            left: 10, // Move the image 10 pixels to the right
            top: -20, // Move the image upwards by 10 pixels
            child: Image.asset(
              'assets/images/homepage/progress.png',
              height: 180, // Make the image height match the container height
              width:
                  175, // Make the image width match the container height to keep it square
              fit: BoxFit.cover, // Ensure the image covers the entire box
            ),
          ),
          // Positioned Text and Button
          Positioned(
            right: 20, // Align the text and button to the right edge
            top: 30, // Start positioning from the top
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.end, // Align items to the right
              children: [
                Text(
                  'Learn more about',
                  style: TextStyle(
                    fontSize: 16.0, // Adjust font size as needed
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'your progress',
                  style: TextStyle(
                    fontSize: 16.0, // Adjust font size as needed
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10), // Space between text and button
                GestureDetector(
                  onTap: () {
                    // Handle click on the button
                    print('View Progress Clicked');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => RecordModuleLesson1()),
                    );
                  },
                  child: Container(
                    width: 120, // Adjust width as needed
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6.0), // Adjust padding as needed
                    decoration: BoxDecoration(
                      color: Colors.white, // Button color
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'View Progress',
                      textAlign:
                          TextAlign.center, // Center the text within the button
                      style: TextStyle(
                        fontSize: 14.0, // Adjust font size as needed
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFFE5F55),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SecondBigRectangle extends StatelessWidget {
  final Color color;

  SecondBigRectangle({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150, // Keep the container height as is
      margin: EdgeInsets.only(
          top: 1.0, bottom: 40.0), // Adjusted margin for vertical padding
      child: Stack(
        children: [
          // Outer White Background
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF26430), // Background color
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
          // Positioned Text and Button
          Positioned(
            left: 20, // Align the text and button to the left edge
            top: 25, // Start positioning from the top
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align items to the left
              children: [
                Text(
                  'Watch the quick',
                  style: TextStyle(
                    fontSize: 16.0, // Adjust font size as needed
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'AR tutorial',
                  style: TextStyle(
                    fontSize: 16.0, // Adjust font size as needed
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10), // Space between text and button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ARTutorialScreen()),
                    );
                  },
                  child: Container(
                    width: 120, // Adjust width as needed
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6.0), // Adjust padding as needed
                    decoration: BoxDecoration(
                      color: Colors.white, // Button color
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'See tutorial',
                      textAlign:
                          TextAlign.center, // Center the text within the button
                      style: TextStyle(
                        fontSize: 14.0, // Adjust font size as needed
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFF26430),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Positioned Image
          Positioned(
            right: -1, // Move the image further to the right
            top: -5, // Adjust the top position
            child: Image.asset(
              'assets/images/homepage/tutorial.png',
              height: 170, // Make the image height a bit smaller
              width: 160, // Adjust width accordingly
              fit: BoxFit.cover, // Ensure the image covers the entire box
            ),
          ),
        ],
      ),
    );
  }
}
