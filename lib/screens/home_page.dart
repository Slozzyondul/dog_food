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
                  "/assets/images/logo.png",
                  height: 40,
                ),
              );
            },
          ),
          // backgroundColor: Color.fromRGBO(248, 249, 250, 1),
          backgroundColor: Color.fromRGBO(139, 94, 60, 1),

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
          children: [],
        ),
      ),
    );
  }

  
}
