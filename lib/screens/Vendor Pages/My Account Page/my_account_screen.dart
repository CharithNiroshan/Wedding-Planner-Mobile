import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/My%20Account%20Page/Widgets/basic_details.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/My%20Account%20Page/Widgets/contact_details.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/My%20Account%20Page/Widgets/gallery_field.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/My%20Account%20Page/Widgets/packages.dart';

class MyAccount extends StatelessWidget {
  final itemsList = [
    "Basic Details",
    "Other Details",
    "Packages",
    "Gallery",
  ];

  final tabContent = [
    BasicDetailsScreen(),
    ContactDetailsScreen(),
    PackagesFieldScreen(),
    GalleryFieldScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "My Account",
        ),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            Container(
              child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey.shade600,
                unselectedLabelStyle: TextStyle(
                  fontSize: 12,
                ),
                isScrollable: true,
                indicatorColor: secondaryColor,
                tabs: itemsList
                    .map((item) => Tab(
                          text: item,
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: TabBarView(
                children: tabContent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
