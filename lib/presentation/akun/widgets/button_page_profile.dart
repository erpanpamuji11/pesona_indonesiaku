import 'package:flutter/material.dart';

class ButtonPageProfile extends StatelessWidget {
  const ButtonPageProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              padding: MaterialStateProperty.all(const EdgeInsets.only(
                  left: 60, right: 60, top: 15, bottom: 15)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              side: MaterialStateProperty.all(
                BorderSide(
                  width: 1.0,
                  color: Colors.blue.shade700,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            onPressed: () {},
            child: const Center(
              child: Text(
                'Batal',
                style: TextStyle(
                  color: Color.fromARGB(255, 25, 118, 210),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blue.shade700),
              padding: MaterialStateProperty.all(const EdgeInsets.only(
                  left: 60, right: 60, bottom: 15, top: 15)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            onPressed: () {},
            child: const Center(
              child: Text('Simpan'),
            ),
          ),
        ),
      ],
    );
  }
}
