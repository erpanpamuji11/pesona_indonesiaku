import 'package:core/data/models/wisata_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const modelWisataTest = Wisata(
    name: 'name',
    address: 'address',
    provincy: 'provincy',
    category: 'category',
    description: 'description',
    imgUrl: 'imgUrl',
  );

  final wisataTest = modelWisataTest.toEntity();

  test('should be a subclass of Wisata Entity', () async {
    final result = modelWisataTest.toEntity();
    expect(result, wisataTest);
  });
}
