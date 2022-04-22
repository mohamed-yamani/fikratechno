import 'dart:convert';

import 'package:fikratechno/core/error/exceptions.dart';
import 'package:fikratechno/features/login/data/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class LoginRemoteDataSource {
  /// calls the https://matricule.icebergtech.net/api/token-auth/ to get the token
  ///
  /// returns a [LoginModel] which contains the token
  ///
  /// Throws a [ServerException] for all error codes (500, 404, 401, etc)
  Future<TokenModel> loginIn(String username, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({@required this.client});

  @override
  Future<TokenModel> loginIn(String username, String password) async {
    final response = await client.post(
        Uri.http('matricule.icebergtech.net', '/api/token-auth/'),
        body: {'username': username, 'password': password});
    if (response.statusCode == 200) {
      return Future.value(TokenModel.fromJson(json.decode(response.body)));
    } else {
      throw ServerException();
    }
  }
}
