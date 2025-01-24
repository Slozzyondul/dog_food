import 'package:auto_size_text/auto_size_text.dart';
import 'package:dog_food/classes/childbuilder.dart';
import 'package:dog_food/constants/constants.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChildBuilder(
      builder: (context, child) {
        final size = MediaQuery.sizeOf(context);
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: size.height * 0.35,
          ),
          child: child,
        );
      },
      child: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/assets/images/banner5.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: verticalPadding24,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text
              Padding(
                padding: horizontalPadding16,
                child: AutoSizeText.rich(
                  TextSpan(
                    text: 'HEALTHY, HAPPY PETS\n',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: DogFoodAppTheme.themeBrownColor,
                      shadows: [
                        Shadow(
                          offset: const Offset(0, 1),
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                    children: const [
                      TextSpan(
                        text: 'STARTS HERE!\n\n',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'High-protein kibble\n',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: DogFoodAppTheme.themeBrownColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Delivered fresh to your door\n',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: DogFoodAppTheme.themeBrownColor,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 5, // Adjust to fit within space
                  minFontSize: 12, // Minimum font size for responsiveness
                ),
              ),
              // Add spacing between text and button
              verticalMargin24,
              // Sign Up Button
              ElevatedButton(
                onPressed: () async {
                  const url = 'https://wa.me/message/UTDJXATS2FQXM1';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    // Handle error if the URL cannot be launched
                    print('Could not launch $url');
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: horizontalPadding24 + verticalPadding8,
                  backgroundColor: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Shop Now',
                  style: TextStyle(
                    fontSize: 18,
                    color: DogFoodAppTheme.primaryButtonTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
