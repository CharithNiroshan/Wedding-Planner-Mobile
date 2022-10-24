import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/models/buisness_profile_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BuisnessProfiles with ChangeNotifier {
  List<BuisnessProfileCard> _buisnessProfiles = [];

  List<BuisnessProfileCard> get items {
    return [..._buisnessProfiles];
  }

  BuisnessProfileCard findById(String title) {
    return _buisnessProfiles
        .firstWhere((buisnessProfile) => buisnessProfile.title == title);
  }

  Future<void> fetchAndSetBuisnessProfiles() async {
    try {
      final response = await http.get(
        Uri.http(
          domainName,
          "/buisnessprofile",
        ),
      );

      final data = json.decode(response.body) as Map<String, dynamic>;

      final List<BuisnessProfileCard> profiles = [];
      final bsdata = data["data"] as List;

      bsdata.forEach((profile) {
        return profiles.add(
          BuisnessProfileCard(
            id: profile["_id"],
            logo: 'http://$domainName/${profile["logo"]}',
            title: profile["title"],
            category: profile["accountCategory"],
            coverPhoto: 'http://$domainName/${profile["coverPhoto"]}',
            rating: 4,
            noOfReviews: 26,
          ),
        );
      });

      _buisnessProfiles = profiles;
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Future<void> fetchAndSetBuisnessProfilesByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.https(
          domainName,
          "/buisnessprofile/categories/$category",
        ),
      );

      final data = json.decode(response.body) as Map<String, dynamic>;

      final List<BuisnessProfileCard> profiles = [];
      final bsdata = data["data"] as List;

      bsdata.forEach((profile) {
        return profiles.add(
          BuisnessProfileCard(
            id: profile["_id"],
            logo: 'http://$domainName/${profile["logo"]}',
            title: profile["title"],
            category: profile["accountCategory"],
            coverPhoto: 'http://$domainName/${profile["coverPhoto"]}',
            rating: 4,
            noOfReviews: 23,
          ),
        );
      });
      _buisnessProfiles = profiles;
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Future<void> fetchAndSetBuisnessProfilesBySearching(
      Map<String, dynamic> searchValues) async {
    try {
      final response = await http.get(
        Uri.https(
          domainName,
          "/buisnessprofile/search/${searchValues['query']}/${searchValues['district']}/${searchValues['category']}",
        ),
      );

      final data = json.decode(response.body) as Map<String, dynamic>;

      final List<BuisnessProfileCard> profiles = [];
      final bsdata = data["data"] as List;

      bsdata.forEach((profile) {
        return profiles.add(
          BuisnessProfileCard(
            id: profile["_id"],
            logo: 'http://$domainName/${profile["logo"]}',
            title: profile["title"],
            category: profile["accountCategory"],
            coverPhoto: 'http://$domainName/${profile["coverPhoto"]}',
            rating: 4,
            noOfReviews: 23,
          ),
        );
      });
      _buisnessProfiles = profiles;
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }
}
