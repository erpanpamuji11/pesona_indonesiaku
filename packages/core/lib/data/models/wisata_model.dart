import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Wisata extends Equatable {
  final String name;
  final String address;
  final String provincy;
  final String category;
  final String description;
  final String imgUrl;

  const Wisata({
    required this.name,
    required this.address,
    required this.provincy,
    required this.category,
    required this.description,
    required this.imgUrl,
  });

  static Wisata fromSnapshot(DocumentSnapshot snap) {
    Wisata wisata = Wisata(
      name: snap['name'],
      address: snap['address'],
      provincy: snap['provincy'],
      category: snap['category'],
      description: snap['description'],
      imgUrl: snap['imgUrl'],
    );
    return wisata;
  }

  Wisata toEntity() {
    return Wisata(
      name: name,
      address: address,
      provincy: provincy,
      category: category,
      description: description,
      imgUrl: imgUrl,
    );
  }

  @override
  List<Object?> get props =>
      [name, address, provincy, category, description, imgUrl];
}
