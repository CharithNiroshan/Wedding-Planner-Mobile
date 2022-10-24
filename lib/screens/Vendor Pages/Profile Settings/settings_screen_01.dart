import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/photo_selector_field.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/profile_pic_field.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/select_field.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field.dart';
import 'package:magula_mobile/Components/Other%20Widgets/default_button.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:provider/provider.dart';

class SettingsScreen01 extends StatefulWidget {
  @override
  State<SettingsScreen01> createState() => _SettingsScreen01State();
}

class _SettingsScreen01State extends State<SettingsScreen01> {
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  Map<String, dynamic> formData = {
    "logo": null,
    "title": null,
    "description": null,
    "accountCategory": null,
    "coverPhoto": null,
  };

  Future<void> onSave() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        print(formData);
        setState(() {
          _loading = true;
        });
        await Provider.of<Auth>(context, listen: false)
            .updateVendorProfile(formData);
      }
    } on Exception catch (error) {
      print(error.toString());
    } finally {
      setState(() {
        _loading = false;
      });
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
                  initialValue: user!["logo"],
                  onSaved: (value) {
                    formData["logo"] = value;
                  },
                ),
                FormTextField(
                  icon: Icons.title,
                  label: "Title",
                  initialValue: user["title"],
                  validator: RequiredValidator(errorText: "Title is Required"),
                  onSaved: (value) {
                    formData["title"] = value;
                  },
                ),
                FormTextField(
                  icon: Icons.description,
                  label: "Description",
                  initialValue: user["description"],
                  validator:
                      RequiredValidator(errorText: "Description is Required"),
                  onSaved: (value) {
                    formData["description"] = value;
                  },
                ),
                SelectField(
                  label: "Account Category",
                  initialvalue: user["accountCategory"],
                  icon: Icons.category,
                  onSaved: (value) {
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
                  initialValue: user["coverPhoto"],
                  onSaved: (String? value) {
                    formData["coverPhoto"] = value;
                  },
                )
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
