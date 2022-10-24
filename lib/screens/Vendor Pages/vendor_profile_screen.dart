import 'package:flutter/material.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Profile%20Page/Components/option_item.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Profile%20Settings%20Page/profile_settings_screen.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/My%20Account%20Page/my_account_screen.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Settings%20Page/vendor_profile_settings_screen.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Widgets/vendor_card.dart';

class VendorProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VendorCard(),
              OptionItem(
                title: "My Account",
                icon: Icons.person,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyAccount(),
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
                      builder: (context) => SettingsScreen(),
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
    );
  }
}
