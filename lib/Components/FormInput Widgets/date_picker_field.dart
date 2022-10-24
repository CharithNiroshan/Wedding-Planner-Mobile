import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magula_mobile/constants.dart';

class DatePickerField extends StatefulWidget {
  DatePickerField({
    required this.label,
    this.initialValue,
    required this.validator,
    required this.onSaved,
  });

  final String label;
  final String? initialValue;
  final String? Function(String?) validator;
  final String? Function(String?) onSaved;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextFormField(
        initialValue: widget.initialValue,
        controller: dateinput,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.calendar_today,
          ),
          labelText: widget.label,
        ),
        validator: widget.validator,
        onSaved: widget.onSaved,
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

            setState(() {
              dateinput.text = formattedDate;
            });
          }
        },
      ),
      const SizedBox(
        height: defaultPadding,
      )
    ]);
  }
}
