import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Bookings%20Page/bookings_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Favorites%20Page/favourites_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Hompage/home_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Profile%20Page/profile_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Search%20Page/search_screen.dart';
import 'package:provider/provider.dart';

class CustomUserBottomNavigationBar extends StatelessWidget {
  CustomUserBottomNavigationBar({required this.currentIndex});

  final int currentIndex;

  final screens = [
    HomeScreen(),
    SearchScreen(),
    BookingsScreen(),
    FavouritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: primaryColor,
      selectedIconTheme: IconThemeData(size: 34),
      iconSize: 22,
      currentIndex: currentIndex,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.yellow.shade800,
      onTap: (index) => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => screens[index],
          ),
        ),
      },
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
          label: "Favoruites",
        ),
        BottomNavigationBarItem(
          icon: Consumer<Auth>(
            builder: (context, auth, child) => auth.isAuth
                ? CircleAvatar(
                    radius: currentIndex == 4 ? 17.0 : 11.0,
                    backgroundImage: NetworkImage(
                      'https://$domainName/${auth.user!["profileImage"]}',
                    ),
                  )
                : Icon(
                    Icons.person,
                  ),
          ),
          label: "Profile",
        ),
      ],
    );
  }
}
