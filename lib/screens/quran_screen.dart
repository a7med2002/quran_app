import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quran_app/helper/link.dart';
import 'package:quran_app/screens/search_screen.dart';
import 'package:quran_app/screens/surah_screen.dart';
import 'package:quran_app/utils/constants.dart';
import 'package:quran_app/widgets/custom_surah_tile.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _HomeQuranScreen();
}

class _HomeQuranScreen extends State<QuranScreen> {
  Link link = Link();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          "سـور الـقـرآن الكـريـم",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: secondaryColor,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: link.getSurahList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset(
                  "assets/animations/quran.json",
                  fit: BoxFit.cover,
                  width: 170,
                  height: 170,
                ),
              );
            } else if (!snapshot.hasData) {
              return Text("No Data ..");
            } else {
              return ListView.builder(
                itemCount: 114,
                itemBuilder: (context, index) => CustomSurahTile(
                  name: "${snapshot.data![index].name}",
                  ayahNumber: "${snapshot.data![index].numberOfAyahs}",
                  index: "${index + 1}",
                  isMadania: snapshot.data![index].isMadania,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurahScreen(
                        surahNumber: index + 1,
                        surahName: snapshot.data![index].name,
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
