import 'package:authentication/presentation/pages/login_page.dart';
import 'package:core/presentation/pages/ParentPage.dart';
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
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return SnackBar(content: Text("Terjadi Sedikit Masalah"));
          } else if (snapshot.hasData) {
            return ParentPage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}