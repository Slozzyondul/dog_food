import 'package:dog_food/classes/contact_us.dart';
import 'package:dog_food/classes/footer.dart';
import 'package:dog_food/classes/homebanner.dart';
import 'package:dog_food/classes/sellingPoints.dart';
import 'package:dog_food/page_size/pageLayout.dart';
import 'package:dog_food/classes/pageTopBar.dart';
import 'package:dog_food/classes/signup_Now_widget.dart';
import 'package:dog_food/classes/smallScreen.dart';
import 'package:dog_food/constants/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void onMenuItemSelected(String value) {
    print('Item $value');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const SmallScreenDrawer(),
      body: PageLayout(
        children: [
          PageTopBar(
            onMenuItemSelected: onMenuItemSelected,
            scaffoldKey: _scaffoldKey,
          ),
          const HomeBannerWidget(),
          verticalMargin2,
          const SellingPointWidget(
            items: [
              {'icon': Icons.verified, 'text': 'Satisfaction guaranteed'},
              {'icon': Icons.grain, 'text': 'Grain free'},
              {'icon': Icons.local_shipping, 'text': 'Free delivery'},
            ],
          ),
          verticalMargin2,
          const SignupNowWidget(),
          verticalMargin2,
          // const BestSellerWidget(),
          verticalMargin32,
          // const WhyUs(),
          verticalMargin2,
          const ContactUs(),
          //verticalMargin16,
          const Spacer(),
          const Footer(),
        ],
      ),
    );
  }
}
