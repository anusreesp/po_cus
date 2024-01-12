import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class NeedleVertical extends StatelessWidget {
  final double thickness;
  final double height;
  const NeedleVertical({super.key, this.thickness = 2, this.height = 124});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(thickness, height),
      painter: _NeedlePainterVertical(),
    );
  }
}

class NeedleHorizontal extends StatelessWidget {
  final double thickness;
  final double width;
  final bool flip;
  const NeedleHorizontal(
      {super.key, this.thickness = 2, this.width = 124, this.flip = false});

  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: flip,
      child: CustomPaint(
        size: Size(width, thickness),
        painter: _NeedlePainterHorizontal(),
        // painter: _NeedlePainterHorizontalFlipped(),
      ),
    );
  }
}

class NeedleDoubleSided extends StatelessWidget {
  final double width;
  final bool fullWidth;
  const NeedleDoubleSided(
      {super.key, this.width = double.infinity, this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, 2),
      painter: _NeedleDoubleSidedPainter(fullLine: fullWidth),
    );
  }
}

class _NeedleDoubleSidedPainter extends CustomPainter {
  final bool fullLine;
  const _NeedleDoubleSidedPainter({this.fullLine = false});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();

    if (fullLine) {
      paint.strokeWidth = 1;
      canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), paint);
    } else {
      paint.shader = ui.Gradient.radial(Offset(size.width * 0.5, 0),
          size.width * 0.8, [Colors.white, Colors.transparent]);

      final y1Value = size.width / 150;
      path.quadraticBezierTo(size.width * 0.5, -y1Value, size.width, 0);
      path.quadraticBezierTo(size.width * 0.5, -y1Value, size.width, 0);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _NeedlePainterVertical extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(const Offset(0, 0),
          Offset(size.width, size.height), [Colors.white, Colors.white24]);

    Path path = Path();

    path.moveTo(0, 0);
    // path.lineTo(size.height, size.width * 0.5);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _NeedlePainterHorizontal extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(const Offset(0, 0),
          Offset(size.width, size.height), [Colors.white, Colors.transparent]);

    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class OTPNeedle extends StatelessWidget {
  const OTPNeedle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: const RadialGradient(
              radius: 30,
              colors: [
                Colors.white,
                Colors.transparent,
              ]
          )
      ),
    );
  }
}


//
// class _NeedlePainterHorizontalFlipped extends CustomPainter{
//   @override
//   void paint(Canvas canvas, Size size) {
//
//     Paint paint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill
//       ..shader = ui.Gradient.linear(
//           const Offset(0, 0),
//           Offset(size.width, size.height),
//           [
//             Colors.white,
//             Colors.transparent
//           ]);
//
//     // Path path = Path();
//     //
//     // path.moveTo(0, size.height * 0.5);
//     // path.lineTo(size.width, size.width);
//     // path.lineTo(0, size.height);
//     // path.close();
//
//     canvas.drawPath(getTriangle(size.width, size.height), paint);
//   }
//
//   Path getTriangle(double x, double y){
//     return Path()
//         ..moveTo(0, y)
//         ..lineTo(x/2, 0)
//         ..lineTo(x, y)
//         ..close();
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
