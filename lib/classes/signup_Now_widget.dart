import 'package:dog_food/classes/dog_info.dart';
import 'package:dog_food/constants/constants.dart';
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
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            textColor: DogFoodAppTheme.primaryButtonTextColor,
            color: DogFoodAppTheme.primaryButtonColor,
            onPressed: () async {
              final result = await Navigator.of(context).push(
                DogRegistration.route(_data),
              );
              if (mounted && result != null) {
                setState(() {
                  _data = result;
                });
              }
            },
            padding: allPadding16,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: DogFoodAppTheme.primaryButtonColor),
            ),
            child: const Text('Sign Up Now'),
          ),
        ],
      ),
    );
  }
}
