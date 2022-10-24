import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:magula_mobile/screens/Vendor%20Pages/Profile%20Settings/gallery_item.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SettingsScreen05 extends StatefulWidget {
  @override
  _SettingsScreen05State createState() => _SettingsScreen05State();
}

class _SettingsScreen05State extends State<SettingsScreen05> {
  bool _loading = false;

  FilePickerResult? result;
  String? image;

  Future<void> onAdd() async {
    if (image != null) {
      try {
        setState(() {
          _loading = true;
        });
        await Provider.of<Auth>(context, listen: false)
            .addGalleryItem(image as String);
        setState(() {
          _loading = false;
        });
      } on Exception catch (error) {
        print(error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final auth = Provider.of<Auth>(context);
    final user = auth.user;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      margin: EdgeInsets.only(top: 10, bottom: defaultPadding),
      child: Stack(
        children: [
          user!["gallery"].length == 0
              ? Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(
                      "No Images/Videos in your gallery currently.",
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: user["gallery"].length,
                  itemBuilder: (context, index) {
                    return GalleryItem(
                      imgSrc: user["gallery"][index],
                    );
                  },
                ),
          Positioned(
            top: size.height - 250,
            right: 30,
            child: FloatingActionButton(
              backgroundColor: secondaryColor,
              child: Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: pickImage,
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
      onAdd();
    } catch (err) {
      print(err);
    }
  }
}
