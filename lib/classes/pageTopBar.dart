import 'package:dog_food/classes/dropDownTab.dart';
import 'package:dog_food/constants/constants.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:flutter/material.dart';

class PageTopBar extends StatelessWidget {
  const PageTopBar({
    super.key,
    required this.onMenuItemSelected,
  });

  final ValueChanged<String> onMenuItemSelected;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: ColoredBox(
        color: DogFoodAppTheme.themeBrownColor,
        child: Row(
          children: [
            Padding(
              padding: allPadding8,
              child: GestureDetector(
                onTap: () {},
                child: SizedBox.square(
                  dimension: 48.0,
                  child: Image.asset(
                    "/assets/images/logo.png",
                  ),
                ),
              ),
            ),
            Expanded(
              child: Wrap(
                alignment: WrapAlignment.end,
                children: [
                  DropDownTab(
                    onSelected: onMenuItemSelected,
                    title: 'Dog Food',
                    items: const [
                      (value: 'dry', text: 'Dry Food'),
                      (value: 'wet', text: 'Wet Food'),
                      (value: 'snacks', text: 'Snacks'),
                    ],
                  ),
                  DropDownTab(
                    onSelected: onMenuItemSelected,
                    title: 'Our Story',
                    items: const [
                      (value: 'about', text: 'About Us'),
                      (value: 'values', text: 'Our Values'),
                      (value: 'team', text: 'Team'),
                    ],
                  ),
                  DropDownTab(
                    onSelected: onMenuItemSelected,
                    title: 'Contact Us',
                    items: const [
                      (value: 'email', text: 'Email'),
                      (value: 'phone', text: 'Phone'),
                      (value: 'location', text: 'Location'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
