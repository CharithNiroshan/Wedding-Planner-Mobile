import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Add%20Booking%20Page/booking_form.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Add%20Review%20Page/review_form.dart';

class BuisnessProfileBottomNavigatorBar extends StatelessWidget {
  const BuisnessProfileBottomNavigatorBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.yellow.shade800,
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingForm(),
                  ),
                );
              },
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Add Booking",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewForm(),
                  ),
                );
              },
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Add Review",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
