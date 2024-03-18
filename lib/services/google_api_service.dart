import 'package:faszen/models/chatmodel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  String baseUrl = "http://35.208.97.167:3000/api/auth/";
  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> getGoogleApiToken() async {
    final response = await http.get(Uri.parse("$baseUrl/getGoogleApiToken"));
    
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      storage.write(key: 'google-api-token', value: decoded['token']);
      storage.write(key: 'project-id', value: decoded['project-id']);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<ChatModel> queryDialogflow(String query,String sessionId) async {
    Map<String, dynamic> requestBody = {
      "queryInput": {
        "text": {
          "text": query,
          "languageCode": "en-US"
        }
      }
    };

    String? projectId = await storage.read(key: 'project-id');
    String? accessToken = await storage.read(key: 'google-api-token');

    final response = await http.post(
      Uri.parse('https://dialogflow.googleapis.com/v2/projects/$projectId/agent/sessions/$sessionId:detectIntent'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: json.encode(requestBody),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> res = json.decode(response.body);
      final String? fulfillmentText = res['queryResult']['fulfillmentText'];
      if(fulfillmentText != null){
        return ChatModel(type: 'default', isUser: false, text: fulfillmentText);
      }
      else{
        final payloadData = Map<String, dynamic>.from(res['queryResult']['webhookPayload']['null']);
        
        if(payloadData.containsKey('text_with_image')){
          return ChatModel(type: 'text_with_image', isUser: false, text: payloadData['text_with_image']['text'] , imageUrl: payloadData['text_with_image']['imageUrl']);
        }
        else if(payloadData.containsKey('text_with_button')){
          return ChatModel(type: 'text_with_button', isUser: false, text: payloadData['text_with_button']['text']);
        }
        else if(payloadData.containsKey('text_with_suggestions')){
          final List<dynamic> suggestions = payloadData['text_with_suggestions']['suggestions'];
          final List<String> stringSuggestions = suggestions.map((suggestion) => suggestion.toString()).toList();
          return ChatModel(type: 'text_with_suggestions', isUser: false, suggestions: stringSuggestions, text: payloadData['text_with_suggestions']['text'] );
        }
      }
    } else {
      throw Exception('Failed to query Dialogflow');
    }

    return ChatModel(type: 'default', isUser: false, text: 'default');
  }
}