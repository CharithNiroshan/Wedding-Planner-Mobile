import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/Other%20Widgets/Usercard.dart';
import 'package:magula_mobile/Components/Other%20Widgets/not_auth_screen.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Profile%20Details%20Page/profile_details.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Profile%20Page/Components/option_item.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Profile%20Settings%20Page/profile_settings_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, auth, child) => auth.isAuth
          ? Container(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserCard(),
                      OptionItem(
                        title: "My Account",
                        icon: Icons.person,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileDetails(),
                            ),
                          );
                        },
                      ),
                      OptionItem(
                        title: "Settings",
                        icon: Icons.settings,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileSettingScreen(),
                            ),
                          );
                        },
                      ),
                      OptionItem(
                        title: "Help Center",
                        icon: Icons.help_center,
                        onTap: () {},
                      ),
                      OptionItem(
                        title: "Log Out",
                        icon: Icons.logout,
                        onTap: () {},
                      )
                    ],
                  ),
                ),
              ),
            )
          : NotAuthScreen(),
    );
  }
}
