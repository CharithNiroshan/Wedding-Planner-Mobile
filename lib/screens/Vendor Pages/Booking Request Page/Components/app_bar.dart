import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';

AppBar bookingRequestDetailsScreenAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: primaryColor,
    elevation: 0,
    title: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
        children: [
          TextSpan(
            text: "Booking Request Details",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
