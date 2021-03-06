import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/data/models/wisata_model.dart';
import 'package:core/widgets/fetchUmkm.dart';
import 'package:core/widgets/iconInfo.dart';
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
                  errorBuilder: (context, url, error) => Center(
                    child: Text('Failed to Load this Image'),
                  ),
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
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    IconInfo(
                      text: wisata.category,
                      icon: Icons.category_outlined,
                    ),
                    IconInfo(
                      text: wisata.address,
                      icon: Icons.map_outlined,
                    ),
                    IconInfo(
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
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.all(10),
            height: 70,
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
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(10)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0.3),
                      ),
                      onPressed: () async {
                        addToWishlist();
                      },
                      child: Text(
                        'Tambah Ke Wishlist',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    );
                  } else {
                    return ElevatedButton(
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(10)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0.3),
                      ),
                      onPressed: () async {
                        removeWishlist();
                      },
                      child: const Text(
                        'Hapus Ke Wishlist',
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
