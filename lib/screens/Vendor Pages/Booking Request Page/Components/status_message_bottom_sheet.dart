import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field.dart';
import 'package:magula_mobile/Components/Other%20Widgets/default_button.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/bookings.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:provider/provider.dart';

class StatusMessageBottomSheet extends StatefulWidget {
  @override
  State<StatusMessageBottomSheet> createState() =>
      _StatusMessageBottomSheetState();
}

class _StatusMessageBottomSheetState extends State<StatusMessageBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  bool _isRejecting = false;

  Map<String, dynamic> formData = {
    "statusmessage": null,
  };

  Future<void> onReject() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        _isRejecting = true;
        await Provider.of<Bookings>(context, listen: false)
            .rejectBooking(formData);
      }
    } catch (error) {
      print(error);
    } finally {
      _isRejecting = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20, bottom: 4, left: 20, right: 20),
              child: Text(
                "Reject Message",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "You need to add a Message before rejecting a Booking Request",
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Form(
                    key: _formKey,
                    child: FormTextField(
                      icon: Icons.message,
                      label: "Reject Message",
                      validator: RequiredValidator(
                        errorText: "Please enter a message",
                      ),
                      onSaved: (value) {
                        formData["statusmessage"] = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _isRejecting
                      ? LoadingButton()
                      : DefaultButton(
                          text: "Confirm Rejection",
                          press: onReject,
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
