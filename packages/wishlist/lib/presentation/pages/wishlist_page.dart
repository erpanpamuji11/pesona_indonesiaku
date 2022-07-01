import 'package:core/widgets/fetchWisata.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  static const routeName = '/wishlistPage';
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text('Wishlist'),
      ),
      body: SafeArea(child: fetchWisata('wishlist-wisata')),
    );
  }
}
