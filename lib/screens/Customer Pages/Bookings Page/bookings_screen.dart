import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/Other%20Widgets/not_auth_screen.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/providers/bookings.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Bookings%20Page/components/booking_card.dart';
import 'package:provider/provider.dart';

class BookingsScreen extends StatefulWidget {
  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
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
    final bookings = Provider.of<Bookings>(context).bookings;

    return Consumer<Auth>(
      builder: (context, auth, child) => auth.isAuth
          ? _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<Bookings>(
                  builder: (context, value, child) => Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: ListView.builder(
                      itemCount: value.bookings.length,
                      itemBuilder: (context, index) => BookingCard(
                        id: value.bookings[index].id,
                        title: value.bookings[index].buisnessProfile.title,
                        imgSrc: value.bookings[index].buisnessProfile.logo,
                        category: value
                            .bookings[index].buisnessProfile.accountCategory,
                        date: value.bookings[index].bookingDate,
                        status: value.bookings[index].isRejected,
                      ),
                    ),
                  ),
                )
          : NotAuthScreen(),
    );
  }
}
