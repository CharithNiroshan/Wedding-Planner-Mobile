import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Categories%20Page/categories_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Hompage/home_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Profile%20Page/profile_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Search%20Page/search_screen.dart';
import 'package:provider/provider.dart';

class UserBottomNavigationBar extends StatefulWidget {
  @override
  State<UserBottomNavigationBar> createState() =>
      _UserBottomNavigationBarState();
}

class _UserBottomNavigationBarState extends State<UserBottomNavigationBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.grey.shade600,
          ),
        ],
        color: primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BottomNavItem(
            icon: Icon(
              Icons.home,
              color: currentIndex == 0 ? Colors.yellow.shade800 : Colors.white,
              size: currentIndex == 0 ? 35 : 25,
            ),
            onTap: () {
              setState(() {
                currentIndex = 0;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
            isActive: currentIndex == 0,
          ),
          BottomNavItem(
            icon: Icon(
              Icons.explore,
              color: currentIndex == 1 ? Colors.yellow.shade800 : Colors.white,
              size: currentIndex == 1 ? 35 : 25,
            ),
            onTap: () {
              setState(() {
                currentIndex = 1;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
            isActive: currentIndex == 1,
          ),
          BottomNavItem(
            icon: Icon(
              Icons.category,
              color: currentIndex == 2 ? Colors.yellow.shade800 : Colors.white,
              size: currentIndex == 2 ? 35 : 25,
            ),
            onTap: () {
              currentIndex = 2;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesScreen(),
                ),
              );
            },
            isActive: currentIndex == 2,
          ),
          Consumer<Auth>(
            builder: (context, value, child) => value.isAuth
                ? BottomNavItem(
                    icon: CircleAvatar(
                      radius: currentIndex == 3 ? 25 : 15,
                      backgroundImage: NetworkImage(
                        'https://$domainName/${value.user!["profileImage"]}',
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        currentIndex = 3;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      );
                    },
                    isActive: currentIndex == 3,
                  )
                : BottomNavItem(
                    icon: Icon(
                      Icons.person,
                      color: currentIndex == 3
                          ? Colors.yellow.shade800
                          : Colors.white,
                      size: currentIndex == 3 ? 35 : 25,
                    ),
                    onTap: () {
                      setState(() {
                        currentIndex = 3;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      );
                    },
                    isActive: currentIndex == 3,
                  ),
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  BottomNavItem({
    required this.icon,
    required this.onTap,
    required this.isActive,
  });
  final Widget icon;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: icon,
      ),
    );
  }
}
