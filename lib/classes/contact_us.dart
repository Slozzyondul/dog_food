import 'package:dog_food/constants/constants.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:dog_food/page_size/responsive_screen_helper.dart';
import 'package:dog_food/server/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isSmall = ResponsiveHelper.isSmallScreen(context);
    final isLandscape = ResponsiveHelper.isLandscape(context);

    final leftColumn = _buildLeftColumn(context);
    final rightColumn = _buildRightColumn(context);

    return Padding(
      padding: allPadding16,
      child: isSmall && !isLandscape
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                leftColumn,
                verticalMargin24,
                rightColumn,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: leftColumn),
                horizontalMargin24,
                Expanded(flex: 1, child: rightColumn),
              ],
            ),
    );
  }

  Widget _buildLeftColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact Us",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: DogFoodAppTheme.primaryButtonColor,
              ),
        ),
        verticalMargin8,
        Text(
          "If you have any questions in mind.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        verticalMargin8,
        Text(
          "Feel free to reach out to us with any questions or concerns – "
          "we’re here to help you find the best nutrition for your pets!",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        verticalMargin16,
        Row(
          children: [
            const Icon(
              Icons.phone,
              size: 18,
              color: Colors.black,
            ),
            horizontalMargin18,
            Text(
              "+254-792-352-745",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context) {
    return Column();
  }

  Widget _buildTextField(String hintText, TextEditingController controller,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: DogFoodAppTheme.backgroundColor1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.black,
      child: Icon(icon, color: Colors.white),
    );
  }
}
