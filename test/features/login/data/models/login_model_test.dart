import 'dart:convert';

import 'package:fikratechno/features/login/data/models/login_model.dart';
import 'package:fikratechno/features/login/domain/entities/login.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final testtoken = TokenModel(token: 'test');

  test('should be a subclass of TokenModel entity', () {
    // assert
    expect(testtoken, isA<Token>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON token is a String', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('login_token.json'));
      // act
      final result = TokenModel.fromJson(jsonMap);
      // assert
      expect(result, testtoken);
      expect(result, isA<Token>());
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // act
      final result = testtoken.toJson();
      // assert
      final expectedMap = {'token': 'test'};
      expect(result, expectedMap);
    });
  });
}
