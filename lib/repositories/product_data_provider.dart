import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

class ProductDataProvider extends ChangeNotifier {
  List<Map<String, dynamic>> productList = [];
  List<Map<String, dynamic>> allproductList = [];
  List<Map<String, dynamic>> allproducts = [];
  List<Map<String, dynamic>> fuzzysearchedproducts = [];
  bool isLoading = true;

  Future<void> fetchData(String productName) async {
    try {
      var response = await http.post(
          Uri.parse('http://35.208.97.167:3000/api/products/bytags'),
          body: {"tags": productName});

      // Check the status code
      if (response.statusCode == 200) {
        // Parse the JSON response
        var parsedData = jsonDecode(response.body);

        // Extract the products array
        var products = parsedData['products'];

        // Clear the productList before adding new items
        productList.clear();

        // Add each product to the productList
        for (var product in products) {
          var productMap = Map<String, dynamic>.from(product);

          // Ensure 'model3D' and 'arLensID' are not null
          productMap['model3D'] = productMap['model3D']?.toString() ?? '';
          productMap['arLensID'] = productMap['arLensID']?.toString() ?? '';

          productList.add(productMap);
        }
      } else {
        productList.clear();
      }
    } catch (e) {
      productList.clear();
    } finally {
      isLoading = false;

      // Notify listeners
      notifyListeners();
    }
  }

  Future<void> fetchDataAllAndFilter(List<String> similarproductids) async {
    try {
      var response = await http
          .get(Uri.parse('http://35.208.97.167:3000/api/products/getAll'));

      // Check the status code
      if (response.statusCode == 200) {
        // Parse the JSON response
        var parsedData = jsonDecode(response.body);

        // Extract the products array
        var products = parsedData['products'];

        // Clear the productList before adding new items
        allproductList.clear();

        // Add each product to the productList
        for (var product in products) {
          var productMap = Map<String, dynamic>.from(product);
          if (similarproductids.contains(product['id'])) {
            // Ensure 'model3D' and 'arLensID' are not null
            productMap['model3D'] = productMap['model3D']?.toString() ?? '';
            productMap['arLensID'] = productMap['arLensID']?.toString() ?? '';
            // productMap['sizes'] = productMap['sizes'] ?? [];
            // productMap['similarProducts'] = productMap['similarProducts'] ?? [];
            // productMap['variants'] = productMap['variants'] ?? [];
            allproductList.add(productMap);
          }
        }
      } else {
        allproductList.clear();
      }
    } catch (e) {
      allproductList.clear();
    } finally {
      isLoading = false;
      // Notify listeners
      notifyListeners();
    }
  }

  Future<void> fetchAllData() async {
    try {
      var response = await http
          .get(Uri.parse('http://35.208.97.167:3000/api/products/home'));

      // Check the status code
      if (response.statusCode == 200) {
        // Parse the JSON response
        var parsedData = jsonDecode(response.body);

        // Extract the products array
        var products = parsedData['products'];

        // Clear the productList before adding new items
        allproducts.clear();

        // Add each product to the productList
        for (var product in products) {
          var productMap = Map<String, dynamic>.from(product);
          // Ensure 'model3D' and 'arLensID' are not null
          productMap['model3D'] = productMap['model3D']?.toString() ?? '';
          productMap['arLensID'] = productMap['arLensID']?.toString() ?? '';
          // productMap['sizes'] = productMap['sizes'] ?? [];
          // productMap['similarProducts'] = productMap['similarProducts'] ?? [];
          // productMap['variants'] = productMap['variants'] ?? [];
          allproducts.add(productMap);
        }
      } else {
        allproducts.clear();
      }
    } catch (e) {
      allproducts.clear();
    } finally {
      isLoading = false;
      // Notify listeners
      notifyListeners();
    }
  }

  Future<void> fetchDataWithFuzzySearch(String keyword) async {
    try {
      var response = await http
          .get(Uri.parse('http://35.208.97.167:3000/api/products/getAll'));
      // Check the status code
      if (response.statusCode == 200) {
        // Parse the JSON response
        var parsedData = jsonDecode(response.body);

        // Extract the products array
        var products = parsedData['products'];

        // Clear the productList before adding new items
        fuzzysearchedproducts.clear();

        // Add each product to the productList
        for (var product in products) {
          var productMap = Map<String, dynamic>.from(product);
          List<String> tags = List<String>.from(productMap['tags']);
          for (int i = 0; i < tags.length; i++) {
            if (ratio(tags[i], keyword) >= 50) {
              productMap['model3D'] = productMap['model3D']?.toString() ?? '';
              productMap['arLensID'] = productMap['arLensID']?.toString() ?? '';
              fuzzysearchedproducts.add(productMap);
              break;
            }
          }
        }
      } else {
        fuzzysearchedproducts.clear();
      }
    } catch (e) {
      allproducts.clear();
    } finally {
      isLoading = false;
      // Notify listeners
      notifyListeners();
    }
  }
}