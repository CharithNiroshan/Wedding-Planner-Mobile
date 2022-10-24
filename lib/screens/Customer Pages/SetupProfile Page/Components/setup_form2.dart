import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/date_picker_field.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field.dart';
import 'package:magula_mobile/Components/Other%20Widgets/default_button.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:provider/provider.dart';

class UserProfileSetupForm2 extends StatefulWidget {
  const UserProfileSetupForm2({Key? key, required this.onNext})
      : super(key: key);
  final VoidCallback onNext;

  @override
  _UserProfileSetupForm2State createState() => _UserProfileSetupForm2State();
}

class _UserProfileSetupForm2State extends State<UserProfileSetupForm2> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  Map<String, dynamic> formData = {
    "fullName": null,
    "displayName": null,
    "email": null,
    "contactNo": null,
    "weddingDate": null,
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
                icon: Icons.person,
                label: "Full Name",
                validator:
                    RequiredValidator(errorText: "Full Name is Required"),
                onSaved: (value) {
                  formData["fullName"] = value;
                },
              ),
              FormTextField(
                icon: Icons.person,
                label: "Display Name",
                validator:
                    RequiredValidator(errorText: "Display Name is Required"),
                onSaved: (value) {
                  formData["displayName"] = value;
                },
              ),
              FormTextField(
                icon: Icons.email,
                label: "Email",
                validator: emailValidator,
                onSaved: (value) {
                  formData["email"] = value;
                },
              ),
              FormTextField(
                icon: Icons.phone,
                label: "Contact Number",
                validator:
                    RequiredValidator(errorText: "Contact Number is Required"),
                onSaved: (value) {
                  formData["contactNo"] = value;
                },
              ),
              DatePickerField(
                label: "Wedding Date",
                validator: RequiredValidator(
                  errorText: "Wedding date is Required",
                ),
                onSaved: (value) {
                  formData["weddingDate"] = value;
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: defaultPadding * 2,
        ),
        _loading
            ? LoadingButton()
            : DefaultButton(
                text: "Finish",
                press: onSubmit,
              )
      ],
    );
  }
}
