import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';

class Filter extends StatefulWidget {
  Filter({
    required this.label,
    required this.items,
    required this.onSaved,
    this.initialValue,
  });

  final String label;
  final List<String> items;
  final Function(String?) onSaved;
  final String? initialValue;

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String? value;

  void initState() {
    if (widget.initialValue != null) {
      value = widget.initialValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textPrimaryColor,
          ),
        ),
        Visibility(
          visible: false,
          child: TextFormField(
            onSaved: widget.onSaved(value),
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding:
              EdgeInsets.symmetric(vertical: 2, horizontal: defaultPadding),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade600,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 17,
            ),
            underline: Container(
              height: 0,
              color: Colors.grey.shade600.withOpacity(0.75),
            ),
            onChanged: (String? newValue) {
              setState(() {
                value = newValue;
              });
            },
            items: widget.items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
