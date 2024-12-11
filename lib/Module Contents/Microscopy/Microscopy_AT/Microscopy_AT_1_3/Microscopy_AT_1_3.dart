import 'package:capstone/Module%20Contents/Microscopy/Microscopy_AT/Microscopy_AT_1_2/Microscopy_AT_1_2.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_AT/Microscopy_AT_1_3/Microscopy_AT_Quiz_1_Content.dart';
import 'package:capstone/categories/levels_of_biological_organization_screen.dart';
import 'package:capstone/categories/microscopy_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';

class Microscopy_AT_1_3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MicroscopyScreen(),
          ),
        );
        return false;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xFFFFA551),
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
                          padding: const EdgeInsets.only(
                            top: 25.0,
                            left: 50.0,
                          ),
                          child: Text(
                            'Microscopy',
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
                            'AT 1.2',
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
                        builder: (context) => MicroscopyScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                  top: 60.0,
                  left: 20,
                  right:
                      20), // Further reduced top padding to move the container upwards
              sliver: SliverPadding(
                padding: EdgeInsets.all(16.0),
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
                                            0xFFFFA551), // Set icon color to orange
                                        size: 40.0, // Increase icon size
                                      ),
                                      SizedBox(width: 8.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'AT 1.2',
                                              style: TextStyle(
                                                fontSize:
                                                    18.0, // Slightly larger text size
                                                fontWeight: FontWeight.bold,
                                                color: Colors
                                                    .black, // Set text color to black
                                              ),
                                            ),
                                            Text(
                                              'Sequencing of how to focus specimen on a compound microscope',
                                              style: TextStyle(
                                                fontSize:
                                                    12.0, // Smaller text size for the subtitle
                                                color: Colors.grey[
                                                    600], // Set text color to gray
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(
                                      8.0), // Add padding around the text
                                  child: Text(
                                    'Instructions: In this sequencing task, you will arrange the steps required to properly focus on a microscope slide. Carefully consider the sequence of actions from adjusting the coarse focus to fine-tuning the image. Your knowledge of microscope usage will guide you through placing these steps in the correct order.',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 14.0, // Standard text size
                                      color: Colors
                                          .black, // Set text color to black
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
                                            Microscopy_AT_Quiz_1_Content(),
                                      ));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(
                                          0xFFFFA551), // Set button color to orange
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              16.0), // Ensure the button fills the bottom space
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
                        builder: (context) => Microscopy_AT_1_2(),
                      ),
                    );
                  },
                  heroTag: 'prevBtn',
                  child: Icon(
                    Icons.navigate_before,
                    color: Colors.white,
                  ),
                  backgroundColor: Color(0xFFFFA551),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Opacity(
                  opacity: globalVariables.getQuizTaken('lesson1', 'quiz2')
                      ? 1.0
                      : 0.5,
                  child: FloatingActionButton(
                    onPressed: () {
                      if (globalVariables.getQuizTaken('lesson1', 'quiz2')) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Levels_of_biological_organization_Screen(),
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
                    backgroundColor: Color(0xFFFFA551),
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
