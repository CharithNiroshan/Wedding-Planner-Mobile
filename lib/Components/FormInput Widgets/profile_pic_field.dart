import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePictureField extends StatefulWidget {
  const ProfilePictureField({required this.onSaved, this.initialValue});

  final Function(String?) onSaved;
  final String? initialValue;
  @override
  State<ProfilePictureField> createState() => _ProfilePictureFieldState();
}

class _ProfilePictureFieldState extends State<ProfilePictureField> {
  FilePickerResult? result;
  String? image;
  final imageInput = TextEditingController();

  void initState() {
    if (widget.initialValue != null) {
      setState(() {
        image = widget.initialValue;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80.0,
            backgroundImage: image != null
                ? NetworkImage('https://$domainName/$image')
                : NetworkImage(
                    'https://$domainName/images/1643876626175-Empty Profile Icon.png'),
          ),
          Visibility(
            visible: false,
            child: TextFormField(
              onSaved: widget.onSaved(image),
            ),
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
        image = response["data"];
      });
    } catch (err) {
      throw err;
    }
  }
}
