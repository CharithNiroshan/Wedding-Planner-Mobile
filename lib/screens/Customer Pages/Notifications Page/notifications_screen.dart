import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/Other%20Widgets/not_auth_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Notifications%20Page/Components/app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: notificationsAppBar(context),
      body: NotAuthScreen(),
    );
  }
}
