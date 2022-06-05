import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pesona_indonesiaku_app/data/database_services.dart';

class ListWisataPage extends StatelessWidget {
  static const routeName = '/listWisata';
  const ListWisataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wisata Favoritmu"),
      ),
      body: Container(),
    );
  }
}
