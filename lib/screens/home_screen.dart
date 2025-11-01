import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quran_app/screens/ahadith_screen.dart';
import 'package:quran_app/screens/azkar_screen.dart';
import 'package:quran_app/screens/quran_screen.dart';
import 'package:quran_app/screens/tasbih_screen.dart';
import 'package:quran_app/utils/constants.dart';
import 'package:quran_app/widgets/custom_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/animations/musim.json", width: 300),
              SizedBox(height: 20),
              Text(
                "الـقـرآن الـكـريـم",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                children: [
                  CustomCard(
                    imgPath: "assets/images/quran.png",
                    title: "القرآن الكريم",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuranScreen()),
                    ),
                  ),
                  CustomCard(
                    imgPath: "assets/images/athkar.png",
                    title: "الأذكار",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AzkarScreen()),
                    ),
                  ),
                  CustomCard(
                    imgPath: "assets/images/tasbih.png",
                    title: "المسبحة",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TasbihScreen()),
                    ),
                  ),
                  CustomCard(
                    imgPath: "assets/images/prayer.png",
                    title: "أحاديث",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AhadithScreen()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
