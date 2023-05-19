import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;
  final Color dotColor;
  final double dotSize;
  final double spacing;

  const DotIndicator({
    required this.currentIndex,
    required this.itemCount,
    this.dotColor = Colors.grey,
    this.dotSize = 8.0,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildDots(),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < itemCount; i++) {
      dots.add(
        Container(
          width: dotSize,
          height: dotSize,
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == i ? dotColor : dotColor.withOpacity(0.4),
          ),
        ),
      );
    }
    return dots;
  }
}