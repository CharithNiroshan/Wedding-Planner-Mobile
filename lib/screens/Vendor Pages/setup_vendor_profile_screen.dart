import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignIn%20Page/sign_in_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Hompage/home_screen.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Setup%20Vendor%20Profile/components/setup_form1.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Setup%20Vendor%20Profile/components/setup_form2.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Setup%20Vendor%20Profile/components/setup_form3.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Setup%20Vendor%20Profile/components/setup_form4.dart';

class SetupVendorProfileScreen extends StatefulWidget {
  const SetupVendorProfileScreen({Key? key}) : super(key: key);
  static const routeName = "/setup-vendor-profilre";

  @override
  State<SetupVendorProfileScreen> createState() =>
      _SetupVendorProfileScreenState();
}

class _SetupVendorProfileScreenState extends State<SetupVendorProfileScreen> {
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
                      ? SetupForm1(
                          onNext: () {
                            setState(() {
                              setupProfileStep++;
                            });
                          },
                        )
                      : setupProfileStep == 2
                          ? SetupForm2(
                              onNext: () {
                                setState(() {
                                  setupProfileStep++;
                                });
                              },
                            )
                          : setupProfileStep == 3
                              ? SetupForm3(
                                  onNext: () {
                                    setState(() {
                                      setupProfileStep++;
                                    });
                                  },
                                )
                              : SetupForm4(
                                  onNext: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ),
                                    );
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
