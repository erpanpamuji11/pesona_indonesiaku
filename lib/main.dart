import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pesona_indonesiaku_app/presentation/ParentPage.dart';
import 'package:pesona_indonesiaku_app/presentation/bridge_page.dart';
import 'package:pesona_indonesiaku_app/presentation/home_page.dart';
import 'package:pesona_indonesiaku_app/presentation/login/pages/login_page.dart';
import 'package:pesona_indonesiaku_app/presentation/login/pages/signup_page.dart';
import 'package:pesona_indonesiaku_app/presentation/splash_screen.dart';
import 'package:pesona_indonesiaku_app/presentation/wisata/detail_wisata_page.dart';
import 'package:pesona_indonesiaku_app/presentation/wisata/list_wisata_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: "Pesona Indonesiaku",
      home: const SplashScreen(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case ParentPage.ROUTE_NAME:
            return MaterialPageRoute(builder: (_) => const ParentPage());
          case HomePage.routeName:
            return MaterialPageRoute(builder: (_) => const HomePage());
          case ListWisataPage.routeName:
            return MaterialPageRoute(builder: (_) => const ListWisataPage());
          case DetailWisataPage.routeName:
            return MaterialPageRoute(builder: (_) => const DetailWisataPage());
          case LoginPage.routeName:
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case BridgePage.routeName:
            return MaterialPageRoute(builder: (_) => const BridgePage());
          case SignUpPage.routeName:
            return MaterialPageRoute(builder: (_) => const SignUpPage());
        }
        return null;
      },
    );
  }
}
