import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pesona_indonesiaku_app/presentation/ParentPage.dart';
import 'package:pesona_indonesiaku_app/presentation/bridge_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacementNamed(context, BridgePage.routeName),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logoo_app.png',
          height: 300,
          width: 300,
        ),
      ),
    );
  }
}
