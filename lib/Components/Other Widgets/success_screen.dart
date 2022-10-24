import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'dart:async';

class SuceessScreen extends StatefulWidget {
  static const routeName = "\success";
  final String title;
  final void Function() onTimedout;

  SuceessScreen({required this.title, required this.onTimedout});

  @override
  State<SuceessScreen> createState() => _SuceessScreenState();
}

class _SuceessScreenState extends State<SuceessScreen> {
  void Function()? route;

  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 40);
    return new Timer(duration, widget.onTimedout);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/output-onlinepngtools.png",
              width: 150,
              height: 150,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
