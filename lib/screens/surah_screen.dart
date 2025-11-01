import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quran_app/helper/link.dart';
import 'package:quran_app/utils/constants.dart';

class SurahScreen extends StatefulWidget {
  final int surahNumber;
  final String surahName;
  const SurahScreen({
    super.key,
    required this.surahNumber,
    required this.surahName,
  });

  @override
  State<SurahScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SurahScreen> {
  late String pageImage;
  Link link = Link();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(widget.surahName, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: secondaryColor,
      ),
      body: FutureBuilder(
        future: link.getSurahImages(widget.surahNumber),
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
            return Center(child: Text("No Data .."));
          } else if (snapshot.hasError) {
            return Center(child: Text("Error Fetching Surah Pages .."));
          } else {
            return PageView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Center(child: Image(image: snapshot.data![index]));
              },
            );
          }
        },
      ),
    );
  }
}
