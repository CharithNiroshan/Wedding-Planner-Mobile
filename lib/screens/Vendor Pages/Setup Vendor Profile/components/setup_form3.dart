import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/select_field.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field.dart';
import 'package:magula_mobile/Components/Other%20Widgets/default_button.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:provider/provider.dart';

class SetupForm3 extends StatefulWidget {
  const SetupForm3({Key? key, required this.onNext}) : super(key: key);

  final VoidCallback onNext;

  @override
  _SetupForm3State createState() => _SetupForm3State();
}

class _SetupForm3State extends State<SetupForm3> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  Map<String, dynamic> formData = {
    "email": null,
    "contactNo": null,
    "address": null,
    "district": null
  };

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
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
          "Contact Details",
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
                    RequiredValidator(errorText: 'Contact Number is Required'),
                onSaved: (value) {
                  formData["contactNo"] = value;
                },
              ),
              FormTextField(
                icon: Icons.location_on,
                label: "Address",
                validator: RequiredValidator(errorText: 'Address is Required'),
                onSaved: (value) {
                  formData["address"] = value;
                },
              ),
              SelectField(
                label: "District",
                icon: Icons.location_city,
                initialvalue: "Kandy",
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
