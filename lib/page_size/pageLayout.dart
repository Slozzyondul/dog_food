import 'package:dog_food/page_size/pageOverflow.dart';
import 'package:dog_food/page_size/responsive_screen_helper.dart';
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
    return LayoutBuilder(builder: (context, constraints) {
      final isSmall = ResponsiveHelper.isSmallScreen(context);

      return PageOverflow(
        width: ResponsiveHelper.responsiveValue(
          context,
          small: constraints.maxWidth * 0.95,
          large: 1200.0,
        ),
        child: Material(
          color: DogFoodAppTheme.backgroundColor,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                maxWidth: ResponsiveHelper.responsiveValue(
                  context,
                  small: double.infinity,
                  large: constraints.maxWidth
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...children.map(
                    (child) => Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: isSmall ? 8.0 : 12.0,
                      ),
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
