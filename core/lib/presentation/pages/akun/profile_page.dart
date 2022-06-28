import 'package:authentication/presentation/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/presentation/pages/akun/change_password_page.dart';
import 'package:core/presentation/pages/akun/edit_profile_page.dart';
import 'package:core/presentation/pages/akun/settings_page.dart';
import 'package:core/presentation/pages/akun/widgets/menu_profile_button.dart';
import 'package:core/presentation/pages/pick_wisata.dart';
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
              profileCard(),
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
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
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
                              child: ElevatedButton(
                                child: const Text('Tambah Data Wisata'),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, InputWisataPage.routeName);
                                },
                              )),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ElevatedButton(
                                child: const Text('Tambah Data UMKM'),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, PickWisata.routeName);
                                },
                              )),
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
                  showDialog(context: context, builder: (context) => AlertDialog(
                    content: Text('Keluar dari akun ini?'),
                    buttonPadding: EdgeInsets.all(20),
                    actions: [
                      GestureDetector(onTap: () => Navigator.pop(context, false), child: Text('No')),
                      SizedBox(width: 20,),
                      GestureDetector(onTap: () => FirebaseAuth.instance.signOut().then((value) => Navigator.pushNamed(context, LoginPage.routeName)), child: Text('Yes'))
                    ],
                  ));
                }
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget profileCard() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users-form-data')
          .doc(currentUser!.email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        var data = snapshot.data;
        if (data == null) {
          return Container(
            margin: const EdgeInsets.only(left: 15),
            child: Row(
              children: const [
                SizedBox(
                  width: 10,
                ),
                Text(
                  '',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }
        return Container(
          margin: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hai ${data['nickName']}!',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${currentUser.email}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
