import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/photo_selector_field.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field.dart';
import 'package:magula_mobile/Components/Other%20Widgets/default_button.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:provider/provider.dart';

class EditPackageScreen extends StatefulWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int price;
  final String description;

  EditPackageScreen({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
  });
  @override
  State<EditPackageScreen> createState() => _EditPackageScreenState();
}

class _EditPackageScreenState extends State<EditPackageScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  Map<String, dynamic> formData = {
    "_id": null,
    "title": null,
    "description": null,
    "image": null,
    "price": null,
  };

  void initState() {
    formData["_id"] = widget.id;
    super.initState();
  }

  Future<void> onSave() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          _loading = true;
        });
        print(formData);
        await Provider.of<Auth>(context, listen: false)
            .editPackageOfVendorProfile(formData);
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
          "Edit Package",
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
                    initialValue: widget.title,
                    validator: RequiredValidator(
                        errorText: "Package Title is Required"),
                    onSaved: (value) {
                      formData["title"] = value;
                    },
                  ),
                  FormTextField(
                    icon: Icons.description,
                    label: "Package Description",
                    initialValue: widget.description,
                    validator: RequiredValidator(
                        errorText: "Package Description is Required"),
                    onSaved: (value) {
                      formData["description"] = value;
                    },
                  ),
                  FormTextField(
                    icon: Icons.money,
                    label: "Price",
                    initialValue: widget.price.toString(),
                    validator:
                        RequiredValidator(errorText: "Price is Required"),
                    onSaved: (value) {
                      formData["price"] = value;
                    },
                    prefixText: "Rs . ",
                    keyboardType: TextInputType.number,
                  ),
                  PhotoSelectorField(
                    initialValue: widget.imageUrl,
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
                    text: "Save",
                    press: onSave,
                  )
          ],
        ),
      ),
    );
  }
}
