import 'package:flutter/material.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/components/buisnessprofile_info.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/components/cover_image.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            CoverImage(
              imgSrc: "assets/images/homepage-background.jpg",
            ),
            BuisnessProfileInfo(),
          ],
        ),
      ),
    );
  }
}
