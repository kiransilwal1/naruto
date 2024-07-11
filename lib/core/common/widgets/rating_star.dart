import 'package:flutter/material.dart';
import 'dart:math';

class CurvedStar extends StatelessWidget {
  final double size;

  final double rating;
  final int index;

  const CurvedStar(
      {super.key,
      required this.size,
      required this.rating,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: CurvedStarPainter(index: index, rating: rating),
    );
  }
}

class CurvedStarPainter extends CustomPainter {
  final double rating;
  final int index;

  CurvedStarPainter({
    required this.rating,
    required this.index,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const Color color = Color(0xFFFCD240);
    const Color backgroundColor = Color(0xFFF3F3F3);
    final Paint paint = Paint()..style = PaintingStyle.fill;

    final Path path = Path();
    final double starRadius = size.width / 2;
    final double innerRadius = starRadius / 2.5;
    const int points = 5;
    const double angle = 2 * pi / points;

    //TODO: Neeeed to change the pointy start to curved star
    for (int i = 0; i <= points; i++) {
      final double outerTheta = i * angle - pi / 2;
      final double innerTheta = outerTheta + angle / 2;
      // debugPrint(innerTheta.toString());
      final Offset outerPoint = Offset(
        starRadius + starRadius * cos(outerTheta),
        starRadius + starRadius * sin(outerTheta),
      );

      final Offset innerPoint = Offset(
        starRadius + innerRadius * cos(innerTheta),
        starRadius + innerRadius * sin(innerTheta),
      );

      if (i == 0) {
        path.moveTo(outerPoint.dx, outerPoint.dy);
      } else {
        path.lineTo(outerPoint.dx, outerPoint.dy);
      }

      if (i < points) {
        path.lineTo(innerPoint.dx, innerPoint.dy);
      }
    }
    path.close();
    // logic to Fill percentage wise.
    double fillPercentage = 1.0;
    if (index > (rating.floor())) {
      // debugPrint('rating ${rating.round() + 1}');
      if (index <= rating.floor() + 1) {
        fillPercentage = rating - rating.floor();
      } else {
        fillPercentage = 0.0;
      }
    }

    paint.color = color;
    canvas.drawPath(path, paint);

    // Draing background color
    if (fillPercentage < 1.0) {
      paint.color = backgroundColor;
      canvas.save();
      canvas.clipPath(path);
      canvas.drawRect(
        Rect.fromLTWH(size.width * fillPercentage, 0,
            size.width * (1 - fillPercentage), size.height),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
