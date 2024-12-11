import 'package:flutter/material.dart';

class GraphCard extends StatelessWidget {
  final String title;
  final int itemCount;
  final int takeCount;

  GraphCard({
    required this.title,
    required this.itemCount,
    required this.takeCount,
  });

  // Method to get the image path based on the quiz title
  String getImagePath(String title) {
    switch (title) {
      case 'Lesson 1 Quiz 1':
      case 'Lesson 1 Quiz 2':
        return 'assets/images/quiz/quiz_icons/microscope.png';
      case 'Lesson 2 Quiz 1':
        return 'assets/images/quiz/quiz_icons/organization.png';
      case 'Lesson 3 Quiz 1':
      case 'Lesson 3 Quiz 2':
        return 'assets/images/quiz/quiz_icons/plant-cell.png';
      case 'Lesson 4 Quiz 1':
        return 'assets/images/quiz/quiz_icons/bacteria.png';
      case 'Lesson 5 Quiz 1':
      case 'Lesson 5 Quiz 2':
        return 'assets/images/quiz/quiz_icons/heredity .png';
      case 'Lesson 6 Quiz 1':
      case 'Lesson 6 Quiz 2':
      case 'Lesson 6 Quiz 3':
      case 'Lesson 6 Quiz 4':
        return 'assets/images/quiz/quiz_icons/eco.png';
      default:
        return 'assets/images/placeholder.png';
    }
  }

  // Method to get the color based on the quiz title
  Color getBoxColor(String title) {
    switch (title) {
      case 'Lesson 1 Quiz 1':
      case 'Lesson 1 Quiz 2':
        return Color(0xFFFFA551);
      case 'Lesson 2 Quiz 1':
        return Color(0xFF9463FF);
      case 'Lesson 3 Quiz 1':
      case 'Lesson 3 Quiz 2':
        return Color(0xFFA1C084);
      case 'Lesson 4 Quiz 1':
        return Color(0xFFFF6A6A);
      case 'Lesson 5 Quiz 1':
      case 'Lesson 5 Quiz 2':
        return Color(0xFF64B6AC);
      case 'Lesson 6 Quiz 1':
      case 'Lesson 6 Quiz 2':
      case 'Lesson 6 Quiz 3':
      case 'Lesson 6 Quiz 4':
        return Color(0xFFA846A0);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = getImagePath(title);
    final boxColor = getBoxColor(title);

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  color: boxColor,
                  width: double.infinity,
                  height: 150.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Text(
                itemCount > 0 && takeCount > 0
                    ? "$itemCount Item${itemCount > 1 ? 's' : ''} • $takeCount Take${takeCount > 1 ? 's' : ''}"
                    : "No Record",
                style: TextStyle(
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
