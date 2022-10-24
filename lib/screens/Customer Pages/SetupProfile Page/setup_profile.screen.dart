import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignIn%20Page/sign_in_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/SetupProfile%20Page/Components/setup_form1.dart';
import 'package:magula_mobile/screens/Customer%20Pages/SetupProfile%20Page/Components/setup_form2.dart';

class SetupUserProfileScreen extends StatefulWidget {
  static const routeName = "/setup-user-profilre";

  @override
  State<SetupUserProfileScreen> createState() => _SetupUserProfileScreenState();
}

class _SetupUserProfileScreenState extends State<SetupUserProfileScreen> {
  int setupProfileStep = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FormTopCard(title: "SetUp Your Profile"),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  setupProfileStep == 1
                      ? UserProfileSetupForm1(
                          onNext: () {
                            setState(() {
                              setupProfileStep++;
                            });
                          },
                        )
                      : UserProfileSetupForm2(
                          onNext: () {
                            setState(() {
                              setupProfileStep++;
                            });
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
