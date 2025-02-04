
import 'package:dog_food/constants/constants.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:flutter/material.dart';

class SellingPointWidget extends StatelessWidget {
  const SellingPointWidget({
    super.key,
    required this.items,
  });

  final List<({IconData icon, String text})> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: DogFoodAppTheme.themeBrownColor,
        child: Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final item in items) //
                _SellingPointItem(
                  icon: item.icon,
                  text: item.text,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SellingPointItem extends StatelessWidget {
  const _SellingPointItem({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Minimize horizontal space usage
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20, // Adjust icon size if needed
        ),
        horizontalMargin4, // Spacing between icon and text
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}