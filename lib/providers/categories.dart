import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:magula_mobile/models/category.dart';

class Categories with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories {
    return [..._categories];
  }

  Future<void> fetchAndSetCategories() async {
    try {
      final response = await http.get(
        Uri.https(
          domainName,
          "/categories/get-categories",
        ),
      );

      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<Category> categories = [];
      final categoryData = data["categories"] as List;

      categoryData.forEach((category) {
        return categories.add(
          Category(
            id: category["_id"],
            imgSrc: 'https://$domainName/${category["image"]}',
            title: category["title"],
            services: category["services"],
          ),
        );
      });
      _categories = categories;
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }
}
