import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pesona_indonesiaku_app/presentation/akun/profile_page.dart';
import 'package:pesona_indonesiaku_app/presentation/akun/widgets/button_page_profile.dart';
import 'package:pesona_indonesiaku_app/presentation/akun/widgets/form_edit_profile.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Edit Profil',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 120,
                width: 120,
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/fotoProfil.jpg'),
                    ),
                    Positioned(
                      right: -5,
                      bottom: 0,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.grey.shade100),
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: SvgPicture.asset(
                            'assets/icons/Camera.svg',
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                user.email!,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const FormEditProfile(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          const ButtonPageProfile(),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
