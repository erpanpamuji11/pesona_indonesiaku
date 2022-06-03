import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/styles/colors.dart';
import 'package:core/utils/database_services.dart';
import 'package:flutter/material.dart';
import 'package:wisata/presentation/list_wisata_page.dart';

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
          expandedHeight: 260.0,
          elevation: 0,
          pinned: true,
          floating: true,
          stretch: true,
          backgroundColor: Colors.lightBlue,
          flexibleSpace: const FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            titlePadding: EdgeInsets.only(left: 20, bottom: 100, right: 30),
            stretchModes: [
              StretchMode.zoomBackground,
            ],
            title: Text(
              "Discover \nPesona Indonsia",
              style: TextStyle(color: Colors.black, fontSize: 28.0),
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
                TabBar(
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.black,
                  indicatorColor: Colors.transparent,
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      text: "Alam",
                    ),
                    Tab(
                      text: "Budaya",
                    ),
                    Tab(
                      text: "Edukasi",
                    ),
                    Tab(
                      text: "Religi",
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  height: 310,
                  width: double.maxFinite,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      FutureBuilder<QuerySnapshot>(
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
                                crossAxisCount: 2,
                                mainAxisSpacing: 20.0,
                                crossAxisSpacing: 20.0,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: arrData.length,
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
                                                  BorderRadius.circular(10.0)),
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
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  child: Image.network(
                                                    arrData[index]['imgUrl'],
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
                                                margin: const EdgeInsets.only(
                                                    left: 10,
                                                    bottom: 10,
                                                    top: 2),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      arrData[index]['name'],
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      arrData[index]
                                                          ['provincy'],
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w300),
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
                      const Text('data'),
                      const Text('data'),
                      const Text('data'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildSubHeading(
                    title: "Wisata Favorite",
                    onTap: () =>
                        Navigator.pushNamed(context, ListWisataPage.routeName)),
                Container(
                  height: 500,
                  color: Colors.lightBlue,
                )
              ],
            )
          ]),
        )
      ],
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
