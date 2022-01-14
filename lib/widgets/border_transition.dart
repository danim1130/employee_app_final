import 'package:flutter/material.dart';

class BorderRadiusTransition extends AnimatedWidget {
  final Animation<BorderRadius?> animation;
  final Widget child;

  const BorderRadiusTransition({
    required this.animation,
    required this.child,
    Key? key,
  }) : super(
    key: key,
    listenable: animation,
  );

  @override
  Widget build(BuildContext context) {
    var borderRadius = animation.value;
    return ClipRRect(
      borderRadius: borderRadius,
      child: child,
    );
  }
}