import 'package:dog_food/classes/dog_info.dart';
import 'package:dog_food/page_size/responsive_screen_helper.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:flutter/material.dart';

class SignupNowWidget extends StatefulWidget {
  const SignupNowWidget({super.key});

  @override
  _SignupNowWidgetState createState() => _SignupNowWidgetState();
}

class _SignupNowWidgetState extends State<SignupNowWidget> {
  var _data = RegistrationData();

  @override
  Widget build(BuildContext context) {
    final isSmall = ResponsiveHelper.isSmallScreen(context);
    final isLandscape = ResponsiveHelper.isLandscape(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 16 : 24,
        vertical: isSmall ? 8 : 16,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 600,
            minWidth: isSmall ? 200 : 300,
          ),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: ElevatedButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  DogRegistration.route(_data),
                );
                if (mounted && result != null) {
                  setState(() => _data = result);
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmall ? 24 : 32,
                  vertical: isSmall ? 12 : 16,
                ),
                backgroundColor: DogFoodAppTheme.primaryButtonColor,
                foregroundColor: DogFoodAppTheme.primaryButtonTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                shadowColor: Colors.black26,
                minimumSize: Size(
                  isLandscape 
                      ? MediaQuery.of(context).size.width * 0.4
                      : MediaQuery.of(context).size.width * 0.8,
                  isSmall ? 50 : 60,
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  'Sign Up Now',
                  key: ValueKey(isSmall),
                  style: TextStyle(
                    fontSize: isSmall ? 16 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}