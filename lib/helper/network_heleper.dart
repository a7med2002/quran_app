import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/utils/api_urls.dart';

class NetworkHeleper {
  Future<Image> getSurahImageData(int pageNumber) async {
    http.Response response = await http.get(
      Uri.parse("$baseUrlImage/{00$pageNumber}.png"),
      // https://api.alquran.cloud/v1/page/$pageNumber/quran-uthmani?offset=2&limit=2
    );
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return body;
      // List<dynamic> ayahs = body['data']['ayahs'];
      // return ayahs;
    }
    return Future.error("Error in Fetch Data");
  }

  Future<Map<String, dynamic>> fetchAllSurahData() async {
    http.Response response = await http.get(Uri.parse(badseUrlAllSurahs));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return Future.error("Error fetching All Surah");
  }

  // Future<List<int>> fetchSurahPages(int surahPages) async {
  //   var response = await http.get(Uri.parse(baseSurahDataApi + "$surahPages"));
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> responseBody = jsonDecode(response.body);
  //     return responseBody['chapter']['pages'];
  //   }
  //   return Future.error("Error Fetch surah pages");
  // }

  Future<List<int>> fetchSurahPages(int surahNumber) async {
    try {
      final response = await http.get(
        Uri.parse("$baseSurahDataApi$surahNumber"),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        final chapter = responseBody['chapter'];
        if (chapter != null && chapter['pages'] != null) {
          final List<dynamic> rawPages = chapter['pages'];
          final List<int> pages = rawPages
              .map((e) => int.parse(e.toString()))
              .toList();
          print("Pages for surah $surahNumber: $pages");
          return pages;
        } else {
          throw Exception("Missing 'pages' in chapter data");
        }
      } else {
        throw Exception("Failed with status code ${response.statusCode}");
      }
    } catch (e) {
      return Future.error("Exception: $e");
    }
  }

  Future<List<dynamic>> searchAyah(String query) async {
    try {
      final response = await http.get(Uri.parse(baseSearchApi + query));
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List<dynamic> result =
            responseBody["search"]["results"];
        return result;
      } else {
        throw Exception("Failed with status code ${response.statusCode}");
      }
    } catch (e) {
      return Future.error("Exception: $e");
    }
  }
}
