import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/helper/network_heleper.dart';
import 'package:quran_app/model/hadith.dart';
import 'package:quran_app/model/surah.dart';
import 'package:quran_app/model/theker.dart';
import 'package:quran_app/utils/api_urls.dart';

class Link {
  NetworkHeleper networkHeleper = NetworkHeleper();

  Future<List<Surah>> getSurahList() async {
    List<Surah> allSurah = [];
    Map<String, dynamic> data = await networkHeleper.fetchAllSurahData();
    for (var i = 0; i < 114; ++i) {
      allSurah.add(
        Surah(
          name: data['data']['surahs']['references'][i]['name'],
          isMadania:
              data['data']['surahs']['references'][i]['revelationType'] ==
              "Medinan",
          numberOfAyahs:
              data['data']['surahs']['references'][i]['numberOfAyahs'],
        ),
      );
    }
    return allSurah;
  }

  Future<List<NetworkImage>> getSurahImages(int surahNumber) async {
    List<NetworkImage> images = [];
    List<int> pages = await networkHeleper.fetchSurahPages(surahNumber);
    for (var i = pages[0]; i <= pages[1]; ++i) {
      print("$baseUrlImage/${getQuranPageNumberFormat(i)}.png");
      images.add(
        NetworkImage("$baseUrlImage/${getQuranPageNumberFormat(i)}.png"),
      );
    }
    return images;
  }

  String getQuranPageNumberFormat(int pageNumber) {
    String formattedNumber = pageNumber < 10
        ? '00$pageNumber'
        : pageNumber < 100
        ? '0$pageNumber'
        : '$pageNumber';
    return formattedNumber;
  }

  Future<List<Theker>> loadAzkar() async {
    List<Theker> azkar = [];
    final jsonString = await rootBundle.loadString("assets/athkar/azkar.json");
    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    data.forEach((category, list) {
      for (var item in list) {
        azkar.add(
          Theker(
            category: category,
            content: item['content'] ?? "",
            count: item['count'] ?? "",
          ),
        );
      }
    });
    return azkar;
  }

  Future<List<Hadith>> loadAhadith() async {
    List<Hadith> ahadith = [];
    final jsonString = await rootBundle.loadString("assets/hadith/hadith.json");
    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    data.forEach((key, list) {
      for (var element in list) {
        ahadith.add(
          Hadith(
            category: element['category'] ?? "",
            content: element['content'] ?? "",
            narrator: element['narrator'] ?? "",
            reference: element['reference'] ?? "",
          ),
        );
      }
    });
    return ahadith;
  }

  Future<List<String>> loadSearchData(String query) async {
    List<String> searchData = [];
    final data = await networkHeleper.searchAyah(query);
    for (var result in data) {
      searchData.add(result['text']);
    }
    return searchData;
  }
}
