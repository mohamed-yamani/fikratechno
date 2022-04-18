import 'package:fikratechno/features/login/domain/entities/login.dart';
import 'package:fikratechno/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fikratechno/features/login/domain/repositories/login_repository.dart';
import 'package:mockito/mockito.dart';

class MockLoginRepository extends Mock implements LoginRepository {
  @override
  Future<Either<Failure, Login>> getLogin(String username, String password) {
    // TODO: implement getLogin
    throw UnimplementedError();
  }
}
