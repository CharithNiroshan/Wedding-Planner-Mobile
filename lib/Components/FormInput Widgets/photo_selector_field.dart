import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:magula_mobile/Components/FormInput%20Widgets/text_field_name.dart';
import 'package:magula_mobile/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PhotoSelectorField extends StatefulWidget {
  const PhotoSelectorField({Key? key, required this.onSaved, this.initialValue})
      : super(key: key);

  final Function(String?) onSaved;
  final String? initialValue;
  @override
  State<PhotoSelectorField> createState() => _PhotoSelectorFieldState();
}

class _PhotoSelectorFieldState extends State<PhotoSelectorField> {
  FilePickerResult? result;
  String? image;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldName(text: "Cover Photo"),
        const SizedBox(
          height: 10,
        ),
        Visibility(
          visible: false,
          child: TextFormField(
            onSaved: widget.onSaved(image),
          ),
        ),
        Container(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade600,
                    width: 1,
                  ),
                  image: image == null
                      ? null
                      : DecorationImage(
                          image: NetworkImage(
                            'https://$domainName/$image',
                          ),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      color: image == null
                          ? Colors.transparent
                          : Colors.black.withOpacity(0.3)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            Icons.camera_alt,
                            color: image == null
                                ? Colors.grey.shade800
                                : Colors.white,
                            size: 50,
                          ),
                        ),
                        onTap: () {
                          pickImage();
                        },
                      ),
                      Text(
                        "Click to Select a Photo",
                        style: TextStyle(
                          color: image == null
                              ? Colors.grey.shade800
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: defaultPadding * 1.25,
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
        Uri.https(
          domainName,
          "file-upload/file",
        ),
      );
      var picture = http.MultipartFile(
        'file',
        File(result!.files[0].path as String).readAsBytes().asStream(),
        File(result!.files[0].path as String).lengthSync(),
        filename: result!.files[0].name,
      );
      request.files.add(picture);
      var responseStream = await request.send();
      var responseString = await responseStream.stream.bytesToString();
      var response = json.decode(responseString);
      setState(() {
        image = response["data"];
      });
    } catch (err) {
      print(err);
    }
  }
}
