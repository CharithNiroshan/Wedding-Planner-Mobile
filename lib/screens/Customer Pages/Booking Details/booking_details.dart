import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/bookings.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Booking%20Details/Components/app_bar.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Booking%20Details/Components/booking_vendor_card.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Booking%20Details/Components/horizontal_details_field.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Booking%20Details/Components/package_card.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Booking%20Details/Components/service_list.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Booking%20Details/Components/vertical_detail_field.dart';
import 'package:provider/provider.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({required this.id});

  final String id;

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  bool _isInit = true;
  bool _isLoading = true;

  void didChangeDependencies() async {
    if (_isInit) {
      try {
        await Provider.of<Bookings>(context).fetchAndSetBooking(widget.id);
        _isLoading = false;
      } catch (err) {
        throw err;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final booking = Provider.of<Bookings>(context).booking;

    return Scaffold(
      appBar: bookingDetailsScreenAppBar(context),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        HorizontalDetailField(
                          label: "Status",
                          value: "Pending",
                        ),
                        HorizontalDetailField(
                          label: "Booking Date",
                          value: booking!.bookingDate,
                        ),
                        HorizontalDetailField(
                          label: "Booked On",
                          value: booking.date,
                        ),
                        VerticalDetailField(
                          label: "Status Message",
                          value: booking.statusMessage == null
                              ? "Vendor haven't still Accept or Declined your Booking"
                              : booking.statusMessage as String,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Booking Requirements",
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
                        if (booking.bookingType == "Package Booking")
                          PackageCard(
                            title: booking.package!.title,
                            image: booking.package!.image,
                            description: booking.package!.description,
                            price: booking.package!.price,
                          ),
                        if (booking.bookingType == "Custom Booking")
                          ServiceList(
                              services: booking.services as List<dynamic>),
                        const SizedBox(
                          height: 10,
                        ),
                        VerticalDetailField(
                          label: "Extra Information",
                          value: booking.extraInfo,
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  BookingVendorCard(
                    logo: booking.buisnessProfile.logo,
                    title: booking.buisnessProfile.title,
                    accountCategory: booking.buisnessProfile.accountCategory,
                    contactNo: booking.buisnessProfile.contactNo,
                    email: booking.buisnessProfile.email,
                  ),
                ],
              ),
            ),
    );
  }
}
