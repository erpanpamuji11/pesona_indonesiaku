import 'package:core/data/models/wisata_model.dart';

abstract class BaseWisataRepository {
  Stream<List<Wisata>> getAllWisata();
}
