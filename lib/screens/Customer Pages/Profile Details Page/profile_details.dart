import 'package:flutter/material.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Profile%20Details%20Page/Components/app_bar.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Profile%20Details%20Page/Components/body.dart';

class ProfileDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileDetailsAppBar(context),
      body: Body(),
    );
  }
}
