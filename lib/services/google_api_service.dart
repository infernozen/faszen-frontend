import 'dart:math';

import 'package:faszen/models/chatmodel.dart';
import 'package:faszen/screens/profile-section/reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:faszen/models/notify.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<void> addEvent(
    String date,
    String description,
    String time,
  ) async {
    DateTime parsedDate = DateFormat('d MMMM yyyy').parse('${date} 2024');

    List<String> timeParts = time.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    TimeOfDay selectedTime = TimeOfDay(hour: hour, minute: minute);

    DateTime eventDateTime = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    MyEvents newEvent = MyEvents(
      eventTitle: "Fizards Reminder",
      eventDescription: description,
      eventTime: eventDateTime,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? eventsJson = prefs.getString('events');
    Map<String, List<MyEvents>> events = {};
    if (eventsJson != null) {
      Map<String, dynamic> decodedEvents = jsonDecode(eventsJson);
      decodedEvents.forEach((key, value) {
        List<MyEvents> eventsList =
            (value as List).map((e) => MyEvents.fromJson(e)).toList();
        events[key] = eventsList;
      });
    }

    String eventKey = DateFormat('yyyy-MM-dd').format(parsedDate);
    if (events.containsKey(eventKey)) {
      events[eventKey]?.add(newEvent);
    } else {
      events[eventKey] = [newEvent];
    }

    String updatedEventsJson = jsonEncode(events);
    await prefs.setString('events', updatedEventsJson);
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
        print(payloadData);
        
        if(payloadData.containsKey('text_with_image')){
          return ChatModel(type: 'text_with_image', isUser: false, text: payloadData['text_with_image']['text'] , imageUrl: payloadData['text_with_image']['imageUrl']);
        }
        else if(payloadData.containsKey('text_with_button')){
          return ChatModel(type: 'text_with_button', isUser: false, text: payloadData['text_with_button']['text'], destination: payloadData['text_with_button']['destination']);
        }
        else if(payloadData.containsKey('text_with_suggestions')){
          final List<dynamic> suggestions = payloadData['text_with_suggestions']['suggestions'];
          final List<String> stringSuggestions = suggestions.map((suggestion) => suggestion.toString()).toList();
          return ChatModel(type: 'text_with_suggestions', isUser: false, suggestions: stringSuggestions, text: payloadData['text_with_suggestions']['text'] );
        }
        else if(payloadData.containsKey('text_with_product')){
          Map<String, dynamic> product = payloadData['text_with_product']['product'];
          return ChatModel(type: 'text_with_product', isUser: false, imageUrl: payloadData['text_with_product']['imageUrl'], text: payloadData['text_with_product']['text'], product: product);
        }
        else if(payloadData.containsKey('set_reminder')){
          // print(payloadData);
          // print(payloadData['set_reminder']['subtitle']);
          // print(payloadData['set_reminder']['time']);
          addEvent(payloadData['set_reminder']['date'],payloadData['set_reminder']['subtitle'],payloadData['set_reminder']['time']);
          List<String> timeParts = payloadData['set_reminder']['time'].split(':');
          int hour = int.parse(timeParts[0]);
          int minute = int.parse(timeParts[1]);
          TimeOfDay selectedTime = TimeOfDay(hour: hour, minute: minute);
          DateTime parsedDate = DateFormat('d MMMM').parse(payloadData['set_reminder']['date']);
          // print(parsedDate.day);
          // print(parsedDate.month);
          // print(selectedTime.hour);
          // print(selectedTime.minute);
          Notify.scheduleNotification("Fizard's Reminder",payloadData['set_reminder']['subtitle'] ,parsedDate.day , parsedDate.month, 2024, selectedTime.hour, selectedTime.minute);
          return ChatModel(type: 'default', isUser: false, text: "Reminder added to the list");
        }
      }
    } else {
      throw Exception('Failed to query Dialogflow');
    }

    return ChatModel(type: 'default', isUser: false, text: 'default');
  }
}