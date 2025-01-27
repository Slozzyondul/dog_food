import 'package:dog_food/constants/constants.dart';
import 'package:flutter/material.dart';

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
                      "+254 111 424 902",
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
                    _buildSocialIcon(Icons.facebook),
                    const SizedBox(width: 8),
                    _buildSocialIcon(Icons.camera_alt), // Instagram icon
                    const SizedBox(width: 8),
                    _buildSocialIcon(Icons.contact_phone),
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
                      onPressed: () {
                        // Submit action
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
        fillColor: Colors.green[100],
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
