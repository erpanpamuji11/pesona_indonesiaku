import 'package:carousel_slider/carousel_slider.dart';
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              height: 190,
              decoration: const BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileNameTitle(),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Discover \nPesona Indonesiaku',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, SearchPage.routeName),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Temukan Wisata Terbaik dan UMKM Sekitarnya',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Categories(),
            Column(
              children: [
                const Divider(
                  height: 5,
                  thickness: 3,
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 348,
                      width: double.maxFinite,
                      child: BlocBuilder<WisataBloc, WisataState>(
                        builder: ((context, state) {
                          if (state is WisataLoading) {
                            return const Center(
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
                                  autoPlayInterval: const Duration(seconds: 6),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 900),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.height,
                                  enableInfiniteScroll: true,
                                  initialPage: 2),
                            );
                          } else {
                            return const Text('Error');
                          }
                        }),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
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
            const Divider(
              height: 5,
              thickness: 3,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                _buildSub("Majukan Wisata dan UMKM di Indonesia"),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      _cardView('assets/banner/banner1.png'),
                      const SizedBox(
                        width: 10,
                      ),
                      _cardView('assets/banner/banner2.png'),
                      const SizedBox(
                        width: 10,
                      ),
                      _cardView('assets/banner/banner3.png'),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                )
              ],
            ),
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
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            'Lihat Semua',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }

  _buildSub(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container _cardView(String imgUrl) {
    return Container(
        height: 100,
        width: 260,
        decoration: BoxDecoration(
            color: Colors.lightBlue, borderRadius: BorderRadius.circular(10)),
        child: Image.asset(imgUrl));
  }
}
