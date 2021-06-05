import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CustomShape extends StatelessWidget {
  final width;
  final height;
  const CustomShape({Key key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
          width,
          (width * 0.5172413793103449)
              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
      painter: RPSCustomPainter(),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
    paint_0.shader = ui.Gradient.linear(
        Offset(size.width * 0.19, size.height * 0.93),
        Offset(size.width * 0.77, size.height * 0.08),
        [Color(0xff6ab9ff), Color(0xff2147fd)],
        [0.00, 1.00]);

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.2349655, size.height * 0.4115833);
    path_0.cubicTo(
        size.width * 0.1858879,
        size.height * 0.7788000,
        size.width * 0.2909397,
        size.height * 0.8871000,
        size.width * 0.3813190,
        size.height * 0.9159167);
    path_0.cubicTo(
        size.width * 0.4277414,
        size.height * 0.9341500,
        size.width * 0.5930345,
        size.height * 0.9208500,
        size.width * 0.6477759,
        size.height * 0.8635000);
    path_0.cubicTo(
        size.width * 0.7148448,
        size.height * 0.8066167,
        size.width * 0.7686466,
        size.height * 0.5060500,
        size.width * 0.6398017,
        size.height * 0.2308833);
    path_0.cubicTo(
        size.width * 0.5584138,
        size.height * 0.0856333,
        size.width * 0.4702241,
        size.height * 0.0842667,
        size.width * 0.3935862,
        size.height * 0.1265333);
    path_0.cubicTo(
        size.width * 0.3024224,
        size.height * 0.1862500,
        size.width * 0.2572845,
        size.height * 0.2971667,
        size.width * 0.2349655,
        size.height * 0.4115833);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
