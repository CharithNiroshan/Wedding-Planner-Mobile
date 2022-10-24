import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
    this.isDisabled,
  }) : super(key: key);

  final String? text;
  final void Function()? press;
  final bool? isDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          text as String,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: press,
      ),
    );
  }
}
