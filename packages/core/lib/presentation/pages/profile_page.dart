import 'package:core/presentation/pages/akun/edit_profile_page.dart';
import 'package:core/presentation/pages/akun/settings_page.dart';
import 'package:core/presentation/pages/akun/widgets/menu_profile_button.dart';
import 'package:core/presentation/pages/onboarding_page.dart';
import 'package:core/presentation/pages/pick_wisata.dart';
import 'package:core/widgets/mybutton.dart';
import 'package:core/widgets/profile_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wisata/presentation/pages/input_wisata_page.dart';

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
        automaticallyImplyLeading: false,
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
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        profileText(),
                        Text(
                          '${user.email}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 5,
                thickness: 5,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: Colors.lightBlue,
                        width: 1.0,
                        style: BorderStyle.solid)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jadilah Duta Pariwisata dan UMKM Indonesia',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: myButton(() {Navigator.push(context, MaterialPageRoute(builder: (context) => const InputWisataPage()));}, 'Tambah Data Wisata', 'assets/icons/add.svg')),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: myButton(() {Navigator.push(context, MaterialPageRoute(builder: (context) => const PickWisata()));}, 'Tambah Data UMKM', 'assets/icons/add.svg')),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 5,
                thickness: 5,
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
                iconButton: 'assets/icons/Setting.svg',
                textButton: 'Pengaturan',
                pressButton: () {
                  Navigator.pushNamed(context, SettingsPage.routeName);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              MenuProfileButton(
                  iconButton: 'assets/icons/Logout.svg',
                  textButton: 'Keluar',
                  pressButton: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: const Text('Keluar dari akun ini?'),
                              buttonPadding: const EdgeInsets.all(20),
                              actions: [
                                GestureDetector(
                                    onTap: () => Navigator.pop(context, false),
                                    child: const Text('No')),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                    onTap: () => FirebaseAuth.instance
                                        .signOut()
                                        .then((value) => Navigator.pushNamed(
                                            context, OnBoardingPage.routeName)),
                                    child: const Text('Yes'))
                              ],
                            ));
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
