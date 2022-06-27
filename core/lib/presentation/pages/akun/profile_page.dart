import 'package:authentication/presentation/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/presentation/pages/akun/change_password_page.dart';
import 'package:core/presentation/pages/akun/edit_profile_page.dart';
import 'package:core/presentation/pages/akun/settings_page.dart';
import 'package:core/presentation/pages/akun/widgets/menu_profile_button.dart';
import 'package:core/presentation/pages/pick_wisata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:umkm/presentation/pages/input_umkm.dart';
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
              Divider(
                height: 5,
                thickness: 5,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: Colors.lightBlue,
                        width: 1.0,
                        style: BorderStyle.solid)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Jadilah Duta Pariwisata dan UMKM Indonesia',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
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
                                child: Text('Tambah Data Wisata'),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, InputWisataPage.routeName);
                                },
                              )),
                        ),
                        SizedBox(
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
                                child: Text('Tambah Data UMKM'),
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
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 5,
                thickness: 5,
              ),
              SizedBox(
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
                pressButton: () => FirebaseAuth.instance.signOut().then(
                    (value) =>
                        Navigator.pushNamed(context, LoginPage.routeName)),
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
            margin: EdgeInsets.only(left: 15),
            child: Row(
              children: [
                const SizedBox(
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
          margin: EdgeInsets.only(left: 15),
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
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${currentUser.email}',
                    style: TextStyle(
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
