import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pesona_indonesiaku_app/data/database_services.dart';
import 'package:pesona_indonesiaku_app/data/database_services.dart';
import 'package:pesona_indonesiaku_app/data/models/wisata_model.dart';
import 'package:pesona_indonesiaku_app/data/models/wisata_model.dart';
import 'package:pesona_indonesiaku_app/data/models/wisata_model.dart';

class DetailWisataPage extends StatefulWidget {
  static const routeName = "/detailWisata";
  const DetailWisataPage({Key? key}) : super(key: key);

  @override
  State<DetailWisataPage> createState() => _DetailWisataPageState();
}

class _DetailWisataPageState extends State<DetailWisataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: DatabaseServices.readWisata(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final wisata = snapshot.data!;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.black26,
                      child: Icon(Icons.arrow_back),
                    )
                  ],
                ),
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(20),
                    child: Container(
                      color: Colors.white,
                      child: const Center(child: Text('Sliver APP')),
                      width: double.maxFinite,
                      padding: const EdgeInsets.only(top: 5, bottom: 10),
                    )),
                pinned: true,
                backgroundColor: Colors.lightBlue,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    '$Wisata().im',
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    Column(
                      children: const [
                        IconName(
                          text: "text",
                          icon: Icons.location_city,
                        ),
                        IconName(
                          text: 'Alamat Lengkap',
                          icon: Icons.local_cafe,
                        )
                      ],
                    ),
                    Container(
                      child: const Text(
                          'Here BorderRadius.horizontal has been used to add a border around the corners. Inside the  BorderRadius.horizontal widget the left property is holding Radius.circular(15), which gives the left side of the border (i.e. the top-left and bottom,-left) a radius of 15 pixels and the right property is holding Radius.circular(30), which in turn gives the right portion of the border a radius of 30 pixels.'),
                    )
                  ],
                ),
              ))
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Data Tidak Dapat dimuat');
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}

class IconName extends StatelessWidget {
  final String text;
  final IconData? icon;
  const IconName({Key? key, required this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 20,
          color: Colors.lightGreen,
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: 290,
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }
}
