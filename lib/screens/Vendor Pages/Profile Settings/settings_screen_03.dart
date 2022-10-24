import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/checkbox_group_field.dart';
import 'package:magula_mobile/Components/Other%20Widgets/default_button.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/providers/categories.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:provider/provider.dart';

class SettingsScreen03 extends StatefulWidget {
  @override
  _SettingsScreen03State createState() => _SettingsScreen03State();
}

class _SettingsScreen03State extends State<SettingsScreen03> {
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  Map<String, dynamic> formData = {
    "services": [],
  };

  Future<void> onSave() async {
    try {
      if (formData["services"].length != 0) {
        _formKey.currentState!.save();
        setState(() {
          _loading = true;
        });
        await Provider.of<Auth>(context, listen: false)
            .updateVendorProfile(formData);
        setState(() {
          _loading = false;
        });
      }
    } on Exception catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<Categories>(context, listen: false);
    final categories = categoriesData.categories;

    final auth = Provider.of<Auth>(context);
    final user = auth.user;

    final item = categories
        .firstWhere((element) => element.title == user!["accountCategory"]);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CheckboxGroupField(
                items: item.services as List<dynamic>,
                initialValues: user!["services"],
                onSaved: (value) {
                  formData["services"] = value;
                },
              ),
              const SizedBox(
                height: defaultPadding * 2,
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
      ),
    );
  }
}
