import 'package:dog_food/page_size/responsive_screen_helper.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:flutter/material.dart';

class SellingPointWidget extends StatelessWidget {
  const SellingPointWidget({
    super.key,
    required this.items,
  });

  final List<Map<String, dynamic>> items; 

  @override
  Widget build(BuildContext context) {
    final isSmall = ResponsiveHelper.isSmallScreen(context);
    final isLandscape = ResponsiveHelper.isLandscape(context);

    List<Map<String, dynamic>> firstRow = items.length >= 2 ? items.sublist(0, 2) : items;
    List<Map<String, dynamic>> secondRow = items.length > 2 ? items.sublist(2) : [];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 0 : 0,
        vertical: isSmall ? 0 : 0,
      ),
      child: Container(
        width: double.infinity,
        height: ResponsiveHelper.responsiveValue(
          context,
          small: isLandscape ? 80 : 100,
          large: 80,
        ),
        decoration: BoxDecoration(
          color: DogFoodAppTheme.themeBrownColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(isSmall ? 8 : 16),
        child: isSmall && !isLandscape
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: firstRow.map((item) => 
                      _buildItem(context, item, isSmall),
                    ).toList(),
                  ),
                  if (secondRow.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: secondRow.map((item) => 
                        _buildItem(context, item, isSmall),
                      ).toList(),
                    ),
                  ],
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: items.map((item) => 
                  _buildItem(context, item, isSmall),
                ).toList(),
              ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, Map<String, dynamic> item, bool isSmall) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 4 : 8,
        vertical: isSmall ? 2 : 4,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            item['icon'] as IconData,
            color: Colors.white,
            size: isSmall ? 18 : 24,
          ),
          const SizedBox(width: 8),
          Text(
            item['text'] as String,
            style: TextStyle(
              color: Colors.white,
              fontSize: isSmall ? 14 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
