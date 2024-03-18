import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommunityDataProvider extends ChangeNotifier {
  Map<String, List<String>> sectionItemID = {'super searches': [],'the dress shop': [], 'style hacks': [], 'budget buys':[], 'ethnic looks':[], 'popular brands':[]};
  Map<String, List<String>> sectionImages = {'super searches': [],'the dress shop': [], 'style hacks': [], 'budget buys':[], 'ethnic looks':[], 'popular brands':[]};
  Map<String, bool> sectionLoadingStates = {'super searches': true ,'the dress shop': true, 'style hacks': true, 'budget buys':true, 'ethnic looks':true, 'popular brands':true, 'posts':true};

  Future<void> fetchData() async {

    var jsonData = await http.get(
      Uri.parse("http://35.208.97.167:3000/api/community-hub/getSuperSearches"),
    );
    Map<String, dynamic> parsedData = jsonDecode(jsonData.body);

    parsedData['data'].forEach((item) {
      sectionItemID['super searches']!.add(item['item']);
      sectionImages['super searches']!.add(item['image']);
    });

    sectionLoadingStates['super searches'] = false;

    //other sections
    jsonData = await http.get(
      Uri.parse("http://35.208.97.167:3000/api/community-hub/getPostsInit"),
    );
    parsedData = jsonDecode(jsonData.body);

    Map<String, dynamic> data = parsedData['data'];
    data.forEach((section, items) {
      List<dynamic> sectionItems = items;

      for (var item in sectionItems) {
        String itemId = item['item'];
        String itemImage = item['image'];
        sectionItemID[section]!.add(itemId);
        sectionImages[section]!.add(itemImage);
      }

      sectionLoadingStates[section] = false;
    });

    //popular brands
    jsonData = await http.get(
      Uri.parse("http://35.208.97.167:3000/api/community-hub/getPopularBrands"),
    );
    parsedData = jsonDecode(jsonData.body);

    parsedData['data'].forEach((item) {
      sectionItemID['popular brands']!.add(item['item']);
      sectionImages['popular brands']!.add(item['image']);
    });

    sectionLoadingStates['popular brands'] = false;
    notifyListeners();
  }

  Future<void> loadMoreItems(String section) async {
    if (sectionLoadingStates[section] == true) return; 

    sectionLoadingStates[section] = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    List<String> newItems = [
      'New Item 1 for $section',
      'New Item 2 for $section',
      'New Item 3 for $section',
    ];

    // Generate corresponding images for new items
    List<String> newImages = [
      'https://5.imimg.com/data5/YC/CN/MY-19885899/go-tex-5202a.jpg',
      'https://th.bing.com/th/id/OIP.yD6zqOzqpXZsGwT4JINAGQHaJ4?rs=1&pid=ImgDetMain',
      'https://th.bing.com/th/id/OIP.8eXBJv2JDvegBQkcx49yyQHaJQ?rs=1&pid=ImgDetMain',
    ];

    // Append new items and images to the existing lists for the specific section
    sectionItemID[section]!.addAll(newItems);
    sectionImages[section]!.addAll(newImages);

    // Set loading indicator to false for the specific section
    sectionLoadingStates[section] = false;
    notifyListeners();
  }

  Future<void> loadCommunityPosts() async{
    await Future.delayed(const Duration(seconds: 1));
    sectionLoadingStates['posts'] = false;
    notifyListeners();
  }
}
