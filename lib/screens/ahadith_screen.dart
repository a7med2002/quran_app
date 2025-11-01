import 'package:flutter/material.dart';
import 'package:quran_app/helper/link.dart';
import 'package:quran_app/utils/constants.dart';

class AhadithScreen extends StatelessWidget {
  const AhadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Link link = Link();
    return Scaffold(
      backgroundColor: secondaryColor,

      appBar: AppBar(
        title: Text("أحاديث صحيحة", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: FutureBuilder(
          future: link.loadAhadith(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
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
                          snapshot.data![index].content,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data![index].narrator,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  snapshot.data![index].reference,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
