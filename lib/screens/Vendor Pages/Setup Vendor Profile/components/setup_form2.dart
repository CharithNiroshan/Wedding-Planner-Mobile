import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/photo_selector_field.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/select_field.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field.dart';
import 'package:magula_mobile/Components/Other%20Widgets/default_button.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:provider/provider.dart';

class SetupForm2 extends StatefulWidget {
  const SetupForm2({Key? key, required this.onNext}) : super(key: key);
  final VoidCallback onNext;

  @override
  _SetupForm2State createState() => _SetupForm2State();
}

class _SetupForm2State extends State<SetupForm2> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  Map<String, dynamic> formData = {
    "title": null,
    "description": null,
    "accountCategory": null,
    "coverPhoto": null,
  };

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(formData);
      try {
        setState(() {
          _loading = true;
        });
        await Provider.of<Auth>(context, listen: false)
            .updateVendorProfile(formData);
        widget.onNext();
      } on Exception catch (error) {
        print(error.toString());
      }
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Basic Details",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              FormTextField(
                icon: Icons.apartment,
                label: "Title",
                validator: RequiredValidator(errorText: "Title is Required"),
                onSaved: (value) {
                  formData["title"] = value;
                },
              ),
              FormTextField(
                icon: Icons.note,
                label: "Description",
                validator:
                    RequiredValidator(errorText: "Description is Required"),
                onSaved: (value) {
                  formData["description"] = value;
                },
              ),
              SelectField(
                label: "Account Category",
                initialvalue: "Decorations",
                icon: Icons.category,
                onSaved: (value) {
                  print(value);
                  formData["accountCategory"] = value;
                },
                items: [
                  "Decorations",
                  "Music Groups",
                  "Dancing Groups",
                  "Photography",
                  "Bridal Dressing",
                  "Groom Dressing",
                  "Cake Design"
                ],
              ),
              PhotoSelectorField(
                onSaved: (String? value) {
                  formData["coverPhoto"] = value;
                },
              )
            ],
          ),
        ),
        const SizedBox(
          height: defaultPadding * 2,
        ),
        _loading
            ? LoadingButton()
            : DefaultButton(
                text: "Next",
                press: onSubmit,
              )
      ],
    );
  }
}
