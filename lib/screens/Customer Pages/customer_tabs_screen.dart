import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/Other%20Widgets/app_drawer.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Bookings%20Page/bookings_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Favorites%20Page/favourites_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Hompage/home_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Notifications%20Page/notifications_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Profile%20Page/profile_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Search%20Page/search_screen.dart';
import 'package:provider/provider.dart';

class CustomerTabsScreen extends StatefulWidget {
  const CustomerTabsScreen();

  @override
  State<CustomerTabsScreen> createState() => _CustomerTabsScreenState();
}

class _CustomerTabsScreenState extends State<CustomerTabsScreen> {
  final List<Map<String, Object>> _pages = [
    {
      "title": "MagulaLK",
      "page": HomeScreen(),
    },
    {
      "title": "Search",
      "page": SearchScreen(),
    },
    {
      "title": "Bookings",
      "page": BookingsScreen(),
    },
    {
      "title": "Favourites",
      "page": FavouritesScreen(),
    },
    {
      "title": "Profile",
      "page": ProfileScreen(),
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
        title: Text("${_pages[_currentIndex]["title"] as String}"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationsScreen()));
            },
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          )
        ],
      ),
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
              Icons.explore,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark,
            ),
            label: "Bookings",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: "Favourites",
          ),
          BottomNavigationBarItem(
            icon: Consumer<Auth>(
              builder: (context, auth, child) => auth.isAuth
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://$domainName/${auth.user!["profileImage"]}',
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
      drawer: AppDrawer(),
    );
  }
}
