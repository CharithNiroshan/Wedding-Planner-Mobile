import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:magula_mobile/constants.dart';
import 'dart:convert';

class BuisnessProfileProvider with ChangeNotifier {
  Map<String, dynamic> _buisnessProfile = {};

  Map<String, dynamic> get buisnessProfile {
    return _buisnessProfile;
  }

  Future<void> fetchBuisnessprofile(String? id) async {
    try {
      final response = await http.get(
        Uri.http(
          domainName,
          "/buisnessprofile/$id",
        ),
      );
      final data = json.decode(response.body);
      final error = data["error"];
      if (error != null) {
        throw error;
      }

      _buisnessProfile = data["data"] as Map<String, dynamic>;
    } catch (err) {
      throw err;
    }
    notifyListeners();
  }

  Future<void> addReview(Map<String, dynamic> formData) async {
    print("FormData : $formData , id : ${buisnessProfile["_id"]}");
    try {
      final response = await http.post(
        Uri.http(
          domainName,
          "/buisnessprofile/review/add/${buisnessProfile["_id"]}",
        ),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Ocp-Apim-Subscription-Key": "008c47b597e54aedadbd5e4d270b35ed",
          "Ocp-Apim-Trace": "true"
        },
        body: json.encode(formData),
      );
      print(json.decode(response.body));
    } catch (err) {
      throw err;
    }
    notifyListeners();
  }

  Future<void> addBooking(Map<String, dynamic> formData) async {
    formData['buisnessProfile'] = buisnessProfile;
    formData["date"] = DateFormat('dd/MM/yyyy').format(DateTime.now());
    try {
      final response = await http.post(
        Uri.http(
          domainName,
          "/booking/add",
        ),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Ocp-Apim-Subscription-Key": "008c47b597e54aedadbd5e4d270b35ed",
          "Ocp-Apim-Trace": "true"
        },
        body: json.encode(formData),
      );
      print(json.decode(response.body));
    } catch (err) {
      throw err;
    }
    notifyListeners();
  }
}
