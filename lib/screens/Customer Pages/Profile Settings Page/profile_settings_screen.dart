import 'package:flutter/material.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Profile%20Settings%20Page/Components/app_bar.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Profile%20Settings%20Page/Components/body.dart';

class ProfileSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileSettingsAppBar(context),
      body: Body(),
    );
  }
}
