import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/common/styles/colors.dart';
import 'package:core/widgets/categorries.dart';
import 'package:core/widgets/wisata_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:wisata/presentation/bloc/wisata_bloc.dart';
import 'package:wisata/presentation/pages/list_wisata_page.dart';

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
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, SearchPage.routeName),
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
                          hintStyle: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
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
                          child: BlocBuilder<WisataBloc, WisataState>(
                            builder: ((context, state) {
                              if (state is WisataLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is WisataLoaded) {
                                return CarouselSlider(
                                    items: state.wisata
                                        .map((e) => WisataCard(wisata: e))
                                        .toList(),
                                    options: CarouselOptions(
                                        aspectRatio: 1.5,
                                        viewportFraction: 0.9,
                                        enlargeCenterPage: true,
                                        enlargeStrategy:
                                            CenterPageEnlargeStrategy.height,
                                        enableInfiniteScroll: true,
                                        initialPage: 2));
                              } else {
                                return Text('Error');
                              }
                            }),
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
