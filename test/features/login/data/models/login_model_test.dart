import 'package:fikratechno/features/login/data/models/login_model.dart';
import 'package:fikratechno/features/login/domain/entities/login.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testtoken = TokenModel(token: 'test');

  test('should be a subclass of TokenModel entity', () {
    // assert
    expect(testtoken, isA<Token>());
  });
}
