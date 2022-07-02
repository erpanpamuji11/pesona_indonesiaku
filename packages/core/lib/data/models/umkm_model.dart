import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Umkm extends Equatable {
  final String name;
  final String address;
  final String category;
  final String description;
  final String imgUrl;

  const Umkm({
    required this.name,
    required this.address,
    required this.category,
    required this.description,
    required this.imgUrl,
  });

  static Umkm fromSnapshot(DocumentSnapshot snap) {
    Umkm wisata = Umkm(
      name: snap['name'],
      address: snap['address'],
      category: snap['category'],
      description: snap['description'],
      imgUrl: snap['imgUrl'],
    );
    return wisata;
  }

  Umkm toEntity() {
    return Umkm(
      name: name,
      address: address,
      category: category,
      description: description,
      imgUrl: imgUrl,
    );
  }

  @override
  List<Object?> get props => [name, address, category, description, imgUrl];
}
