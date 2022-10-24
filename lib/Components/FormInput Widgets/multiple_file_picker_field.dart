import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/models/file_list.dart';
import 'package:open_file/open_file.dart';

class MultipleFilePickField extends StatefulWidget {
  @override
  State<MultipleFilePickField> createState() => _MultipleFilePickFieldState();
}

class _MultipleFilePickFieldState extends State<MultipleFilePickField> {
  FilePickerResult? result;
  List<PlatformFile> files = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cover Photos",
              ),
              IconButton(
                onPressed: () {
                  pickFiles();
                },
                icon: Icon(
                  Icons.upload,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Column(
            children: [
              FileList(
                files: files,
                onOpendFile: viewFile,
              ),
            ],
          ),
          const SizedBox(
            height: defaultPadding,
          ),
        ],
      ),
    );
  }

  void pickFiles() async {
    result = (await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg", "jpeg", "png"],
      allowMultiple: true,
    ))!;
    setState(() {
      files = result!.files;
    });
  }

  void viewFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}
