import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:wisata/presentation/home_page.dart';
import 'package:wisata/presentation/input_page.dart';

class ParentPage extends StatefulWidget {
  static const ROUTE_NAME = '/ParentPage';

  const ParentPage({Key? key}) : super(key: key);

  @override
  State<ParentPage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  final _screen = <Widget>[
    HomePage(),
    InputWisataPage(),
    InputWisataPage(),
    InputWisataPage()
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
              icon: const Icon(Icons.star), title: const Text("Input")),
          SalomonBottomBarItem(
              icon: const Icon(Icons.person), title: const Text("Profile")),
        ],
      ),
    );
  }
}
