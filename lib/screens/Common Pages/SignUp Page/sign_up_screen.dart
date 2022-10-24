import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignIn%20Page/sign_in_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "/sign-up";
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String?, String?> authData = {
    "email": "",
    "password": "",
    "accountType": "",
  };
  bool _loading = false;
  int screenNumber = 1;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Authentication Failed!"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Ok"),
          )
        ],
      ),
    );
  }

  Future<void> onSubmit() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          _loading = true;
        });
        await Provider.of<Auth>(context, listen: false).signUp(
          authData["email"],
          authData["password"],
          authData["accountType"],
        );
        _showErrorDialog('Authentication Failed.Please Try Again Later.');
      }
    } on Exception catch (err) {
      _showErrorDialog('Authentication Failed.Please Try Again Later.');
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: false,
      body: screenNumber == 1
          ? Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    child: Image(
                      image: AssetImage(
                        "assets/images/logo.png",
                      ),
                      width: 150,
                      height: 150,
                    ),
                  ),
                  Column(children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          authData["accountType"] = "Customer";
                          screenNumber += screenNumber;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.only(right: 15, left: 15, bottom: 15),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Register as Customer",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          authData["accountType"] = "Vendor";
                          screenNumber += screenNumber;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 15, right: 15, left: 15),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Register as a Vendor",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ])
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormTopCard(title: "Create Account"),
                  const SizedBox(
                    height: 30,
                  ),
                  SignUpForm(formKey: _formKey, authData: authData),
                  _loading
                      ? LoadingButton()
                      : GestureDetector(
                          onTap: () {
                            onSubmit();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                top: 30, right: 15, left: 15, bottom: 15),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an Account?"),
                      TextButton(
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            color: secondaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 30, right: 15, left: 15, bottom: 15),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.authData,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final Map<String?, String?> authData;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormTextField(
              icon: Icons.email,
              label: "Email",
              validator: emailValidator,
              onSaved: (value) {
                authData["email"] = value;
              },
            ),
            FormTextField(
              icon: Icons.password,
              label: "Passwod",
              validator: passwordValidator,
              onSaved: (value) {
                authData["password"] = value;
              },
            ),
            FormTextField(
              icon: Icons.password,
              label: "Confirm Password",
              validator: (value) {
                MatchValidator(
                  errorText: "Passwords don't match",
                );
              },
              onSaved: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
