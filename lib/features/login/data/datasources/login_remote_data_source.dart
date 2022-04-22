import 'package:fikratechno/features/login/data/models/login_model.dart';

abstract class LoginRemoteDataSource {
  /// calls the https://matricule.icebergtech.net/api/token-auth/ to get the token
  /// 
  /// returns a [LoginModel] which contains the token
  /// 
  /// Throws a [ServerException] for all error codes (500, 404, 401, etc)
  Future<TokenModel> loginIn(String username, String password);
}