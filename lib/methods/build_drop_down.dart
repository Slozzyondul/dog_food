import 'package:flutter/material.dart';

Widget buildDropdownTab(BuildContext context, String title, List<PopupMenuEntry> items) {
    return PopupMenuButton(
      onSelected: (value) {
        // Handle navigation or actions here
        print("Selected: $value");
      },
      itemBuilder: (BuildContext context) => items,
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const Icon(Icons.arrow_drop_down, color: Colors.white),
        ],
      ),
    );
  }