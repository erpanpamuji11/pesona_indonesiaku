import 'package:core/presentation/pages/akun/profile_page.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:wishlist/presentation/pages/wishlist_page.dart';

class ParentPage extends StatefulWidget {
  static const ROUTE_NAME = '/ParentPage';

  const ParentPage({Key? key}) : super(key: key);

  @override
  State<ParentPage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;

  final _screen = <Widget>[
    HomePage(),
    SearchPage(),
    WishlistPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
          ),
          SalomonBottomBarItem(
              icon: const Icon(Icons.search), title: const Text("Search")),
          SalomonBottomBarItem(
              icon: const Icon(Icons.favorite_border_outlined),
              title: const Text("favorite")),
          SalomonBottomBarItem(
              icon: const Icon(Icons.person), title: const Text("Profile")),
        ],
      ),
    );
  }
}
