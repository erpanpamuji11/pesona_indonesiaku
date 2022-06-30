import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/data/models/wisata_model.dart';
import 'package:core/widgets/myicon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wisata/presentation/pages/detail_wisata_page.dart';

Widget fetchWisata(String collectionName) {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser = _auth.currentUser;
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(collectionName)
        .doc(currentUser!.email)
        .collection('items')
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Center(
          child: Text("Something is wrong"),
        );
      }

      return ListView.builder(
          itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
          itemBuilder: (_, index) {
            DocumentSnapshot wisata = snapshot.data!.docs[index];

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, DetailWisataPage.routeName,
                          arguments: Wisata(
                              name: wisata['name'],
                              address: wisata['address'],
                              provincy: wisata['provincy'],
                              category: wisata['category'],
                              description: wisata['description'],
                              imgUrl: wisata['imgUrl']));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: const EdgeInsets.all(10.0),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey),
                                  child: Hero(
                                    tag: wisata['name'],
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Image.network(
                                          wisata['imgUrl'],
                                          width: 120.0,
                                          height: 120.0,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, url, error) =>
                                              const Text('Failed load image'),
                                        )),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        wisata['name'],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      IconInfo(
                                        text: wisata['category'],
                                        icon: Icons.location_on_rounded,
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      IconInfo(
                                        text: wisata['address'],
                                        icon: Icons.category_outlined,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 120.0,
                  child: GestureDetector(
                    child: const CircleAvatar(
                      backgroundColor: Colors.black12,
                      child: Icon(
                        Icons.remove_circle_outline_outlined,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection(collectionName)
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .collection("items")
                          .doc(wisata.id)
                          .delete();
                    },
                  ),
                ),
              ],
            );
          });
    },
  );
}
