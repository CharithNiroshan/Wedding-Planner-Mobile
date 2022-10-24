import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Profile%20Settings/settings_screen_01.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Profile%20Settings/settings_screen_02.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Profile%20Settings/settings_screen_03.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Profile%20Settings/settings_screen_04.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Profile%20Settings/settings_screen_05.dart';

class SettingsScreen extends StatelessWidget {
  final itemsList = [
    "Basic Details",
    "Contact Details",
    "Services",
    "Packages",
    "Gallery",
  ];

  final tabContent = [
    SettingsScreen01(),
    SettingsScreen02(),
    SettingsScreen03(),
    SettingsScreen04(),
    SettingsScreen05(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Settings",
        ),
      ),
      body: DefaultTabController(
        length: 5,
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
