import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/profile_pic_field.dart';
import 'package:magula_mobile/Components/Other%20Widgets/default_button.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:provider/provider.dart';

class UserProfileSetupForm1 extends StatefulWidget {
  const UserProfileSetupForm1({required this.onNext});
  final VoidCallback onNext;

  @override
  _UserProfileSetupForm1State createState() => _UserProfileSetupForm1State();
}

class _UserProfileSetupForm1State extends State<UserProfileSetupForm1> {
  bool _loading = false;
  Map<String, dynamic> formData = {
    "profileImage": null,
  };

  void onSubmit() async {
    if (formData["profileImage"] != null) {
      try {
        setState(() {
          _loading = true;
        });
        await Provider.of<Auth>(context, listen: false)
            .updateUserProfile(formData);
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
        const SizedBox(
          height: 30,
        ),
        Text(
          "Select Profile Picture",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        ProfilePictureField(
          onSaved: (value) {
            formData["profileImage"] = value;
          },
        ),
        const SizedBox(
          height: 10,
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
