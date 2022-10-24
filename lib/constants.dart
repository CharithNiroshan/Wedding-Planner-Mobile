import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

const domainName = "magulalk.herokuapp.com";
const primaryColor = Color(0xFF001E3C);
const secondaryColor = Color(0xFF289CCA);
const textPrimaryColor = Color(0xFF2E2D2D);
const textSecondaryColor = Color(0xFF4F4F4F);
const animationDuration = Duration(microseconds: 200);
const defaultPadding = 16.0;

OutlineInputBorder textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor.withOpacity(0.1),
  ),
);

OutlineInputBorder searchBoxBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(28)),
  borderSide: BorderSide(
    color: Colors.black,
  ),
);

const emailError = 'Enter a valid email address';
const requiredField = "This field is required";

final passwordValidator = MultiValidator(
  [
    RequiredValidator(
      errorText: 'Password is required',
    ),
    MinLengthValidator(
      8,
      errorText: 'Password must be at least 8 digits long',
    ),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Passwords must have at least one special character'),
  ],
);

final emailValidator = MultiValidator(
  [
    RequiredValidator(
      errorText: "Email is required",
    ),
    EmailValidator(
      errorText: "Email Address not valid",
    )
  ],
);

final contactNoValidator = MultiValidator(
  [
    RequiredValidator(
      errorText: "Contact Number is required",
    ),
    PatternValidator(
      "/^(0|(?:\+94))7[0,1,2,5,6,7,8]{1}[0-9]{7}/",
      errorText: 'Contact Number Invalid',
    )
  ],
);
