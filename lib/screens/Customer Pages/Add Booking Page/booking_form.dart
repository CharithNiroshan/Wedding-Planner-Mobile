import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/checkbox_group_field.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/date_picker_field.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/radio_group_field.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field.dart';
import 'package:magula_mobile/Components/Other%20Widgets/default_button.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/providers/buisnessprofile.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignIn%20Page/sign_in_screen.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:magula_mobile/screens/Customer%20Pages/Add%20Booking%20Page/package_selector.dart';
import 'package:provider/provider.dart';

class BookingForm extends StatefulWidget {
  static const String routeName = "/sign-up";
  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {
    "user": null,
    "buisnessProfile": null,
    "bookingType": "Package Booking",
    "bookingPackage": null,
    "services": null,
    "extraInfo": null,
    "bookingDate": null,
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
    if (formData["bookingPackage"] == null && formData["services"] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "You need to select atleast one service or a Package to add a booking.",
          ),
        ),
      );
    } else {
      try {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          formData["user"] = Provider.of<Auth>(context, listen: false).user;
          setState(() {
            _loading = true;
          });
          Provider.of<BuisnessProfileProvider>(context, listen: false)
              .addBooking(formData);
        }
      } catch (error) {
        print(error);
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FormTopCard(
              title: "Add Booking",
            ),
            const SizedBox(
              height: 36,
            ),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioGroupField(
                      label: "Booking Type",
                      options: [
                        "Package Booking",
                        "Custom Booking",
                      ],
                      initialValue: "Package Booking",
                      onSaved: (value) {
                        if (value == "Package Booking") {
                          formData["services"] = null;
                        } else {
                          formData["bookingPackage"] = null;
                        }
                        setState(() {
                          formData["bookingType"] = value;
                        });
                      },
                    ),
                    if (formData["bookingType"] == "Package Booking")
                      PackageSelector(
                        label: "Select a Package",
                        onSaved: (Map<String, dynamic>? value) {
                          formData["bookingPackage"] = value;
                        },
                      ),
                    if (formData["bookingType"] == "Custom Booking")
                      Consumer<BuisnessProfileProvider>(
                        builder: (context, value, child) => CheckboxGroupField(
                          label: "Select services you need",
                          initialValues: [],
                          onSaved: (value) {
                            formData["services"] = value;
                          },
                          items: value.buisnessProfile["services"],
                        ),
                      ),
                    FormTextField(
                      icon: Icons.description,
                      label: "Extra Information",
                      validator: RequiredValidator(
                          errorText: "Extra Information is Required"),
                      onSaved: (value) {
                        formData["extraInfo"] = value;
                      },
                    ),
                    DatePickerField(
                      label: "Booking Date",
                      validator: RequiredValidator(
                        errorText: 'Booking Date is required',
                      ),
                      onSaved: (value) {
                        formData["bookingDate"] = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: defaultPadding,
              ),
              child: _loading
                  ? LoadingButton()
                  : DefaultButton(
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
