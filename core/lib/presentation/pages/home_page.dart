import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/common/styles/colors.dart';
import 'package:core/widgets/categorries.dart';
import 'package:core/widgets/profile_text.dart';
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileNameTitle(),
                  Text(
                    'Discover \nPesona Indonesia',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 40,
                      color: Colors.white
                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, SearchPage.routeName),
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.search),
                          Text('  Cari Wisata Terbaik dan UMKM Sekitar...')
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
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
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 6),
                                    autoPlayAnimationDuration:
                                    Duration(milliseconds: 900),
                                    autoPlayCurve: Curves.fastOutSlowIn,
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
        ),
      ),
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
