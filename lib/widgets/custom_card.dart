import 'package:flutter/material.dart';
import 'package:quran_app/utils/constants.dart';

class CustomCard extends StatelessWidget {
  final String imgPath;
  final String title;
  final Function() onTap;
  const CustomCard({
    super.key,
    required this.imgPath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: secondaryColor,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imgPath, width: 100, height: 100),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
