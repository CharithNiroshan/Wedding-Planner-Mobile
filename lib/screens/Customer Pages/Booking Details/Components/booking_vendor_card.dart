import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Booking%20Details/Components/horizontal_details_field.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Booking%20Details/booking_details.dart';

class BookingVendorCard extends StatelessWidget {
  BookingVendorCard({
    required this.logo,
    required this.title,
    required this.accountCategory,
    required this.contactNo,
    required this.email,
  });

  final String logo, title, accountCategory, email, contactNo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Vendor Information",
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundImage: NetworkImage(
                  "https://$domainName/$logo",
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      accountCategory,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HorizontalDetailField(
                label: "Email",
                value: email,
              ),
              SizedBox(
                height: 5,
              ),
              HorizontalDetailField(
                label: "Contact No",
                value: contactNo,
              )
            ],
          ),
        ],
      ),
    );
  }
}
