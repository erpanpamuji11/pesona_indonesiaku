import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget fetchUmkm(String collectionName, String docName) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(collectionName)
        .doc(docName)
        .collection('umkm-wisata')
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Center(
          child: Text("Something is wrong"),
        );
      }

      return ListView.builder(
          itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
          itemBuilder: (_, index) {
            DocumentSnapshot umkm = snapshot.data!.docs[index];

            return ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                umkm['imgUrl'],
                                width: 90.0,
                                height: 90.0,
                                fit: BoxFit.cover,
                                errorBuilder: (context, url, error) =>
                                    const Text('Failed load image'),
                              )),
                        ),
                        const SizedBox(width: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                umkm['name'],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              IconInfo(
                                text: umkm['category'],
                                icon: Icons.location_on_rounded,
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              IconInfo(
                                text: umkm['address'],
                                icon: Icons.category_outlined,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            );
          });
    },
  );
}

class IconInfo extends StatelessWidget {
  final String text;
  final IconData? icon;
  const IconInfo({Key? key, required this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.lightGreen,
        ),
        const SizedBox(
          width: 3.0,
        ),
        SizedBox(
          width: 160,
          child: Text(text),
        )
      ],
    );
  }
}
