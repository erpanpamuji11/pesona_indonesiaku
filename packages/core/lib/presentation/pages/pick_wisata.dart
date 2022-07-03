import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/data/models/wisata_model.dart';
import 'package:core/widgets/iconInfoRegular.dart';
import 'package:flutter/material.dart';
import 'package:umkm/presentation/pages/input_umkm.dart';

class PickWisata extends StatefulWidget {
  static const routeName = "/chooseWisata";

  const PickWisata({Key? key}) : super(key: key);
  @override
  _PickWisataState createState() => _PickWisataState();
}

class _PickWisataState extends State<PickWisata> {
  var inputText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input UMKM'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Lokasi UMKM-mu',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (val) {
                setState(() {
                  inputText = val;
                  print(inputText);
                });
              },
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                filled: true,
                prefixIcon: const Icon(
                  Icons.search,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Cari Wisata disini...",
                hintStyle: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("wisata")
                      .where("name", isGreaterThanOrEqualTo: inputText)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Text("Loading"),
                      );
                    }
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        return ClipRRect(
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
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, InputUmkmPage.routeName,
                                        arguments: Wisata(
                                            name: data['name'],
                                            address: data['address'],
                                            provincy: data['provincy'],
                                            category: data['category'],
                                            description: data['description'],
                                            imgUrl: data['imgUrl']));
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey),
                                        child: Hero(
                                          tag: data['name'],
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.network(
                                                data['imgUrl'],
                                                width: 100.0,
                                                height: 100.0,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, url,
                                                        error) =>
                                                    const Text(
                                                        'Failed load image'),
                                              )),
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['name'],
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              IconInfoRegular(
                                                text: data['provincy'],
                                                icon:
                                                    Icons.location_on_outlined,
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              IconInfoRegular(
                                                text: data['category'],
                                                icon: Icons.category_outlined,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        );
                      }).toList(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
