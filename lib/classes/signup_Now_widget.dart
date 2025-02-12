import 'package:dog_food/constants/constants.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:flutter/material.dart';

class SignupNowWidget extends StatefulWidget {
  const SignupNowWidget({super.key});

  @override
  _SignupNowWidgetState createState() => _SignupNowWidgetState();
}

class _SignupNowWidgetState extends State<SignupNowWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MaterialButton(
        onPressed: () {},
        padding: allPadding16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: DogFoodAppTheme.secondaryButtonColor),
        ),
        child: const Text('Sign Up Now'),
      ),
    );
  }
}
