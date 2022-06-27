import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settingPage';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SharedPreferences preferences;
  late bool pilihan = true;

  void initState() {
    super.initState();

    //notifikasi diklik saat terminate
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print(message.notification!.title);
      }
    });

    //notifikasi diklik saat background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {});

    //ketika on background
    FirebaseMessaging.onMessage.listen((event) {
      print(event);
      if (event.notification != null) {
        //tambah notifikasi
        print(event.notification!.title);
      }
    });

    init();
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();

    bool? pilihan = preferences.getBool('isDaily');
    if (pilihan == null) return;

    setState(() {
      this.pilihan = pilihan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.lightBlue,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.lightBlue,
          ),
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nyalakan Notifikasi'),
              Switch.adaptive(
                  value: pilihan,
                  onChanged: (value) async {
                    setState(() {
                      pilihan = value;
                      if (pilihan == true) {
                        FirebaseMessaging.instance.subscribeToTopic('wisata');
                        preferences.setBool("isDaily", pilihan);
                      }
                      if (pilihan == false) {
                        FirebaseMessaging.instance
                            .unsubscribeFromTopic('wisata');
                        preferences.setBool('isDaily', pilihan);
                      }
                    });
                  }),
            ],
          )),
    );
  }
}
