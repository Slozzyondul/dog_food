import 'package:dog_food/classes/pageOverflow.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:flutter/material.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return PageOverflow(
      width: 450.0,
      child: Material(
        color: DogFoodAppTheme.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    );
  }
}