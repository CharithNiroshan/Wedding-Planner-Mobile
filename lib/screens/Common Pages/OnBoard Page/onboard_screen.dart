import 'package:flutter/material.dart';
import 'dart:async';

import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Common%20Pages/Splash%20Page/splash_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Hompage/home_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/customer_tabs_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);
    return new Timer(duration, splashScreenRoute);
  }

  splashScreenRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? isVisited = prefs.getInt('onBoard');
    if (isVisited == 0) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CustomerTabsScreen()));
    } else {
      Navigator.pushNamed(context, SplashScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/logo.png",
              width: 150,
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}
