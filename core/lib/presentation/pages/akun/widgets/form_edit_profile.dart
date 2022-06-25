import 'package:flutter/material.dart';

class FormEditProfile extends StatefulWidget {
  const FormEditProfile({Key? key}) : super(key: key);

  @override
  State<FormEditProfile> createState() => _FormEditProfileState();
}

class _FormEditProfileState extends State<FormEditProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                hintText: 'Nama Lengkap'),
          ),
        ),
      ],
    );
  }
}
