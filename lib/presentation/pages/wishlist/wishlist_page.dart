import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.lightBlue,
        title: Text('Wishlist'),
      ),
      //     BlocBuilder<WishlistBloc, WishlistState>(builder: (context, state) {
      //   if (state is WishlistLoading) {
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   } else if (state is WishlistLoaded) {
      //     return GridView.builder(
      //       padding: const EdgeInsets.symmetric(
      //         horizontal: 8,
      //         vertical: 16,
      //       ),
      //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 1,
      //         childAspectRatio: 2.2,
      //       ),
      //       itemCount: state.wishlist.wisatas.length,
      //       itemBuilder: (context, index) {
      //         return Center(
      //           child: WisataCard(
      //             wisata: state.wishlist.wisatas[index],
      //           ),
      //         );
      //       },
      //     );
      //   } else {
      //     return Text('Something went error');
      //   }
    );
  }
}
