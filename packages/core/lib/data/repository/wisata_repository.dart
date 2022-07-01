import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/data/models/wisata_model.dart';
import 'package:core/data/repository/base_wisata_repository.dart';

class WisataRepository extends BaseWisataRepository {
  final FirebaseFirestore _firebaseFirestore;

  WisataRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Wisata>> getAllWisata() {
    return _firebaseFirestore.collection('wisata').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Wisata.fromSnapshot(doc)).toList());
  }
}
