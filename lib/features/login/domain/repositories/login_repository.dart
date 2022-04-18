import 'package:dartz/dartz.dart';

import 'package:fikratechno/core/error/failures.dart';
import 'package:fikratechno/features/login/domain/entities/login.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>> getLogin(String username, String password);
}
