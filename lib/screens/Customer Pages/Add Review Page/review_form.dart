import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field_name.dart';
import 'package:magula_mobile/Components/Other%20Widgets/default_button.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/providers/buisnessprofile.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignIn%20Page/sign_in_screen.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/setup_vendor_profile_screen.dart';
import 'package:provider/provider.dart';

class ReviewForm extends StatefulWidget {
  static const String routeName = "/sign-up";
  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {
    "user": null,
    "rating": 3,
    "description": null,
    "date": null,
  };

  bool _loading = false;

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
        formData["date"] = DateTime.now().toIso8601String();
        setState(() {
          _loading = true;
        });
        Provider.of<BuisnessProfileProvider>(context, listen: false)
            .addReview(formData);
      }
    } on Exception catch (error) {
      _showErrorDialog(error.toString());
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context).user;

    setState(() {
      formData["user"] = user;
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FormTopCard(
              title: "Add Review",
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldName(text: "Rating"),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              formData["rating"] = rating;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                      ],
                    ),
                    FormTextField(
                      icon: Icons.description,
                      label: "Review Description",
                      validator: RequiredValidator(
                          errorText: "Review Description is Required"),
                      onSaved: (value) {
                        formData["description"] = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: DefaultButton(
                text: "Submit",
                press: onSubmit,
              ),
            )
          ],
        ),
      ),
    );
  }
}
