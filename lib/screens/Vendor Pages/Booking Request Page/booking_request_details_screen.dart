import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/Other%20Widgets/default_button.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/bookings.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Booking%20Details/Components/app_bar.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Booking%20Details/Components/booking_vendor_card.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Booking%20Details/Components/horizontal_details_field.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Booking%20Details/Components/package_card.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Booking%20Details/Components/service_list.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Booking%20Details/Components/vertical_detail_field.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Booking%20Request%20Page/Components/app_bar.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Booking%20Request%20Page/Components/booking_usercard.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Booking%20Request%20Page/Components/status_message_bottom_sheet.dart';
import 'package:provider/provider.dart';

class BookingRequestDetailsScreen extends StatefulWidget {
  const BookingRequestDetailsScreen({required this.id});

  final String id;

  @override
  State<BookingRequestDetailsScreen> createState() =>
      _BookingRequestDetailsScreenState();
}

class _BookingRequestDetailsScreenState
    extends State<BookingRequestDetailsScreen> {
  bool _isInit = true;
  bool _isLoading = true;
  bool _isAccepting = false;

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

  Future<void> onAccept() async {
    try {
      _isAccepting = true;
      await Provider.of<Bookings>(context, listen: false).acceptBooking();
    } catch (error) {
      print(error);
    } finally {
      _isAccepting = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final booking = Provider.of<Bookings>(context).booking;

    return Scaffold(
      appBar: bookingRequestDetailsScreenAppBar(context),
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
                          label: "Booking Type",
                          value: booking!.bookingType,
                        ),
                        HorizontalDetailField(
                          label: "Booking Date",
                          value: booking.bookingDate,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _isAccepting
                            ? LoadingButton()
                            : DefaultButton(
                                text: "Accept",
                                press: onAccept,
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        DefaultButton(
                          text: "Reject",
                          press: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) =>
                                  StatusMessageBottomSheet(),
                            );
                          },
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
                  BookingUsercard(
                    profileImage: booking.user.profileImage as String,
                    fullName: booking.user.fullName as String,
                    contactNo: booking.user.contactNo as String,
                    email: booking.user.email as String,
                  ),
                ],
              ),
            ),
    );
  }
}
