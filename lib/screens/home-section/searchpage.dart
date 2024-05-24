import 'dart:convert';
// import 'package:fuzzy/fuzzy.dart';
// import 'package:faszen/product_page/product_page.dart';
import 'package:faszen/screens/home-section/searchdisplay.dart';
import 'package:flutter/material.dart';
// import '../product_page/productcarddetails.dart';

class SearchBarPage extends StatefulWidget {
  const SearchBarPage({super.key});

  @override
  State<SearchBarPage> createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredProductCardDetails = [];
  List<String> popularsearches = [
    "Saree",
    "Lehengas",
    "T-Shirt",
    "Palazzo",
    "Blouse",
    "Kurti",
    "Bangle",
    "Night Wear",
    "Earring",
    "Shoes",
    "Kids",
    "Watches",
    "Shorts",
    "Over-sized",
    "Jeans",
    "Desi Wear"
  ];
  int currentPopularChoiceIndex = 0;
  final searchFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300),() {
      FocusScope.of(context).requestFocus(searchFocusNode);
    });
    
  }


  bool stringToBool(String value) {
    return value.toLowerCase() == 'true';
  }

  void handleSubmit(String value) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchDisplayPage(
                  keyword: value,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: TextFormField(
                      focusNode: searchFocusNode,
                      controller: searchController,
                      onChanged: (value) {
                        // searchItems(value);
                      },
                      onFieldSubmitted: handleSubmit,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Color(0xFFBABABA),
                          ),
                        ),
                        labelStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFFBABABA),
                        ),
                        labelText: "Search by keyword or Product ID",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset('assets/search.png',
                                  height: 30, width: 30),
                            ],
                          ),
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 60.0, // Height equal to TextFormField
                              width: 1.0, // Full width
                              color: const Color(
                                  0xFFBABABA), // Color of the lin // Adjust margin as needed
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Image.asset('assets/mic.png',
                                  height: 25, width: 25),
                            ),
                            const SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Image.asset('assets/camera.png',
                                  height: 25, width: 25),
                            ),
                            const SizedBox(width: 5),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 38),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Text(
                "POPULAR SEARCHES",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 5,
              children: [
                ...popularsearches
                    .asMap()
                    .entries
                    .map((entry) => GestureDetector(
                          onTap: () {
                            setState(() {
                              currentPopularChoiceIndex = entry.key;
                            });
                          },
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchDisplayPage(
                                          keyword: entry.value.toString()))),
                            },
                            child: Chip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              label: Text(
                                entry.value,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: currentPopularChoiceIndex == entry.key
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              backgroundColor:
                                  currentPopularChoiceIndex == entry.key
                                      ? Colors.black
                                      : const Color(0xFFF8F9FE),
                            ),
                          ),
                        ))
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}