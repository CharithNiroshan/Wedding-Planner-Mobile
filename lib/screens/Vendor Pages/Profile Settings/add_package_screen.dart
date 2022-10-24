import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/photo_selector_field.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field.dart';
import 'package:magula_mobile/Components/Other%20Widgets/default_button.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:provider/provider.dart';

class AddPackageScreen extends StatefulWidget {
  @override
  State<AddPackageScreen> createState() => _AddPackageScreenState();
}

class _AddPackageScreenState extends State<AddPackageScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  Map<String, dynamic> formData = {
    "title": null,
    "description": null,
    "image": null,
    "price": null,
  };

  Future<void> onSave() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          _loading = true;
        });
        await Provider.of<Auth>(context, listen: false)
            .addPackageToVendorProfile(formData);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Add Package",
        ),
      ),
      body: SingleChildScrollView(
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
                    icon: Icons.title,
                    label: "Package Title",
                    validator: RequiredValidator(
                        errorText: "Package Title is Required"),
                    onSaved: (value) {
                      formData["title"] = value;
                    },
                  ),
                  FormTextField(
                    icon: Icons.description,
                    label: "Package Description",
                    validator: RequiredValidator(
                        errorText: "Package Description is Required"),
                    onSaved: (value) {
                      formData["description"] = value;
                    },
                  ),
                  FormTextField(
                    icon: Icons.money,
                    label: "Price",
                    validator:
                        RequiredValidator(errorText: "Price is Required"),
                    onSaved: (value) {
                      formData["price"] = value;
                    },
                    prefixText: "Rs . ",
                    keyboardType: TextInputType.number,
                  ),
                  PhotoSelectorField(
                    onSaved: (String? value) {
                      formData["image"] = value;
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
                    text: "Submit",
                    press: onSave,
                  )
          ],
        ),
      ),
    );
  }
}
