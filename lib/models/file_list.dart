import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileList extends StatefulWidget {
  const FileList({Key? key, required this.files, required this.onOpendFile})
      : super(key: key);

  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpendFile;

  @override
  State<FileList> createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  void printFiles() {
    print(widget.files);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.files == [] ? 0 : 200,
      child: ListView.builder(
        itemCount: widget.files.length,
        itemBuilder: (context, index) {
          final file = widget.files[index];
          return buildListFile(file);
        },
      ),
    );
  }

  Widget buildListFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final size =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';

    return InkWell(
      child: ListTile(
        title: Text(
          file.name,
        ),
        subtitle: Text(
          size,
        ),
        trailing: Text(
          file.extension.toString().toUpperCase(),
        ),
      ),
      onTap: () {
        widget.onOpendFile(file);
      },
    );
  }
}
