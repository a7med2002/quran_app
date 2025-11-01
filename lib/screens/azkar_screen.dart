import 'package:flutter/material.dart';
import 'package:quran_app/helper/link.dart';
import 'package:quran_app/model/theker.dart';
import 'package:quran_app/screens/zeker_screen.dart';
import 'package:quran_app/utils/constants.dart';
import 'package:quran_app/widgets/custom_card.dart';

class AzkarScreen extends StatefulWidget {
  const AzkarScreen({super.key});

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  Link link = Link();
  final categoryName = [
    "أذكار الصباح",
    "أذكار المساء",
    "أذكار بعد السلام من الصلاة المفروضة",
    "تسابيح",
    "أذكار النوم",
    "أذكار الاستيقاظ",
    "أدعية قرآنية",
    "أدعية الأنبياء",
  ];
  final categoryImage = [
    "morning",
    "athkar",
    "salat",
    "tasbih",
    "night",
    "lantern",
    "DuaaQuran",
    "prayer",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          "الأذكار",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: link.loadAzkar(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemCount: categoryName.length,
                itemBuilder: (context, index) {
                  List<Theker> filteredAzkar = snapshot.data!
                      .where((zeker) => zeker.category == categoryName[index])
                      .toList();
                  return CustomCard(
                    imgPath: "assets/images/${categoryImage[index]}.png",
                    title: categoryName[index],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ZekerScreen(
                          azkar: filteredAzkar,
                          category: categoryName[index],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
