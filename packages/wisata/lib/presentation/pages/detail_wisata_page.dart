
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/data/models/wisata_model.dart';
import 'package:core/widgets/fetchUmkm.dart';
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
        .doc()
        .set({
      "name": wisata.name,
      "address": wisata.address,
      "provincy": wisata.provincy,
      "category": wisata.category,
      "description": wisata.description,
      "imgUrl": wisata.imgUrl,
    }).then((value) =>
            const SnackBar(content: Text('Wisata Berhasil Masuk ke Wishlist')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
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
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20)
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(wisata.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    const SizedBox(
                      height: 10,
                    ),
                    IconName(
                      text: wisata.category,
                      icon: Icons.category_outlined,
                    ),
                    IconName(
                      text: wisata.address,
                      icon: Icons.pin_drop_outlined,
                    ),
                    IconName(
                        text: wisata.provincy,
                        icon: Icons.location_on_rounded),
                  ],
                ),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: double.maxFinite,
                    child: Text(
                      wisata.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const Text('UMKM Sekitar',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(
                  height: 500,
                  child: fetchUmkm('umkm', wisata.name),
                )
              ],
            ),
          ))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          child: InkWell(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(10),
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightBlue),
              child: const Center(
                  child: Text(
                'Tambah Ke Whislist',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
            ),
          ),
          onTap: () {
            addToWishlist().then((value) => Fluttertoast.showToast(
                msg: 'Wisata ${wisata.name} Tersimpan',
                backgroundColor: Colors.lightBlue)).then((value) => null);
          },
        ),
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
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 22,
          color: Colors.lightBlue,
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: 290,
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
