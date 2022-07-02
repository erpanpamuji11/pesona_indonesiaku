import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/data/models/wisata_model.dart';
import 'package:core/widgets/fetchUmkm.dart';
import 'package:core/widgets/myicon.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailWisataPage extends StatelessWidget {
  static const routeName = "/detailpage";
  final Wisata wisata;
  const DetailWisataPage({Key? key, required this.wisata}) : super(key: key);
  static Route route({required Wisata wisata}) {
    return MaterialPageRoute(
      // ignore: prefer_const_constructors
      settings: RouteSettings(name: routeName),
      // ignore: prefer_const_constructors
      builder: (_) => DetailWisataPage(
        wisata: wisata,
      ),
    );
  }

  Future addToWishlist() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("wishlist-wisata");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(wisata.name)
        .set({
      "name": wisata.name,
      "address": wisata.address,
      "provincy": wisata.provincy,
      "category": wisata.category,
      "description": wisata.description,
      "imgUrl": wisata.imgUrl,
    }).then((value) => Fluttertoast.showToast(
            msg: "Data Masuk Wishlist", backgroundColor: Colors.black54));
  }

  Future removeWishlist() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    return FirebaseFirestore.instance
        .collection("wishlist-wisata")
        .doc(currentUser!.email)
        .collection("items")
        .doc(wisata.name)
        .delete()
        .then((value) => Fluttertoast.showToast(
            msg: "Data Berhasil di Hapus", backgroundColor: Colors.black54));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: Colors.black38,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.lightBlue,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: wisata.name,
                child: Image.network(
                  wisata.imgUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
            margin: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      wisata.name,
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    IconName(
                      text: wisata.category,
                      icon: Icons.category_outlined,
                    ),
                    IconName(
                      text: wisata.address,
                      icon: Icons.map_outlined,
                    ),
                    IconName(
                      text: wisata.provincy,
                      icon: Icons.location_on_outlined,
                    ),
                  ],
                ),
                Card(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: double.maxFinite,
                    child: Text(
                      wisata.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                const Text(
                  'UMKM di Sekitar Wisata',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width,
                  child: fetchUmkm('umkm', wisata.name),
                )
              ],
            ),
          ))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.all(10),
            height: 60,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("wishlist-wisata")
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection("items")
                    .doc(wisata.name)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () async {
                        addToWishlist();
                      },
                      child: const Text(
                        'Tambah Ke Whislist',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () async {
                        removeWishlist();
                      },
                      child: const Text(
                        'Hapus Ke Whislist',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    );
                  }
                })),
      ),
    );
  }
}

class IconName extends StatelessWidget {
  final String text;
  final IconData? icon;
  const IconName({Key? key, required this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
              size: 22,
              color: Colors.lightBlue,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5)
      ],
    );
  }
}
