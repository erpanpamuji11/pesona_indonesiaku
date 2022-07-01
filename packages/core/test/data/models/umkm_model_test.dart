import 'package:core/data/models/umkm_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const modelUmkmTest = Umkm(
    name: 'name',
    address: 'address',
    category: 'category',
    description: 'description',
    imgUrl: 'imgUrl',
  );

  final umkmTest = modelUmkmTest.toEntity();

  test('should be a subclass of UMKM entity', () async {
    final result = modelUmkmTest.toEntity();
    expect(result, umkmTest);
  });
}
