import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/checkbox_group_field.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';

class SetupForm4 extends StatefulWidget {
  const SetupForm4({Key? key, required this.onNext}) : super(key: key);

  final VoidCallback onNext;
  @override
  _SetupForm4State createState() => _SetupForm4State();
}

class _SetupForm4State extends State<SetupForm4> {
  bool _loading = false;
  Map<String, dynamic> formData = {
    "services": null,
  };

  void onSubmit() {
    print(formData["service"]);
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Services",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        CheckboxGroupField(
          items: [
            "Service 01",
            "Service 02",
            "Service 03",
            "Service 04",
            "Service 05",
            "Service 06",
          ],
          onSaved: (List<String?> value) => formData["services"] = value,
        ),
        const SizedBox(
          height: defaultPadding * 2,
        ),
        _loading
            ? LoadingButton()
            : GestureDetector(
                onTap: () {
                  onSubmit();
                },
                child: Container(
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.only(top: 30, right: 15, left: 15, bottom: 15),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
