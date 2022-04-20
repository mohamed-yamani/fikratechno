import 'package:dartz/dartz.dart';

import 'package:fikratechno/core/error/failures.dart';
import 'package:fikratechno/features/login/domain/entities/login.dart';

abstract class LoginRepository {
  Future<Either<Failure, Token>> loginIn(String username, String password);
}
