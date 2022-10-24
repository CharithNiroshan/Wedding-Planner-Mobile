import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field_name.dart';
import 'package:magula_mobile/constants.dart';

class SelectField extends StatefulWidget {
  SelectField({
    required this.label,
    required this.onSaved,
    this.icon,
    this.initialvalue,
    required this.items,
  });

  final IconData? icon;
  final String label;
  final String? initialvalue;
  final Function(String) onSaved;
  final List<String> items;
  @override
  _SelectFieldState createState() => _SelectFieldState();
}

class _SelectFieldState extends State<SelectField> {
  String? dropdownValue;

  void initState() {
    dropdownValue = widget.initialvalue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldName(text: widget.label),
        const SizedBox(height: 10),
        Visibility(
          visible: false,
          child: TextFormField(
            onSaved: widget.onSaved(dropdownValue as String),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade600.withOpacity(0.75),
              ),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Icon(
                widget.icon,
                color: Colors.grey.shade600.withOpacity(0.95),
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    right: 10,
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8), fontSize: 17),
                    underline: Container(
                      height: 0,
                      color: Colors.grey.shade600.withOpacity(0.75),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue as String;
                      });
                    },
                    items: widget.items
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        )
      ],
    );
  }
}
