import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/date_picker_field.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/profile_pic_field.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field.dart';
import 'package:magula_mobile/Components/Other%20Widgets/default_button.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  Map<String, dynamic> formData = {
    "profileImage": null,
    "fullName": null,
    "displayName": null,
    "contactNo": null,
    "weddingDate": null,
  };

  Future<void> onSave() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          _loading = true;
        });
        await Provider.of<Auth>(context, listen: false)
            .updateUserProfile(formData);
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
                ProfilePictureField(
                  initialValue: user!["profileImage"],
                  onSaved: (value) {
                    formData["profileImage"] = value;
                  },
                ),
                FormTextField(
                  icon: Icons.person,
                  label: "Full Name",
                  initialValue: user["fullName"],
                  validator:
                      RequiredValidator(errorText: "Full Name is Required"),
                  onSaved: (value) {
                    formData["fullName"] = value;
                  },
                ),
                FormTextField(
                  icon: Icons.person,
                  label: "Display Name",
                  initialValue: user["displayName"],
                  validator:
                      RequiredValidator(errorText: "Display Name is Required"),
                  onSaved: (value) {
                    formData["displayName"] = value;
                  },
                ),
                FormTextField(
                  icon: Icons.phone,
                  label: "Contact Number",
                  initialValue: user["contactNo"],
                  validator: RequiredValidator(
                      errorText: "Contact Number is Required"),
                  onSaved: (value) {
                    formData["contactNo"] = value;
                  },
                ),
                DatePickerField(
                  label: "Wedding Date",
                  validator:
                      RequiredValidator(errorText: "Wedding date is Required"),
                  onSaved: (value) {
                    formData["weddingDate"] = value;
                  },
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
