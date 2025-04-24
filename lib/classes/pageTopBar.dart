import 'package:dog_food/classes/checkout_screen.dart';
import 'package:dog_food/classes/dropDownTab.dart';
import 'package:dog_food/constants/constants.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:flutter/material.dart';

class PageTopBar extends StatelessWidget {
  const PageTopBar({
    super.key,
    required this.onMenuItemSelected,
    required this.scaffoldKey,
  });

  final ValueChanged<String> onMenuItemSelected;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 840;

    return IntrinsicHeight(
      child: ColoredBox(
        color: DogFoodAppTheme.themeBrownColor,
        child: Row(
          children: [
            if (!isSmallScreen)
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.center,
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
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    DropDownTab(
                      onSelected: onMenuItemSelected,
                      title: 'Our Story',
                      items: const [
                        (value: 'about', text: 'About Us'),
                        (value: 'values', text: 'Our Values'),
                        (value: 'team', text: 'Team'),
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    DropDownTab(
                      onSelected: onMenuItemSelected,
                      title: 'Contact Us',
                      items: const [
                        (value: 'email', text: 'Email'),
                        (value: 'phone', text: 'Phone'),
                        (value: 'location', text: 'Location'),
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: horizontalPadding24 + verticalPadding8,
                        backgroundColor: DogFoodAppTheme.primaryButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckoutScreen(),
                          ),
                        );
                      },
                      child: const Text("cart"),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  ],
                ),
              ),
            if (isSmallScreen)
              Expanded(
                child: Padding(
                  padding: allPadding4,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        scaffoldKey.currentState?.openEndDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: DogFoodAppTheme.backgroundColor,
                      ),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: allPadding8,
              child: GestureDetector(
                onTap: () {},
                child: SizedBox.square(
                  dimension: 48,
                  child: Image.asset(
                    "assets/assets/images/logo.png",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
