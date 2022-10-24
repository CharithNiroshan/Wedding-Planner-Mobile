import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';

class RadioGroupField extends StatefulWidget {
  RadioGroupField({
    required this.label,
    required this.options,
    required this.initialValue,
    required this.onSaved,
  });

  final String label;
  final List<String> options;
  final String initialValue;
  final Function(String) onSaved;

  @override
  State<RadioGroupField> createState() => _RadioGroupFieldState();
}

class _RadioGroupFieldState extends State<RadioGroupField> {
  String? value;

  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Column(
            children: widget.options
                .map(
                  (option) => Row(
                    children: [
                      Radio(
                        value: option,
                        groupValue: value,
                        onChanged: (groupValue) {
                          widget.onSaved(groupValue as String);
                          setState(() {
                            value = groupValue;
                          });
                        },
                      ),
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      Text(
                        option,
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
      ],
    );
  }
}
