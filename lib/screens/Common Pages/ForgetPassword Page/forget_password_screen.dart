import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignIn%20Page/sign_in_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const routeName = "/forget-password";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormTopCard(title: "Forgot Password"),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormTextField(
                      icon: Icons.email,
                      label: "Email Address",
                      validator: emailValidator,
                      onSaved: RequiredValidator(
                          errorText: "Contact Number is Required"),
                    ),
                  ],
                ),
              ),
            ),
            Button(routeName: routeName),
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  final String routeName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 30, right: 15, left: 15, bottom: 15),
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          "Submit",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
