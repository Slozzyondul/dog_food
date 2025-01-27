import 'package:dog_food/constants/constants.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:flutter/material.dart';

class DropDownTab extends StatelessWidget {
  const DropDownTab({
    super.key,
    required this.onSelected,
    required this.title,
    required this.items,
  });

  final ValueChanged<String> onSelected;
  final String title;
  final List<({String text, String value})> items;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: PopupMenuButton(
        onSelected: onSelected,
        itemBuilder: (BuildContext context) {
          return [
            for (final item in items) //
              PopupMenuItem(
                value: item.value,
                child: Text(
                  item.text,
                  style: const TextStyle(color: DogFoodAppTheme.menuBrownColor),
                ),
              ),
          ];
        },
        child: Padding(
          padding: verticalPadding4 + horizontalPadding8,
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}