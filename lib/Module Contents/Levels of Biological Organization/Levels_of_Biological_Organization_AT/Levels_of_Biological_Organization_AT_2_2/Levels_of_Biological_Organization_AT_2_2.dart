import 'package:capstone/Module%20Contents/Levels%20of%20Biological%20Organization/Levels_of_Biological_Organization_AT/Levels_of_Biological_Organization_AT_2_2/content.dart';
import 'package:capstone/Module%20Contents/Levels%20of%20Biological%20Organization/Levels_of_Biological_Organization_TLA/Levels_of_Biological_Organization_TLA_2_1.dart';
import 'package:flutter/material.dart';
import 'package:capstone/categories/levels_of_biological_organization_screen.dart';
import 'package:capstone/categories/animal_and_plant_screen.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class Biological_Organization_AT_2_2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Levels_of_biological_organization_Screen(),
          ),
        );
        return false;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xFF9463FF),
              floating: false,
              pinned: false,
              snap: false,
              expandedHeight: 120.0,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final isTop =
                      constraints.biggest.height <= kToolbarHeight + 16.0;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isTop) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0, left: 50.0),
                          child: Text(
                            'Levels of Biological Organization',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: Text(
                            'Assessment Task',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 50.0, right: 18.0),
                          child: Text(
                            'AT 2.2: Quiz ',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
              leading: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Levels_of_biological_organization_Screen(),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                  top: 60.0, // Top padding to move the container upwards
                  left: 20.0,
                  right: 20.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white, // White background color
                            borderRadius: BorderRadius.circular(
                                15.0), // Border radius on all sides
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.01), // Shadow color
                                spreadRadius: 0.01,
                                blurRadius: 4,
                                offset: Offset(0, 4), // Shadow position
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(
                              16.0), // Add padding inside the container
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                    8.0), // Add padding around the text
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.quiz,
                                      color: Color(
                                          0xFF9463FF), // Set icon color to match app theme
                                      size: 40.0, // Increase icon size
                                    ),
                                    SizedBox(width: 8.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'AT 2.1',
                                          style: TextStyle(
                                            fontSize:
                                                18.0, // Slightly larger text size
                                            fontWeight: FontWeight.bold,
                                            color: Colors
                                                .black, // Set text color to black
                                          ),
                                        ),
                                        Text(
                                          'Sequencing of Biological Levels',
                                          style: TextStyle(
                                            fontSize:
                                                12.0, // Smaller text size for the subtitle
                                            color: Colors.grey[
                                                600], // Set text color to gray
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    8.0), // Add padding around the text
                                child: Text(
                                  'Instructions: In this sequencing quiz, your task is to arrange the levels of biological organization in the correct order based on the descriptions provided. Carefully read each description and use your knowledge to correctly sequence the levels.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 14.0, // Standard text size
                                    color:
                                        Colors.black, // Set text color to black
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                width: double
                                    .infinity, // Make the button fill the width of the container
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          LevelsOfOrganizationDragDrop(),
                                    ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(
                                        0xFF9463FF), // Set button color to match app theme
                                    padding: EdgeInsets.symmetric(
                                      vertical: 16.0,
                                    ), // Ensure the button fills the bottom space
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          12.0), // Match the border radius of the container
                                    ),
                                  ),
                                  child: Text(
                                    'Start Quiz',
                                    style: TextStyle(
                                      color: Colors
                                          .white, // Set text color to white
                                      fontSize: 16.0,
                                      fontWeight: FontWeight
                                          .bold, // Make button text bold
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Biological_Organization_TLA_2_1(),
                      ),
                    );
                  },
                  heroTag: 'prevBtn',
                  child: Icon(
                    Icons.navigate_before,
                    color: Colors.white,
                  ),
                  backgroundColor: Color(0xFF9463FF),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Opacity(
                  opacity: globalVariables.getQuizTaken('lesson2', 'quiz1')
                      ? 1.0
                      : 0.5,
                  child: FloatingActionButton(
                    onPressed: () {
                      if (globalVariables.getQuizTaken('lesson2', 'quiz1')) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Animal_and_Plant_Screen(),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Quiz not taken'),
                            content: Text(
                                'Please take the quiz for this lesson before proceeding to the next lesson.'),
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
                    heroTag: 'nextBtn',
                    child: Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                    ),
                    backgroundColor: Color(0xFF9463FF),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
