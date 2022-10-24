import 'package:flutter/material.dart';
import 'package:magula_mobile/providers/bookings.dart';
import 'package:magula_mobile/screens/Common%20Pages/OnBoard%20Page/onboard_screen.dart';
import 'package:magula_mobile/screens/Common%20Pages/Splash%20Page/splash_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/customer_tabs_screen.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/vendors_tabs_screen.dart';
import 'package:provider/provider.dart';

import 'package:magula_mobile/constants.dart';

//Providers
import 'package:magula_mobile/providers/buisnessprofile.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/providers/buisnessprofiles.dart';
import 'package:magula_mobile/providers/categories.dart';

//Screens
import 'package:magula_mobile/screens/Customer%20Pages/Categories%20Page/categories_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/SetupProfile%20Page/setup_profile.screen.dart';
import 'package:magula_mobile/screens/Common%20Pages/ForgetPassword%20Page/forget_password_screen.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignIn%20Page/sign_in_screen.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Hompage/home_screen.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/setup_vendor_profile_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: BuisnessProfiles(),
        ),
        ChangeNotifierProvider.value(
          value: BuisnessProfileProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Categories(),
        ),
        ChangeNotifierProvider.value(
          value: Bookings(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Magula.lk -Your Online Wedding Planner',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: primaryColor,
          textTheme: TextTheme(
            bodyText1: TextStyle(color: textPrimaryColor),
            bodyText2: TextStyle(color: textSecondaryColor),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                padding: EdgeInsets.all(defaultPadding)),
          ),
        ),
        home: CustomerTabsScreen(),
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          SignUpScreen.routeName: (context) => SignUpScreen(),
          SignInScreen.routeName: (context) => SignInScreen(),
          ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
          SetupUserProfileScreen.routeName: (context) =>
              SetupUserProfileScreen(),
          SetupVendorProfileScreen.routeName: (context) =>
              SetupVendorProfileScreen(),
          CategoriesScreen.routeName: (context) => CategoriesScreen(),
        },
      ),
    );
  }
}
