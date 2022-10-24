import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Notifications%20Page/notifications_screen.dart';

AppBar appBar(BuildContext context) {
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
            text: "Magula",
            style: TextStyle(
              color: Colors.yellow.shade800,
            ),
          ),
          TextSpan(
            text: "LK",
            style: TextStyle(
              color: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NotificationsScreen()));
        },
        icon: Icon(
          Icons.notifications,
        ),
      ),
    ],
  );
}
