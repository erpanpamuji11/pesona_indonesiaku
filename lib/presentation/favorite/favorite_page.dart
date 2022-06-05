import 'package:flutter/material.dart';

class FavoriteApp extends StatelessWidget {
  static const routeName = "/favoritePage";
  const FavoriteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                'Temukan Wisata dan UMKM Terbaikmu',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
