import 'package:dog_food/constants/constants.dart';
import 'package:dog_food/constants/themes.dart';
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
    return Padding(
      padding: allPadding8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Contact Us!",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  "If you have any questions in mind.",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Feel free to reach out to us with any questions or concerns – "
                  "we’re here to help you find the best nutrition for your pets!",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.phone, size: 18, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      "+254792 352 745",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.email, size: 18, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      "pawske@gmail.com",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    GestureDetector(
                      child: _buildSocialIcon(Icons.facebook),
                      onTap: () async {
                        const url = 'https://www.facebook.com/paws.co.ke';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          // Handle error if the URL cannot be launched
                          print('Could not launch $url');
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      child: _buildSocialIcon(Icons.camera_alt),
                      onTap: () async {
                        const url = 'https://www.instagram.com/paws.co.ke/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          // Handle error if the URL cannot be launched
                          print('Could not launch $url');
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      child: _buildSocialIcon(Icons.contact_phone),
                      onTap: () async {
                        const url = 'https://wa.me/message/UTDJXATS2FQXM1';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          // Handle error if the URL cannot be launched
                          print('Could not launch $url');
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Right Column
          Expanded(
            flex: 1,
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
                      onPressed: () {
                        submitDataToSheet(
                          _nameController.text,
                          _emailController.text,
                          _mobileController.text,
                          _messageController.text,
                        );

                        // Optionally clear fields after submission
                        _nameController.clear();
                        _emailController.clear();
                        _mobileController.clear();
                        _messageController.clear();
                      },
                      child: const Text("Submit"),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        // Reset action
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

  Widget _buildSocialIcon(IconData icon) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.black,
      child: Icon(icon, color: Colors.white),
    );
  }
}
