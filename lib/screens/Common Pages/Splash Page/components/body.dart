import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/Other%20Widgets/default_button.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Hompage/home_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/customer_tabs_screen.dart';
import 'package:magula_mobile/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/splash_content.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to MagulaLK, Let’s Explore!",
      "image": "assets/images/splash_1.png"
    },
    {
      "text": "We help you to find the best vendors",
      "image": "assets/images/splash_2.png"
    },
    {
      "text":
          "We show the easy way to Plan you Wedding. \nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];

  _storeOnBoardInfo() async {
    int hasVisited = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("onBoard", hasVisited);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        _storeOnBoardInfo();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomerTabsScreen()));
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: animationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? secondaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
