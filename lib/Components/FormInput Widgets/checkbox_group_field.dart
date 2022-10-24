import "package:flutter/material.dart";
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field_name.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/models/checkboxModel.dart';

class CheckboxGroupField extends StatefulWidget {
  CheckboxGroupField({
    required this.onSaved,
    required this.items,
    this.initialValues,
    this.label,
  });

  final String? label;
  final Function(List<String>) onSaved;
  final List<dynamic> items;
  final List<dynamic>? initialValues;

  @override
  State<CheckboxGroupField> createState() => _CheckboxGroupFieldState();
}

class _CheckboxGroupFieldState extends State<CheckboxGroupField> {
  List<CheckboxModel> _checkboxItems = [];

  List<String> services = [];

  final allCheckboxes = CheckboxModel(
    name: "All Services",
    isSelected: false,
  );

  void initState() {
    widget.items.forEach(
      (item) => _checkboxItems.add(
        CheckboxModel(
          name: item,
          isSelected: widget.initialValues!.contains(item),
        ),
      ),
    );
    if (widget.initialValues != null) {
      widget.initialValues!.forEach((service) => services.add(service));
    }

    super.initState();
  }

  bool value = false;

  @override
  Widget build(BuildContext context) {
    print(widget.label);
    print(widget.items);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) TextFieldName(text: widget.label as String),
        const SizedBox(
          height: defaultPadding,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: false,
              child: TextFormField(
                onSaved: widget.onSaved(services),
              ),
            ),
            buildGroupCheckbox(allCheckboxes),
            Divider(
              color: Colors.black,
            ),
            ..._checkboxItems.map(buildSingleCheckBox).toList(),
          ],
        ),
        const SizedBox(
          height: defaultPadding,
        ),
      ],
    );
  }

  Widget buildSingleCheckBox(CheckboxModel checkboxModel) => CheckboxListTile(
        activeColor: primaryColor,
        value: checkboxModel.isSelected,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (value) => setState(() => {
              checkboxModel.isSelected = value!,
              if (value)
                {
                  services.add(checkboxModel.name),
                }
              else
                {
                  services.remove(checkboxModel.name),
                },
              allCheckboxes.isSelected = _checkboxItems.every(
                (checkboItem) => checkboItem.isSelected,
              )
            }),
        title: Text(
          checkboxModel.name,
        ),
      );

  Widget buildGroupCheckbox(CheckboxModel checkboxModel) => CheckboxListTile(
        activeColor: primaryColor,
        value: checkboxModel.isSelected,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (value) => toggleGroupCheckBox(value!),
        title: Text(
          checkboxModel.name,
        ),
      );

  void toggleGroupCheckBox(bool value) {
    setState(
      () {
        allCheckboxes.isSelected = value;
        if (value) {
          _checkboxItems.forEach((checkboxItem) {
            if (!services.contains(checkboxItem.name)) {
              services.add(checkboxItem.name);
            }
          });
        } else {
          services.removeRange(0, services.length);
        }
        _checkboxItems.forEach((checkbox) => checkbox.isSelected = value);
      },
    );
  }
}
