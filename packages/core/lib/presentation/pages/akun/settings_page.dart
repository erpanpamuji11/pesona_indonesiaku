import 'package:core/common/styles/theme.dart';
import 'package:core/presentation/bloc/my_theme/bloc/theme_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settingPage';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SharedPreferences preferences;
  late bool isNotified = false;
  late bool isThemed = false;

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

    bool? pilihanNotif = preferences.getBool('isDaily');
    if (pilihanNotif == null) return;

    setState(() {
      this.isNotified = pilihanNotif;
    });

    //theme
    preferences = await SharedPreferences.getInstance();

    bool? pilihanTheme = preferences.getBool('isTheme');
    if (pilihanTheme == null) return;

    setState(() {
      this.isThemed = pilihanTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Settings',
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nyalakan Notifikasi'),
                    Switch.adaptive(
                        value: isNotified,
                        onChanged: (value) async {
                          setState(() {
                            isNotified = value;
                            if (isNotified == true) {
                              FirebaseMessaging.instance
                                  .subscribeToTopic('wisata');
                              preferences.setBool("isDaily", isNotified);
                            }
                            if (isNotified == false) {
                              FirebaseMessaging.instance
                                  .unsubscribeFromTopic('wisata');
                              preferences.setBool('isDaily', isNotified);
                            }
                          });
                        }),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tema Gelap'),
                    Switch.adaptive(
                        value: isThemed,
                        onChanged: (value) async {
                          isThemed = value;
                          setState(() {
                            if (value == true) {
                              BlocProvider.of<ThemeBloc>(context).add(
                                  const ThemeChanged(
                                      theme: AppTheme.DarkTheme));
                              preferences.setBool("isTheme", isThemed);
                            }
                            if (value == false) {
                              BlocProvider.of<ThemeBloc>(context).add(
                                  const ThemeChanged(
                                      theme: AppTheme.LightTheme));
                              preferences.setBool("isTheme", isThemed);
                            }
                          });
                        }),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
