import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:core/presentation/ParentPage.dart';
import 'package:wisata/presentation/home_page.dart';
import 'package:wisata/presentation/list_wisata_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pesona Indonesiaku",
      home: const ParentPage(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case ParentPage.ROUTE_NAME :
            return MaterialPageRoute(builder: (_) => const ParentPage());
          case HomePage.routeName:
            return MaterialPageRoute(builder: (_) => const HomePage());
          case ListWisataPage.routeName:
            return MaterialPageRoute(builder: (_) => const ListWisataPage());
        }
        return null;
      },
    );
  }
}

