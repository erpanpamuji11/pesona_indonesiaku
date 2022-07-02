import 'package:core/presentation/pages/home_page.dart';
import 'package:core/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:wishlist/presentation/pages/wishlist_page.dart';

class ParentPage extends StatefulWidget {
  static const routeName = '/ParentPage';

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
    SearchPage(),
    const WishlistPage(),
    const ProfilePage()
  ];

  //back Exit app
  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          const message = 'Press again to Exit';
          Fluttertoast.showToast(msg: message, backgroundColor: Colors.black38);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
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
                title: const Text("Wishlist")),
            SalomonBottomBarItem(
                icon: const Icon(Icons.person), title: const Text("Profile")),
          ],
        ),
      ),
    );
  }
}
