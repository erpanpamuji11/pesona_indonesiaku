import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pesona_indonesiaku_app/common/styles/colors.dart';
import 'package:pesona_indonesiaku_app/data/database_services.dart';
import 'package:pesona_indonesiaku_app/presentation/widgets/categorries.dart';
import 'package:pesona_indonesiaku_app/presentation/wisata/list_wisata_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 4, vsync: this);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200.0,
          elevation: 0,
          pinned: true,
          floating: true,
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            titlePadding: EdgeInsets.only(left: 20, bottom: 70, right: 30),
            background: Image.asset(
              "assets/images/Bali.jpg",
              fit: BoxFit.cover,
            ),
            stretchModes: [
              StretchMode.zoomBackground,
            ],
            title: Text(
              "Discover \nPesona Indonesia",
              style: TextStyle(color: Colors.white, fontSize: 28.0),
            ),
          ),
          bottom: AppBar(
            toolbarHeight: 70,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      cursorColor: kDavysGrey,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        hintText: "Masukan Wisata Impianmu",
                        hintStyle:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Column(
              children: [
                Categories(),
                Column(
                  children: [
                    Divider(height: 5, thickness: 5),
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          height: 380,
                          width: double.maxFinite,
                          child: FutureBuilder<QuerySnapshot>(
                            future: DatabaseServices()
                                .firestoreRef
                                .collection('wisata')
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasData &&
                                  snapshot.data!.docs.isNotEmpty) {
                                List<DocumentSnapshot> arrData =
                                    snapshot.data!.docs;
                                print(arrData.length);
                                return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 20.0,
                                    crossAxisSpacing: 20.0,
                                    childAspectRatio: 0.75,
                                  ),
                                  itemCount: 6,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {},
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 400,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      offset: Offset(
                                                        3.0,
                                                        3.0,
                                                      ),
                                                      blurRadius: 5.0,
                                                      spreadRadius: 1.0,
                                                    ), //BoxShadow
                                                  ]),
                                            ),
                                            Container(
                                              height: 400,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 200,
                                                      width: double.maxFinite,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0)),
                                                      child: Image.network(
                                                        arrData[index]
                                                            ['imgUrl'],
                                                        fit: BoxFit.cover,
                                                        scale: 1.0,
                                                        loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          } else {
                                                            return Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                value: loadingProgress
                                                                            .expectedTotalBytes !=
                                                                        null
                                                                    ? loadingProgress
                                                                            .cumulativeBytesLoaded /
                                                                        loadingProgress
                                                                            .expectedTotalBytes!
                                                                    : null,
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            bottom: 10,
                                                            top: 2),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          arrData[index]
                                                              ['name'],
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .location_on_rounded,
                                                              size: 12,
                                                              color: Colors
                                                                  .lightBlue,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              arrData[index]
                                                                  ['provincy'],
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ));
                                  },
                                );
                              } else {
                                return const Center(
                                  child: Text('Data not found'),
                                );
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: _buildSubHeading(
                              title: "Wisata Terbaik",
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ListWisataPage.routeName);
                              }),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 5,
                  thickness: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSub("Majukan Wisata dan UMKM di Indonesia"),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _cardView(),
                            SizedBox(
                              width: 10,
                            ),
                            _cardView(),
                            SizedBox(
                              width: 10,
                            ),
                            _cardView()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 5,
                  thickness: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSub("Bantuan dan Cara Penggunaan"),
                      Container(
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _cardView(),
                            SizedBox(
                              width: 10,
                            ),
                            _cardView(),
                            _cardView()
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ]),
        )
      ],
    );
  }

  Row _buildSubHeading({required String title, Function()? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Lihat Semua',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  _buildSub(String title) {
    return Container(
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container _cardView() {
    return Container(
      height: 100,
      width: 220,
      decoration: BoxDecoration(
          color: Colors.lightBlue, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text('UMKM'),
      ),
    );
  }
}
