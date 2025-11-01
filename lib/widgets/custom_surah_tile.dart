import 'package:flutter/material.dart';
import 'package:quran_app/utils/constants.dart';

class CustomSurahTile extends StatelessWidget {
  final String name;
  final String ayahNumber;
  final String index;
  final bool isMadania;
  final Function() onTap;
  const CustomSurahTile({
    super.key,
    required this.name,
    required this.ayahNumber,
    required this.index,
    required this.isMadania,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: secondaryColor,
      ),
      child: ListTile(
        onTap: onTap,
        trailing: Column(
          children: [
            Text("عدد الآيات", style: TextStyle(color: Colors.white)),
            Text(
              ayahNumber,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
        title: Text(
          name,
          textAlign: TextAlign.right,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Text(
          index,
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.white),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(100),
          child: Image.asset(
            isMadania ? "assets/images/madina.png" : "assets/images/macca.png",
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
