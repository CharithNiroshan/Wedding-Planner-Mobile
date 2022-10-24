import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/Other%20Widgets/Usercard.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignIn%20Page/sign_in_screen.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Categories%20Page/categories_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Hompage/home_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<Auth>(
        builder: (context, auth, child) => auth.isAuth
            ? AuthUserDrawer(
                title: auth.user!["fullName"],
                subtitle: auth.user!["email"],
                imgSrc: auth.user!["profileImage"],
              )
            : GuestDrawer(),
      ),
    );
  }
}

class AuthUserDrawer extends StatelessWidget {
  const AuthUserDrawer({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imgSrc,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final String? imgSrc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          UserCard(),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Home'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('My Bookings'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.edit), title: Text('Profile'), onTap: () {}),
          Divider(),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text('Log Out'),
            onTap: () {
              Navigator.of(context).pushNamed(SignUpScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}

class GuestDrawer extends StatelessWidget {
  const GuestDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage("assets/images/logo.jpeg"),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Text(
                "Welcome ",
                style: TextStyle(
                  color: textPrimaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "MagulaLK",
                style: TextStyle(
                  color: textSecondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Categories'),
            onTap: () {
              Navigator.pushNamed(context, CategoriesScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text('Register'),
            onTap: () {
              Navigator.of(context).pushNamed(SignUpScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Sign In'),
            onTap: () {
              Navigator.of(context).pushNamed(SignInScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
