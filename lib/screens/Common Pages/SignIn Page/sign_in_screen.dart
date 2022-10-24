import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Common%20Pages/ForgetPassword%20Page/forget_password_screen.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/customer_tabs_screen.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/vendors_tabs_screen.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = "/sign-in";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String?, String?> authData = {
    "email": "",
    "password": "",
  };
  bool _loading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error!"),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
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
        await Provider.of<Auth>(context, listen: false)
            .signIn(authData["email"], authData["password"]);
        final authType = Provider.of<Auth>(context, listen: false).type;
        if (authType == "Customer") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CustomerTabsScreen()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => VendorTabsScreen()));
        }
      }
    } catch (error) {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormTopCard(
              title: "Sign In",
            ),
            const SizedBox(
              height: 30,
            ),
            SignInForm(
              formKey: _formKey,
              authData: authData,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
              },
              child: Container(
                margin: EdgeInsets.only(top: 10, right: 25),
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            _loading
                ? Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: 30, right: 15, left: 15, bottom: 15),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
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
                        "Sign In",
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
                Text("Don't have an Account?"),
                TextButton(
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpScreen.routeName);
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

class SignInForm extends StatelessWidget {
  const SignInForm({required this.formKey, required this.authData});

  final GlobalKey formKey;
  final Map<String?, String?> authData;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormTextField(
              icon: Icons.email,
              label: "Email Address",
              validator: emailValidator,
              onSaved: (value) {
                authData["email"] = value;
              },
            ),
            FormTextField(
              icon: Icons.vpn_key,
              label: "Password",
              validator: RequiredValidator(errorText: "Password is Required"),
              onSaved: (value) {
                authData["password"] = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FormTopCard extends StatelessWidget {
  const FormTopCard({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(90),
        ),
        color: primaryColor,
      ),
      child: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: Image(
                image: AssetImage(
                  "assets/images/logo.png",
                ),
                width: 100,
                height: 100,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 45),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
