import 'dart:convert';

import 'package:fikratechno/core/error/exceptions.dart';
import 'package:fikratechno/features/login/data/models/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String CACHED_TOKEN = 'CACHED_TOKEN';

abstract class LoginLocalDataSource {
  /// Gets the cached [TokenModel] which contains the token
  ///
  /// Throws [CacheException] if no cached token is present
  Future<TokenModel> getLastToken();

  /// Caches the [LoginModel] which contains the token
  Future<void> cacheToken(TokenModel tokenToCache);
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<TokenModel> getLastToken() {
    final jsonToken = sharedPreferences.getString(CACHED_TOKEN);
    if (jsonToken != null) {
      return Future.value(TokenModel.fromJson(json.decode(jsonToken)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheToken(TokenModel tokenToCache) {
    return sharedPreferences.setString(
      CACHED_TOKEN,
      json.encode(tokenToCache.toJson()),
    );
  }
}
