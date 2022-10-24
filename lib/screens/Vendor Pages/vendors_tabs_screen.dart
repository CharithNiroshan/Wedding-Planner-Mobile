import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/Other%20Widgets/app_bar.dart';
import 'package:magula_mobile/Components/Other%20Widgets/app_drawer.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Booking%20Details/booking_details.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Booking%20Requests%20Page/booking_requests_screen.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Widgets/vendor_app_drawer.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/vendor_homepage_screen.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/vendor_profile_screen.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/schedule_screen.dart';
import 'package:provider/provider.dart';

class VendorTabsScreen extends StatefulWidget {
  const VendorTabsScreen();

  @override
  State<VendorTabsScreen> createState() => _VendorTabsScreenState();
}

class _VendorTabsScreenState extends State<VendorTabsScreen> {
  final List<Map<String, Object>> _pages = [
    {
      "title": "MagulaLK",
      "page": VendorHomeSccreen(),
    },
    {
      "title": "Schedule",
      "page": ScheduleScreen(),
    },
    {
      "title": "Requests",
      "page": BookingRequestsScreen(),
    },
    {
      "title": "Profile",
      "page": VendorProfileScreen(),
    },
  ];

  int _currentIndex = 0;

  void _onSelectPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: Text("${_pages[_currentIndex]["title"] as String}")),
      body: _pages[_currentIndex]["page"] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primaryColor,
        onTap: _onSelectPage,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(
          size: 34,
        ),
        iconSize: 22,
        selectedItemColor: Colors.yellow.shade800,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
            ),
            label: "Schedule",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark,
            ),
            label: "Requests",
          ),
          BottomNavigationBarItem(
            icon: Consumer<Auth>(
              builder: (context, auth, child) => auth.isAuth
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://$domainName/${auth.user!["logo"]}',
                      ),
                    )
                  : Icon(
                      Icons.person,
                    ),
            ),
            label: "Profile",
          )
        ],
      ),
      drawer: VendorDrawer(),
    );
  }
}
