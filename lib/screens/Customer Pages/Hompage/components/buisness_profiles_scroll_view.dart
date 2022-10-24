import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/Other%20Widgets/buisness_profile_card2.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/buisnessprofiles.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Buisness%20Profile%20Page/buisnessprofile_screen.dart';
import 'package:provider/provider.dart';

class BuisnessProfilesHorizontalScrollView extends StatelessWidget {
  BuisnessProfilesHorizontalScrollView({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final buisnessProfiles =
        Provider.of<BuisnessProfiles>(context, listen: false).items;

    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
            top: 20,
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: size.width * 0.04,
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buisnessProfiles
                      .map((item) => BuisnessProfileCard2(
                          title: item.title,
                          logoSrc: item.logo,
                          coverPhotoSrc: item.coverPhoto,
                          category: item.category,
                          numOfReviews: item.noOfReviews,
                          rating: item.rating,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BuisnessProfileScreen(
                                          id: item.id,
                                        )));
                          }))
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
