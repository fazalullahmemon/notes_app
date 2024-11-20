import 'package:flutter/material.dart';
import 'package:notes_app/utils/relative_sizer.dart';

class PrimaryButtonWidget extends StatelessWidget {
  const PrimaryButtonWidget(
      {required this.onPressed, required this.text, this.width, super.key});
  final Function onPressed;
  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        child: Text(text),
      ),
    );
  }
}
