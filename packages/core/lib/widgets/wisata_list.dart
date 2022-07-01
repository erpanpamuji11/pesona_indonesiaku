import 'package:core/data/models/wisata_model.dart';
import 'package:core/widgets/wisata_card.dart';
import 'package:flutter/material.dart';

class WisataList extends StatelessWidget {
  final List<Wisata> wisata;
  const WisataList({
    Key? key,
    required this.wisata,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          childAspectRatio: 0.75,
        ),
        itemCount: wisata.length,
        itemBuilder: (context, index) {
          return WisataCard(wisata: wisata[index]);
        });
  }
}
