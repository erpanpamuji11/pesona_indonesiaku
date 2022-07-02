import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/common/styles/colors.dart';
import 'package:core/data/models/wisata_model.dart';
import 'package:core/widgets/myicon.dart';
import 'package:flutter/material.dart';
import 'package:wisata/presentation/pages/detail_wisata_page.dart';

class SearchPage extends StatefulWidget {
  static const routeName = "/searchPage";

  const SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var inputText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Temukan Wisata Pilihanmu dan UMKM Sekitarnya',
                style: TextStyle(
                    fontSize: 25,
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
                cursorColor: kDavysGrey,
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
                  hintText: "Cari Wisata dan UMKM disini...",
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
                        .where("name", isGreaterThan: inputText)
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
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
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
                                          context, DetailWisataPage.routeName,
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
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['name'],
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              IconInfo(
                                                text: data['provincy'],
                                                icon: Icons
                                                    .location_on_outlined,
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              IconInfo(
                                                text: data['category'],
                                                icon: Icons.category_outlined,
                                              ),
                                            ],
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
      ),
    );
  }
}
