import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quran_app/helper/link.dart';
import 'package:quran_app/utils/constants.dart';
import 'package:quran_app/widgets/custom_result_search_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  Link link = Link();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                textInputAction: TextInputAction.done,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: primaryColor.withOpacity(0.7),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "ابحث عن آية ..",
                  hintStyle: TextStyle(color: Colors.grey[200]),
                ),
                onSubmitted: (value) {
                  setState(() {
                    link.loadSearchData(value);
                  });
                },
              ),
              SizedBox(height: 16),
              if (searchController.text.isNotEmpty)
                FutureBuilder(
                  future: link.loadSearchData(searchController.text),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                        child: Center(
                          child: Lottie.asset(
                            "assets/animations/quran.json",
                            fit: BoxFit.cover,
                            width: 170,
                            height: 170,
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData) {
                      return Center(child: Text("لا يوجد نتائج بحث"));
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return Expanded(
                        child: ListView.separated(
                          itemCount: snapshot.data!.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8),
                          itemBuilder: (context, index) =>
                              CustomResultSearchCard(
                                text: snapshot.data![index],
                              ),
                        ),
                      );
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
