import 'dart:convert';
import 'package:http/http.dart' as http;

class CommunityService {
  Map<String , String> videoMetaData = {'title': '', 'author_name': '','author_url': ''};

  Future<void> getVideoMetaData(String videoId) async {
    try {
      if(videoMetaData['title']!='') return;
      String url = 'https://www.youtube.com/oembed?url=https://www.youtube.com/shorts/$videoId&format=json';

      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);

        // Extract required fields: title, authorName, authorUrl
        videoMetaData['title'] = jsonData['title'];
        videoMetaData['author_name'] = jsonData['author_name'];
        videoMetaData['author_url'] = jsonData['author_url'];

      } else {
        // If the request is not successful, throw an error
        throw Exception('Failed to load data, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

