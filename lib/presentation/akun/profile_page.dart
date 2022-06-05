import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pesona_indonesiaku_app/presentation/akun/change_password_page.dart';
import 'package:pesona_indonesiaku_app/presentation/akun/edit_profile_page.dart';
import 'package:pesona_indonesiaku_app/presentation/akun/settings_page.dart';
import 'package:pesona_indonesiaku_app/presentation/akun/widgets/menu_profile_button.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "/profilePage";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.lightBlue,
        elevation: 0,
        title: const Text(
          'Profile',
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
                  children: const [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/fotoProfil.jpg'),
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
              MenuProfileButton(
                iconButton: 'assets/icons/Profile.svg',
                textButton: 'Edit Profil',
                pressButton: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfilePage(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              MenuProfileButton(
                iconButton: 'assets/icons/Lock.svg',
                textButton: 'Ubah Kata Sandi',
                pressButton: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordPage(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              MenuProfileButton(
                iconButton: 'assets/icons/Setting.svg',
                textButton: 'Pengaturan',
                pressButton: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              MenuProfileButton(
                iconButton: 'assets/icons/Logout.svg',
                textButton: 'Keluar',
                pressButton: () => FirebaseAuth.instance.signOut(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
