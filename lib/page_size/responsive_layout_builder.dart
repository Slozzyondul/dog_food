import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget smallScreen;
  final Widget? mediumScreen;
  final Widget largeScreen;

  const ResponsiveLayout({
    super.key,
    required this.smallScreen,
    this.mediumScreen,
    required this.largeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 840) return smallScreen;
        if (constraints.maxWidth < 1200) return mediumScreen ?? largeScreen;
        return largeScreen;
      },
    );
  }
}