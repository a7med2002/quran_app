import 'package:flutter/material.dart';
import 'package:quran_app/utils/constants.dart';

class CustomResultSearchCard extends StatelessWidget {
  final String text;
  const CustomResultSearchCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primaryColor.withOpacity(0.7),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          "\" $text \"",
          style: TextStyle(color: Colors.white, fontSize: 16, height: 2),
        ),
      ),
    );
  }
}
