import 'package:magula_mobile/models/package.dart';
import 'package:magula_mobile/models/user.dart';

class Booking {
  Booking({
    required this.id,
    required this.user,
    required this.buisnessProfile,
    required this.bookingType,
    this.package,
    this.services,
    required this.extraInfo,
    required this.bookingDate,
    required this.date,
    required this.isRejected,
    this.statusMessage,
  });

  final String id;
  final User user;
  final BuisnessProfile buisnessProfile;
  final String bookingType;
  final Package? package;
  final List<dynamic>? services;
  final String extraInfo;
  final String bookingDate;
  final String date;
  final bool isRejected;
  final String? statusMessage;
}

class BuisnessProfile {
  BuisnessProfile({
    required this.id,
    required this.title,
    required this.logo,
    required this.accountCategory,
    required this.email,
    required this.contactNo,
    required this.address,
  });

  final String id;
  final String title;
  final String logo;
  final String accountCategory;
  final String email;
  final String contactNo;
  final String address;
}
