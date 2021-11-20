import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShadowContainer extends StatelessWidget {
  EdgeInsetsGeometry? margin;
  late double width;
  late double shadowRadius;
  late double shadowBlurRadius;
  late Offset offset;
  late Widget child;

  ShadowContainer(
      {Key? key,
      required this.margin,
      required this.width,
      required this.shadowBlurRadius,
      required this.offset,
      required this.child,
      required this.shadowRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: margin,
          width: width,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: shadowRadius,
                  blurRadius: shadowBlurRadius,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)),
          child: child),
    );
  }
}
