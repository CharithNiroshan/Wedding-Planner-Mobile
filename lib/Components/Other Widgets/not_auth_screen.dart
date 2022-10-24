import 'package:flutter/material.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignIn%20Page/sign_in_screen.dart';

class NotAuthScreen extends StatelessWidget {
  const NotAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/1_JY-JZfN8GW_OsJoVrI7wBg.png",
            width: 150,
            height: 300,
          ),
          Text(
            "You are Not Signed In.",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SignInScreen.routeName,
              );
            },
            child: Text(
              "Sign In",
            ),
          ),
        ],
      ),
    );
  }
}
