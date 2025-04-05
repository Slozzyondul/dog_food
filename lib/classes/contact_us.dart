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
      padding: allPadding4,
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
    return Padding(
      padding: allPadding8,
      child: Column(
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
          verticalMargin16,
          Row(
            children: [
              const Icon(
                Icons.email,
                size: 18,
                color: Colors.black,
              ),
              horizontalMargin18,
              Text(
                "pawske@gmail.com",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          verticalMargin16,
          Row(
            children: [
              _buildSocialButton(
                icon: Icons.facebook,
                url: 'https://www.facebook.com/paws.co.ke',
              ),
              const SizedBox(width: 8),
              _buildSocialButton(
                icon: Icons.camera_alt,
                url: 'https://www.instagram.com/paws.co.ke/',
              ),
              const SizedBox(width: 8),
              _buildSocialButton(
                icon: Icons.contact_phone,
                url: 'https://wa.me/message/UTDJXATS2FQXM1',
              ),
            ],
          ),
        ],
      ),
    );
  }

 
  Widget _buildRightColumn(BuildContext context) {
    return Padding(
      padding: allPadding0,
      child: Column(
        children: [
          _buildTextField("Your Name", _nameController),
          const SizedBox(height: 8),
          _buildTextField("Your Email Address", _emailController),
          const SizedBox(height: 8),
          _buildTextField("Your Mobile Number", _mobileController),
          const SizedBox(height: 8),
          _buildTextField("How Can I Help You", _messageController,
              maxLines: 5),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: horizontalPadding24 + verticalPadding8,
                  backgroundColor: DogFoodAppTheme.primaryButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  await submitDataToSheet(
                    context,
                    _nameController.text,
                    _emailController.text,
                    _mobileController.text,
                    _messageController.text,
                  );

                  _nameController.clear();
                  _emailController.clear();
                  _mobileController.clear();
                  _messageController.clear();
                },
                child: const Text("Submit"),
              ),
              OutlinedButton(
                onPressed: () {
                  _nameController.clear();
                  _emailController.clear();
                  _mobileController.clear();
                  _messageController.clear();
                },
                child: const Text("Reset"),
              ),
            ],
          ),
        ],
      ),
    );
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

  Widget _buildSocialButton({required IconData icon, required String url}) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          debugPrint('could not launch $url');
        }
      },
      child: _buildSocialIcon(icon),
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
