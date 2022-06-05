import 'package:flutter/material.dart';
import 'package:pesona_indonesiaku_app/presentation/home_page.dart';
import 'package:pesona_indonesiaku_app/presentation/wisata/input_wisata_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
    const HomePage(),
    const InputWisataPage(),
    const InputWisataPage(),
    const InputWisataPage()
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
              icon: const Icon(Icons.star), title: const Text("favorite")),
          SalomonBottomBarItem(
              icon: const Icon(Icons.person), title: const Text("Profile")),
        ],
      ),
    );
  }
}
