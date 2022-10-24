import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? type;
  Map<String, dynamic>? user;
  DateTime? expiryDate;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (expiryDate != null &&
        expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> signUp(
      String? email, String? password, String? accountType) async {
    try {
      final response = await http.post(
        Uri.http(
          domainName,
          "/auth/register",
        ),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Ocp-Apim-Subscription-Key": "008c47b597e54aedadbd5e4d270b35ed",
          "Ocp-Apim-Trace": "true"
        },
        body: json.encode({
          "email": email,
          "password": password,
          "accountType": accountType,
        }),
      );
      final responseData = json.decode(response.body);
      final data = responseData["data"];
      final error = responseData["error"];
      if (error != null) {
        throw HttpException(error);
      }
      _token = data["token"];
      type = data["type"];
      user = data["user"] as Map<String, dynamic>;
      expiryDate = DateTime.now().add(Duration(minutes: 30));
    } catch (err) {
      throw err;
    }
    notifyListeners();
  }

  Future<void> signIn(String? email, String? password) async {
    try {
      final response = await http.post(
        Uri.https(
          domainName,
          "/auth/signin",
        ),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Ocp-Apim-Subscription-Key": "008c47b597e54aedadbd5e4d270b35ed",
          "Ocp-Apim-Trace": "true"
        },
        body: jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      final data = responseData["data"];
      final error = responseData["error"];
      if (error != null) {
        throw HttpException(error);
      }
      _token = data["token"];
      type = data["type"];
      user = data["user"] as Map<String, dynamic>;
      expiryDate = DateTime.now().add(Duration(minutes: 30));
      print(
          '_token : $_token , type : $type , user : $user , expiryDate : $expiryDate');
    } catch (err) {
      throw err;
    }
    notifyListeners();
  }

  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.https(
          domainName,
          "/user/update-profile/${user!["_id"]}",
        ),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Ocp-Apim-Subscription-Key": "008c47b597e54aedadbd5e4d270b35ed",
          "Ocp-Apim-Trace": "true",
        },
        body: json.encode(data),
      );
      print(json.decode(response.body));
    } catch (err) {
      throw err;
    }
    notifyListeners();
  }

  Future<void> updateVendorProfile(Map<String, dynamic> data) async {
    try {
      await http.put(
        Uri.https(
          domainName,
          "/buisnessprofile/update-profile/${user!["_id"]}",
        ),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Ocp-Apim-Subscription-Key": "008c47b597e54aedadbd5e4d270b35ed",
          "Ocp-Apim-Trace": "true",
        },
        body: json.encode(data),
      );
    } catch (err) {
      throw err;
    }
    notifyListeners();
  }

  Future<void> addPackageToVendorProfile(Map<String, dynamic> data) async {
    print(data);
    try {
      await http.post(
        Uri.https(
          domainName,
          "/buisnessprofile/package/add/${user!["_id"]}",
        ),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Ocp-Apim-Subscription-Key": "008c47b597e54aedadbd5e4d270b35ed",
          "Ocp-Apim-Trace": "true",
        },
        body: json.encode(data),
      );
      print("Request Succesful");
    } catch (err) {
      throw err;
    }
    notifyListeners();
  }

  Future<void> deletePackageFromVendorProfile(String id) async {
    try {
      final response = await http.delete(
        Uri.https(
          domainName,
          "/buisnessprofile/package/delete/${user!["_id"]}",
        ),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Ocp-Apim-Subscription-Key": "008c47b597e54aedadbd5e4d270b35ed",
          "Ocp-Apim-Trace": "true",
        },
        body: json.encode({
          "_id": id,
        }),
      );
      print(json.decode(response.body));
    } catch (err) {
      throw err;
    }
    notifyListeners();
  }

  Future<void> editPackageOfVendorProfile(Map<String, dynamic> data) async {
    try {
      await http.put(
        Uri.https(
          domainName,
          "/buisnessprofile/package/edit/${user!["_id"]}",
        ),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Ocp-Apim-Subscription-Key": "008c47b597e54aedadbd5e4d270b35ed",
          "Ocp-Apim-Trace": "true",
        },
        body: json.encode(data),
      );
      print("Request Succesful");
    } catch (err) {
      throw err;
    }
    notifyListeners();
  }

  Future<void> deleteGalleryItem(String imgSrc) async {
    try {
      final response = await http.delete(
        Uri.https(
          domainName,
          "/buisnessprofile/gallery/delete/${user!["_id"]}",
        ),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Ocp-Apim-Subscription-Key": "008c47b597e54aedadbd5e4d270b35ed",
          "Ocp-Apim-Trace": "true",
        },
        body: json.encode({
          "image": imgSrc,
        }),
      );
    } catch (err) {
      throw err;
    }
    notifyListeners();
  }

  Future<void> addGalleryItem(String imgSrc) async {
    print(imgSrc);
    try {
      final response = await http.post(
        Uri.https(
          domainName,
          "/buisnessprofile/gallery/add/${user!["_id"]}",
        ),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Ocp-Apim-Subscription-Key": "008c47b597e54aedadbd5e4d270b35ed",
          "Ocp-Apim-Trace": "true",
        },
        body: json.encode({
          "image": imgSrc,
        }),
      );
      print(json.decode(response.body));
    } catch (err) {
      throw err;
    }
    notifyListeners();
  }
}
