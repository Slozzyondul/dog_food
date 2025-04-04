import 'package:flutter/material.dart';

enum ScreenSize { small, medium, large }

class ResponsiveHelper {
  static ScreenSize getScreenSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 600) return ScreenSize.small;
    if (width < 1200) return ScreenSize.medium;
    return ScreenSize.large;
  }

  static bool isSmallScreen(BuildContext context) => 
      getScreenSize(context) == ScreenSize.small;
  
  static bool isMediumScreen(BuildContext context) => 
      getScreenSize(context) == ScreenSize.medium;
  
  static bool isLargeScreen(BuildContext context) => 
      getScreenSize(context) == ScreenSize.large;
  
  static bool isLandscape(BuildContext context) => 
      MediaQuery.of(context).orientation == Orientation.landscape;
  
  static double responsiveValue(
    BuildContext context, {
    required double small,
    double? medium,
    required double large,
  }) {
    final size = getScreenSize(context);
    if (size == ScreenSize.small) return small;
    if (size == ScreenSize.medium) return medium ?? (small + large) / 2;
    return large;
  }
}