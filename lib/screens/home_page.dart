import 'package:dog_food/methods/build_drop_down.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double device_width, device_height;
  @override
  Widget build(BuildContext context) {
    device_width = MediaQuery.of(context).size.width;
    device_height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {},
                child: Image.asset(
                  "/assets/images/logo.png",
                  height: device_height * 0.3,
                ),
              );
            },
          ),
          // backgroundColor: Color.fromRGBO(248, 249, 250, 1),
          backgroundColor: const Color.fromRGBO(179, 128, 86, 1),

          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              buildDropdownTab(
                context,
                "Dog Food",
                [
                  const PopupMenuItem(
                    value: "dry",
                    child: Text(
                      "Dry Food",
                      style: TextStyle(color: Color.fromRGBO(139, 94, 60, 1)),
                    ),
                  ),
                  const PopupMenuItem(
                    value: "wet",
                    child: Text(
                      "Wet Food",
                      style: TextStyle(color: Color.fromRGBO(139, 94, 60, 1)),
                    ),
                  ),
                  const PopupMenuItem(
                    value: "snacks",
                    child: Text(
                      "Snacks",
                      style: TextStyle(color: Color.fromRGBO(139, 94, 60, 1)),
                    ),
                  ),
                ],
              ),
              buildDropdownTab(
                context,
                "Our Story",
                [
                  const PopupMenuItem(
                    value: "about",
                    child: Text(
                      "About Us",
                      style: TextStyle(color: Color.fromRGBO(139, 94, 60, 1)),
                    ),
                  ),
                  const PopupMenuItem(
                    value: "values",
                    child: Text(
                      "Our Values",
                      style: TextStyle(color: Color.fromRGBO(139, 94, 60, 1)),
                    ),
                  ),
                  const PopupMenuItem(
                    value: "team",
                    child: Text(
                      "Team",
                      style: TextStyle(color: Color.fromRGBO(139, 94, 60, 1)),
                    ),
                  ),
                ],
              ),
              buildDropdownTab(
                context,
                "Contact Us",
                [
                  const PopupMenuItem(
                    value: "email",
                    child: Text(
                      "Email",
                      style: TextStyle(color: Color.fromRGBO(139, 94, 60, 1)),
                    ),
                  ),
                  const PopupMenuItem(
                    value: "phone",
                    child: Text(
                      "Phone",
                      style: TextStyle(color: Color.fromRGBO(139, 94, 60, 1)),
                    ),
                  ),
                  const PopupMenuItem(
                    value: "location",
                    child: Text(
                      "Location",
                      style: TextStyle(color: Color.fromRGBO(139, 94, 60, 1)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            homeBannerWidget(context),
          ],
        ),
      ),
    );
  }

  Widget homeBannerWidget(BuildContext context) {
    return Container(
      width: double.infinity, 
      height: device_height * 0.35,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/assets/images/banner5.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0), // Add horizontal padding
            child: AutoSizeText.rich(
              TextSpan(
                text: 'HEALTHY, HAPPY PETS\n',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(179, 128, 86, 1),
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
                      color: Color.fromRGBO(179, 128, 86, 1),
                    ),
                  ),
                  TextSpan(
                    text: 'Delivered fresh to your door\n',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(179, 128, 86, 1),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              maxLines: 5, // Adjust to fit within space
              minFontSize: 12, // Minimum font size for responsiveness
            ),
          ),
          SizedBox(height: device_height * 0.1), // Add spacing between text and button
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
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              backgroundColor: Colors.white70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Shop Now',
              style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(0, 77, 64, 1),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget sellingPointWidget() {
    return Container();
  }
}
