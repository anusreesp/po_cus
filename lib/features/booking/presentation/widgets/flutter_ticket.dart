import 'package:flutter/material.dart';

class FlutterTicketWidget extends StatefulWidget {
  final double width;
  final double height;
  final Widget child;
  final Color color;
  final bool isCornerRounded;
  final double ticketCutHeight;
  const FlutterTicketWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.child,
      this.color = Colors.white,
      this.isCornerRounded = false,
        this.ticketCutHeight = 2.0 //default center
      });

  @override
  _FlutterTicketWidgetState createState() => _FlutterTicketWidgetState();
}

class _FlutterTicketWidgetState extends State<FlutterTicketWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(widget.ticketCutHeight),
      child: AnimatedContainer(
        duration: const Duration(seconds: 3),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: widget.color,
            borderRadius: widget.isCornerRounded
                ? const BorderRadius.all(Radius.circular(10))
                // ? BorderRadius.only(
                //     topLeft: Radius.circular(10), topRight: Radius.circular(10))
                : BorderRadius.circular(0.0)),
        child: widget.child,
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  final double ticketCutHeight;
  TicketClipper(this.ticketCutHeight);

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(
        Rect.fromCircle(center: Offset(0.0, size.height / ticketCutHeight), radius: 20.0));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / ticketCutHeight), radius: 20.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
