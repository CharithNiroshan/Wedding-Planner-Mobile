import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/Other%20Widgets/default_button.dart';
import 'package:magula_mobile/constants.dart';
import 'package:http/http.dart' as http;
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Common%20Pages/SignUp%20Page/sign_up_screen.dart';
import 'package:provider/provider.dart';

class SetupForm1 extends StatefulWidget {
  const SetupForm1({Key? key, required this.onNext}) : super(key: key);
  final VoidCallback onNext;

  @override
  _SetupForm1State createState() => _SetupForm1State();
}

class _SetupForm1State extends State<SetupForm1> {
  bool _loading = false;
  FilePickerResult? result;
  Map<String, dynamic> formData = {
    "logo": null,
  };

  void onSubmit() async {
    print("Inside OnNext");
    if (formData["logo"] != null) {
      try {
        setState(() {
          _loading = true;
        });
        await Provider.of<Auth>(context, listen: false)
            .updateVendorProfile(formData);
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
          "Select Logo",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 80.0,
                backgroundImage: formData["logo"] != null
                    ? NetworkImage('https://$domainName/${formData["logo"]}')
                    : NetworkImage(
                        'https://$domainName/images/1643876626175-Empty Profile Icon.png'),
              ),
              Positioned(
                bottom: 0,
                right: 15,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: primaryColor,
                  ),
                  child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      onTap: () {
                        pickImage();
                      }),
                ),
              ),
            ],
          ),
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

  void pickImage() async {
    result = (await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    ))!;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.http(
          domainName,
          "file-upload/file",
        ),
      );
      request.files.add(http.MultipartFile(
        'file',
        File(result!.files[0].path as String).readAsBytes().asStream(),
        File(result!.files[0].path as String).lengthSync(),
        filename: result!.files[0].name,
      ));

      var responseStream = await request.send();

      var responseString = await responseStream.stream.bytesToString();
      var response = json.decode(responseString);

      setState(() {
        formData["logo"] = response["data"];
      });
    } catch (err) {
      throw err;
    }
  }
}
