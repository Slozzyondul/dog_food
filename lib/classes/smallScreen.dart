import 'package:dog_food/classes/checkout_screen.dart';
import 'package:dog_food/constants/themes.dart';
import 'package:flutter/material.dart';

class SmallScreenDrawer extends StatelessWidget {
  const SmallScreenDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: DogFoodAppTheme.themeBrownColor,
            ),
            child: Text('Menu', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            title: const Text('Cart'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CheckoutScreen(),
                ),
              );
            },
          ),
          ExpansionTile(
            title: const Text('Dog Food'),
            children: [
              ListTile(
                title: const Text('Dry Food'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: const Text('Wet Food'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: const Text('Snacks'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('Our Story'),
            children: [
              ListTile(
                title: const Text('About Us'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: const Text('Our Values'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: const Text('Team'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('Contact Us'),
            children: [
              ListTile(
                title: const Text('Email'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: const Text('Phone'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: const Text('Location'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}