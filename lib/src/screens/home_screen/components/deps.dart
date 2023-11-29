import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    this.width,
    this.height,
    this.backgroundColor = Colors.white,
    this.radius = 400,
    this.padding = 0,
    this.child,
    super.key,
    this.margin,
  });

  final double radius;
  final double? width, height;
  final Color backgroundColor;
  final double padding;
  final Widget? child;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
