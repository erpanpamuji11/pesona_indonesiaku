

import 'package:pesona_indonesiaku_app/data/models/wisata_model.dart';

abstract class BaseWisataRepository {
  Stream<List<Wisata>> getAllWisata();
}
