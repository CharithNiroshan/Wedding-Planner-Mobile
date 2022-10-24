import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/providers/bookings.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Bookings%20Page/components/booking_card.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Booking%20Requests%20Page/Components/vendor_booking_card.dart';
import 'package:provider/provider.dart';

class BookingRequestsScreen extends StatefulWidget {
  @override
  State<BookingRequestsScreen> createState() => _BookingRequestsScreenState();
}

class _BookingRequestsScreenState extends State<BookingRequestsScreen> {
  bool _isInit = true;
  bool _isLoading = true;

  void didChangeDependencies() async {
    if (_isInit) {
      try {
        String id = Provider.of<Auth>(context).user!["_id"];
        await Provider.of<Bookings>(context).fetchAndSetBookings(id);
      } catch (err) {
        print(err);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Consumer<Bookings>(
            builder: (context, value, child) => Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: ListView.builder(
                itemCount: value.bookings.length,
                itemBuilder: (context, index) => VendorBookingCard(
                  id: value.bookings[index].id,
                  fullName: value.bookings[index].user.fullName as String,
                  imgSrc: value.bookings[index].buisnessProfile.logo,
                  bookingType: value.bookings[index].bookingType,
                  date: value.bookings[index].bookingDate,
                  status: value.bookings[index].isRejected,
                ),
              ),
            ),
          );
  }
}
