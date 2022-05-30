import 'package:flutter/material.dart';
import 'package:core/presentation/ParentPage.dart';
import 'package:home/presentation/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pesona Indonesiaku",
      home: ParentPage(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case ParentPage.ROUTE_NAME:
            return MaterialPageRoute(builder: (_) => const ParentPage());
          case HomePage.ROUTE_NAME:
            return MaterialPageRoute(builder: (_) => const HomePage());
        }
      },
    );
  }
}

