import 'package:flutter/material.dart';
import 'package:quran_app/model/theker.dart';
import 'package:quran_app/utils/constants.dart';

class ZekerScreen extends StatelessWidget {
  final List<Theker> azkar;
  final String category;
  const ZekerScreen({super.key, required this.azkar, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        title: Text(category, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: azkar.length,
          itemBuilder: (context, index) {
            return Card(
              color: primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ListTile(
                  contentPadding: EdgeInsets.all(4),
                  leading: Text(
                    "${index + 1}",
                    style: TextStyle(color: Colors.white),
                  ),
                  title: Text(
                    azkar[index].content!,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12),
                      Text(
                        "${azkar[index].count} مرات",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
