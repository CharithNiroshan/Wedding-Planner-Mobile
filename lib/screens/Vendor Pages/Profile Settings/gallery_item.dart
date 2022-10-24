import 'package:flutter/material.dart';
import 'package:magula_mobile/constants.dart';
import 'package:magula_mobile/providers/auth.dart';
import 'package:provider/provider.dart';

class GalleryItem extends StatefulWidget {
  final String imgSrc;

  const GalleryItem({required this.imgSrc});

  @override
  State<GalleryItem> createState() => _GalleryItemState();
}

class _GalleryItemState extends State<GalleryItem> {
  bool _isLoading = false;

  void onDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmation"),
        content: Text("Do you want to confirm the delete request?"),
        actions: [
          TextButton(
            child: Text("Yes"),
            onPressed: () {
              delete();
            },
          ),
          TextButton(
            child: Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  void delete() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Auth>(context, listen: false)
          .deleteGalleryItem(widget.imgSrc);
      setState(() {
        _isLoading = false;
      });
    } on Exception catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: Stack(
          children: [
            Image.network(
              "https://$domainName/${widget.imgSrc}",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                color: Colors.black.withOpacity(0.4),
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    onDelete(context);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
