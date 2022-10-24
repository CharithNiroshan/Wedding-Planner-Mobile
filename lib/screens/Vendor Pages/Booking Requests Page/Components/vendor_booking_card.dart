import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Booking%20Request%20Page/booking_request_details_screen.dart';

class VendorBookingCard extends StatelessWidget {
  VendorBookingCard({
    required this.id,
    required this.bookingType,
    required this.fullName,
    required this.imgSrc,
    required this.status,
    required this.date,
  });

  final String id, bookingType, fullName, imgSrc, date;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingRequestDetailsScreen(
              id: id,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: EdgeInsets.all(defaultPadding),
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage:
                          NetworkImage("https://$domainName/$imgSrc"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      fullName,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Booking Date : $date",
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Booking Type : $bookingType",
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            status
                ? Text(
                    "Pending",
                  )
                : Text(
                    "Rejected",
                  )
          ],
        ),
      ),
    );
  }
}
