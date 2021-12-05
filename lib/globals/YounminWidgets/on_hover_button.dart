import 'package:flutter/material.dart';

class OnHoverButton extends StatefulWidget {
  final Matrix4 hoveredTransform;
  final Duration animationDuration;
  final Widget child;
  const OnHoverButton({
    Key? key,
    required this.child,
    required this.hoveredTransform,
    required this.animationDuration,
  }) : super(key: key);

  @override
  OnHoverButtonState createState() => OnHoverButtonState();
}

class OnHoverButtonState extends State<OnHoverButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => onEntered(true),
      onExit: (event) => onEntered(false),
      child: AnimatedContainer(
        duration: widget.animationDuration,
        child: widget.child,
        transform: isHovered ? widget.hoveredTransform : Matrix4.identity(),
      ),
    );
  }

  void onEntered(bool isHovered) {
    setState(() {
      this.isHovered = isHovered;
    });
  }
}
