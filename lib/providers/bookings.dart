import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:magula_mobile/models/booking.dart';
import 'package:magula_mobile/models/package.dart';
import 'package:magula_mobile/models/user.dart';

class Bookings with ChangeNotifier {
  List<Booking>? _bookings = [];

  Booking? _booking;

  List<Booking> get bookings {
    return [..._bookings!];
  }

  Booking? get booking {
    return _booking;
  }

  Future<void> fetchAndSetBookings(String userId) async {
    try {
      final response = await http.get(
        Uri.http(
          domainName,
          "/booking/$userId",
        ),
      );

      final data = json.decode(response.body) as Map<String, dynamic>;

      final List<Booking> bookings = [];

      final bookingsData = data["data"] as List<dynamic>;

      bookingsData.forEach(
        (booking) {
          return bookings.add(
            Booking(
              id: booking["_id"],
              user: User(
                id: booking["user"]["_id"],
                profileImage: booking["user"]["profileImage"],
                fullName: booking["user"]["fullName"],
                displayName: booking["user"]["displayName"],
                email: booking["user"]["email"],
                contactNo: booking["user"]["contactNo"],
                weddingDate: booking["user"]["weddingDate"],
              ),
              buisnessProfile: BuisnessProfile(
                  id: booking["buisnessProfile"]["_id"],
                  title: booking["buisnessProfile"]["title"],
                  logo: booking["buisnessProfile"]["logo"],
                  accountCategory: booking["buisnessProfile"]
                      ["accountCategory"],
                  address: booking["buisnessProfile"]["address"],
                  contactNo: booking["buisnessProfile"]["contactNo"],
                  email: booking["buisnessProfile"]["email"]),
              bookingType: booking["bookingType"],
              package: booking["bookingType"] == "Package Booking"
                  ? Package(
                      id: booking["bookingPackage"]["_id"],
                      title: booking["bookingPackage"]["title"],
                      description: booking["bookingPackage"]["description"],
                      image: booking["bookingPackage"]["image"],
                      price: booking["bookingPackage"]["price"],
                    )
                  : null,
              services: booking["bookingType"] == "Custom Booking"
                  ? booking["services"]
                  : null,
              extraInfo: booking["extraInfo"],
              bookingDate: booking["bookingDate"],
              date: booking["date"],
              isRejected: booking["isRejected"],
            ),
          );
        },
      );

      _bookings = bookings;
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Future<void> fetchAndSetBooking(String id) async {
    try {
      final response = await http.get(
        Uri.http(
          domainName,
          "/booking/find/$id",
        ),
      );

      final data = json.decode(response.body) as Map<String, dynamic>;

      final booking = data["data"];

      _booking = Booking(
        id: booking["_id"],
        user: User(
          id: booking["user"]["_id"],
          profileImage: booking["user"]["profileImage"],
          fullName: booking["user"]["fullName"],
          displayName: booking["user"]["displayName"],
          email: booking["user"]["email"],
          contactNo: booking["user"]["contactNo"],
          weddingDate: booking["user"]["weddingDate"],
        ),
        buisnessProfile: BuisnessProfile(
            id: booking["buisnessProfile"]["_id"],
            title: booking["buisnessProfile"]["title"],
            logo: booking["buisnessProfile"]["logo"],
            accountCategory: booking["buisnessProfile"]["accountCategory"],
            address: booking["buisnessProfile"]["address"],
            contactNo: booking["buisnessProfile"]["contactNo"],
            email: booking["buisnessProfile"]["email"]),
        bookingType: booking["bookingType"],
        package: booking["bookingType"] == "Package Booking"
            ? Package(
                id: booking["bookingPackage"]["_id"],
                title: booking["bookingPackage"]["title"],
                description: booking["bookingPackage"]["description"],
                image: booking["bookingPackage"]["image"],
                price: booking["bookingPackage"]["price"],
              )
            : null,
        services: booking["bookingType"] == "Custom Booking"
            ? booking["services"]
            : null,
        extraInfo: booking["extraInfo"],
        bookingDate: booking["bookingDate"],
        date: booking["date"],
        isRejected: booking["isRejected"],
      );
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Future<void> rejectBooking(Map<String, dynamic> formData) async {
    print("Formdata: $formData");
    try {
      final response = await http.put(
        Uri.http(
          domainName,
          "/booking/reject/${_booking!.id}",
        ),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "Ocp-Apim-Subscription-Key": "008c47b597e54aedadbd5e4d270b35ed",
          "Ocp-Apim-Trace": "true"
        },
        body: json.encode(formData),
      );

      final data = json.decode(response.body) as Map<String, dynamic>;

      print(data);
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Future<void> acceptBooking() async {
    try {
      final response = await http.put(
        Uri.http(
          domainName,
          "/booking/accept/${_booking!.id}",
        ),
      );

      final data = json.decode(response.body) as Map<String, dynamic>;

      print(data);
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }
}
