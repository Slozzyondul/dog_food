import 'package:dog_food/classes/bestSeller.dart';
import 'package:dog_food/classes/homebanner.dart';
import 'package:dog_food/classes/pageLayout.dart';
import 'package:dog_food/classes/pageTopBar.dart';
import 'package:dog_food/classes/sellingPoints.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onMenuItemSelected(String value) {
    print('Item $value');
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      children: [
        PageTopBar(
          onMenuItemSelected: onMenuItemSelected,
        ),
        const HomeBannerWidget(),
        const SellingPointWidget(
          items: [
            (icon: Icons.verified, text: 'Satisfaction guaranteed'),
            (icon: Icons.grain, text: 'Grain free'),
            (icon: Icons.local_shipping, text: 'Free delivery'),
          ],
        ),
      ],
    );
  }
}
