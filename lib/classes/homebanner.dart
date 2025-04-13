import 'package:auto_size_text/auto_size_text.dart';
import 'package:dog_food/page_size/childbuilder.dart';
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
        final isSmallScreen = size.width < 840;
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: isSmallScreen ? size.height * 0.25 : size.height * 0.45,
            maxHeight: isSmallScreen ? size.height * 0.35 : size.height * 0.5,
          ),
          child: child,
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 840;
          return DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/assets/images/banner5.png'),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Container(
              color: Colors.transparent,
              //color: DogFoodAppTheme.backgroundColor,
              padding: EdgeInsets.symmetric(
                vertical: isSmallScreen ? 16 : 4,
                horizontal: isSmallScreen ? 8 : 8,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Padding(
                      padding: horizontalPadding4,
                      child: AutoSizeText.rich(
                        TextSpan(
                          text: 'HEALTHY, HAPPY PETS\n',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                            fontWeight: FontWeight.bold,
                            color: DogFoodAppTheme.themeBrownColor,
                            shadows: const [
                              Shadow(
                                offset: Offset(1, 1),
                                blurRadius: 4,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          children: [
                            TextSpan(
                              text: 'STARTS HERE!\n\n',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 16 : 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'High-protein kibble\n',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'Delivered fresh to your door',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        minFontSize: 12,
                        stepGranularity: 1,
                      ),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 12 : 12),
                  ElevatedButton(
                    onPressed: () async {
                      const url = 'https://wa.me/message/UTDJXATS2FQXM1';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Could not launch WhatsApp')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 24 : 32,
                        vertical: isSmallScreen ? 12 : 16,
                      ),
                      backgroundColor: DogFoodAppTheme.primaryButtonColor,
                      foregroundColor: DogFoodAppTheme.primaryButtonTextColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(
                        isSmallScreen
                            ? constraints.maxWidth * 0.5
                            : constraints.maxWidth * 0.3,
                        isSmallScreen ? 32 : 48,
                      ),
                    ),
                    child: Text(
                      'Shop Now',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 2 : 4),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
