import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/buisnessprofile.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Notifications%20Page/notifications_screen.dart';
import 'package:provider/provider.dart';

AppBar packageScreenAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: primaryColor,
    elevation: 0,
    title: Consumer<BuisnessProfileProvider>(
      builder: (context, value, child) => Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
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
