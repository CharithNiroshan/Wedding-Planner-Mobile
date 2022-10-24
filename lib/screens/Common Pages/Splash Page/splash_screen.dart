import 'package:flutter/material.dart';
import 'package:magula_mobile/screens/Common%20Pages/Splash%20Page/components/body.dart';
import 'package:magula_mobile/size_config.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
