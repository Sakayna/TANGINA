import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onNavItemTap;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onNavItemTap,
  });

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_outlined, 'Home'),
          _buildNavItem(1, Icons.category_outlined, 'Categories'),
          _buildNavItem(2, Icons.quiz_outlined, 'Quiz'),
          _buildNavItem(3, Icons.trending_up, 'Record Module'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    return InkWell(
      onTap: () {
        widget.onNavItemTap(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: widget.currentIndex == index
                  ? Color(0xFF00B4D8)
                  : Color(0xFFC8C8C8),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: widget.currentIndex == index
                    ? Color(0xFF00B4D8)
                    : Color(0xFFC8C8C8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
