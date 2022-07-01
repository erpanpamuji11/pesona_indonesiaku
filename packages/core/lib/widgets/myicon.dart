import 'package:flutter/material.dart';

class IconInfo extends StatelessWidget {
  final String text;
  final IconData? icon;
  const IconInfo({Key? key, required this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.lightBlue,
        ),
        const SizedBox(
          width: 3.0,
        ),
        SizedBox(
          width: 160,
          child: Text(text),
        )
      ],
    );
  }
}