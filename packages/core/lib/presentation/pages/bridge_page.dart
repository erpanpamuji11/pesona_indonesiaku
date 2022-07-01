import 'package:core/presentation/pages/ParentPage.dart';
import 'package:core/presentation/pages/onboarding_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BridgePage extends StatelessWidget {
  static const routeName = "/bridgePage";
  const BridgePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const SnackBar(content: Text("Terjadi Sedikit Masalah"));
          } else if (snapshot.hasData) {
            return const ParentPage();
          } else {
            return const OnBoardingPage();
          }
        },
      ),
    );
  }
}
