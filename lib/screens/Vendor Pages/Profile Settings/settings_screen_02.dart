import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/select_field.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field.dart';
import 'package:magula_mobile/Components/Other%20Widgets/default_button.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:provider/provider.dart';

class SettingsScreen02 extends StatefulWidget {
  @override
  State<SettingsScreen02> createState() => _SettingsScreen02State();
}

class _SettingsScreen02State extends State<SettingsScreen02> {
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  Map<String, dynamic> formData = {
    "email": null,
    "contactNo": null,
    "address": null,
    "district": null
  };

  Future<void> onSave() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          _loading = true;
        });
        await Provider.of<Auth>(context, listen: false)
            .updateVendorProfile(formData);
        setState(() {
          _loading = false;
        });
        Navigator.of(context).pop();
      }
    } on Exception catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final user = auth.user;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormTextField(
                  icon: Icons.email,
                  label: "Email",
                  initialValue: user!["email"],
                  validator: emailValidator,
                  onSaved: (value) {
                    formData["email"] = value;
                  },
                ),
                FormTextField(
                  icon: Icons.phone,
                  label: "Contact Number",
                  initialValue: user["contactNo"],
                  validator: RequiredValidator(
                      errorText: 'Contact Number is Required'),
                  onSaved: (value) {
                    formData["contactNo"] = value;
                  },
                ),
                FormTextField(
                  icon: Icons.location_on,
                  label: "Address",
                  initialValue: user["address"],
                  validator:
                      RequiredValidator(errorText: 'Address is Required'),
                  onSaved: (value) {
                    formData["address"] = value;
                  },
                ),
                SelectField(
                  label: "District",
                  icon: Icons.location_city,
                  initialvalue: user["district"],
                  onSaved: (value) {
                    formData["district"] = value;
                  },
                  items: [
                    "Colombo",
                    "Kandy",
                    "Galle",
                    "Mathara",
                    "Gampaha",
                    "Kaluthara"
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          _loading
              ? LoadingButton()
              : DefaultButton(
                  text: "Save",
                  press: onSave,
                )
        ],
      ),
    );
  }
}
