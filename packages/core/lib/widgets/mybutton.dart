
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget myButton(VoidCallback pressButton, String textButton, iconButton){
  return ElevatedButton(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevation: MaterialStateProperty.all(0.3),
    ),
    onPressed: pressButton,
    child: Row(
      children: [
        SvgPicture.asset(
          iconButton,
          width: 24,
          height: 24,
          color: Colors.white,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            textButton,
          ),
        ),
      ],
    ),
  );
}