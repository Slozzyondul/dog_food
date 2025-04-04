import 'package:flutter/material.dart';

class ChildBuilder extends StatelessWidget {
  const ChildBuilder({
    super.key,
    required this.builder,
    this.child,
  });

  final TransitionBuilder builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) => builder(context, child);
}
