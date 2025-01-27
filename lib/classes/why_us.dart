import 'package:dog_food/constants/constants.dart';
import 'package:flutter/material.dart';

class WhyUs extends StatefulWidget {
  const WhyUs({super.key});

  @override
  _WhyUsState createState() => _WhyUsState();
}

class _WhyUsState extends State<WhyUs> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: verticalPadding16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Why Choose Paws Kenya?",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          verticalMargin8,
          Text(
            "Dogs are family. At Paws Kenya, we craft premium meals and treats to keep them happy and healthy. It's not just pet food - it's about the bond you share.",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          verticalMargin16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildImageCard(
                context,
                "assets/assets/images/real-meat.png",
                "Crafted with real meat and",
                "natural ingredients",
              ),
              _buildImageCard(
                context,
                "assets/assets/images/affordable.png",
                "Affordable prices without",
                "compromising quality",
              ),
              _buildImageCard(
                context,
                "assets/assets/images/formulas.png",
                "Tailored formulas for every life stage",
                "life stage",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(
      BuildContext context, String imagePath, String title, String subtitle) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        ),
        verticalMargin8,
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
