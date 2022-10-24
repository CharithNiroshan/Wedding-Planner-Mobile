import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Schedule%20Page/components/event_list.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Schedule%20Page/components/selected_date_event_card.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime activeDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: activeDate,
              firstDay: DateTime.now(),
              lastDay: DateTime(2222),
              availableGestures: AvailableGestures.horizontalSwipe,
              onDaySelected: (selectedDay, focusedDay) => setState(
                () {
                  activeDate = selectedDay;
                },
              ),
              calendarStyle: CalendarStyle(),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            CurrentDateEventsCard(
              date: activeDate,
            ),
            SizedBox(
              height: defaultPadding,
            ),
            WeekEventList(),
          ],
        ),
      ),
    );
  }
}
