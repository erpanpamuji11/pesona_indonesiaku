import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuProfileButton extends StatelessWidget {
  const MenuProfileButton(
      {Key? key,
      required this.textButton,
      required this.iconButton,
      required this.pressButton})
      : super(key: key);

  final String textButton, iconButton;
  final VoidCallback pressButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.grey.shade50),
          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
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
              color: Colors.blue.shade700,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                textButton,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade600,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
