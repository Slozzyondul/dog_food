import 'package:dog_food/methods/build_drop_down.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {},
                child: Image.asset(
                  "/images/logo.png",
                  height: 40,
                ),
              );
            },
          ),
          backgroundColor: Colors.brown,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildDropdownTab(context, "Dog Food", [
                const PopupMenuItem(value: "dry", child: Text("Dry Food")),
                const PopupMenuItem(value: "wet", child: Text("Wet Food")),
                const PopupMenuItem(value: "snacks", child: Text("Snacks")),
              ]),
              buildDropdownTab(context, "Our Story", [
                const PopupMenuItem(value: "about", child: Text("About Us")),
                const PopupMenuItem(value: "values", child: Text("Our Values")),
                const PopupMenuItem(value: "team", child: Text("Team")),
              ]),
              buildDropdownTab(context, "Contact Us", [
                const PopupMenuItem(value: "email", child: Text("Email")),
                const PopupMenuItem(value: "phone", child: Text("Phone")),
                const PopupMenuItem(value: "location", child: Text("Location")),
              ]),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
          ],
        ),
      ),
    );
  }
}
