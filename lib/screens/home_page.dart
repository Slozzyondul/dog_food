import 'package:dog_food/classes/bestSeller.dart';
import 'package:dog_food/classes/contact_us.dart';
import 'package:dog_food/classes/footer.dart';
import 'package:dog_food/classes/homebanner.dart';
import 'package:dog_food/classes/pageLayout.dart';
import 'package:dog_food/classes/pageTopBar.dart';
import 'package:dog_food/classes/sellingPoints.dart';
import 'package:dog_food/classes/signup_Now_widget.dart';
import 'package:dog_food/classes/why_us.dart';
import 'package:dog_food/constants/constants.dart';
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
    return Scaffold(
      body: PageLayout(
        children: [
          PageTopBar(
            onMenuItemSelected: onMenuItemSelected,
          ),
          verticalMargin4,
          const HomeBannerWidget(),
          verticalMargin4,
          const SellingPointWidget(
            items: [
              (icon: Icons.verified, text: 'Satisfaction guaranteed'),
              (icon: Icons.grain, text: 'Grain free'),
              (icon: Icons.local_shipping, text: 'Free delivery'),
            ],
          ),
          verticalMargin16,
          const SignupNowWidget(),
          verticalMargin12,
          const BestSellerWidget(),
          verticalMargin8,
          const WhyUs(),
          verticalMargin4,
          const ContactUs(),
          verticalMargin4,
          const Footer(),
        ],
      ),
    );
  }
}
