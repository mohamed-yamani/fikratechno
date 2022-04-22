import 'package:fikratechno/features/login/data/models/login_model.dart';
import 'package:fikratechno/features/login/domain/entities/login.dart';

abstract class LoginLocalDataSource {
  /// Gets the cached [TokenModel] which contains the token
  ///
  /// Throws [CacheException] if no cached token is present
  Future<TokenModel> getCachedToken();

  /// Caches the [LoginModel] which contains the token
  Future<void> cacheToken(TokenModel tokenToCache);
}
