import 'package:fikratechno/features/login/domain/entities/login.dart';
import 'package:fikratechno/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fikratechno/features/login/domain/repositories/login_repository.dart';
import 'package:fikratechno/features/login/domain/usecases/get_login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  GetLogin usecase = GetLogin(MockLoginRepository());
  MockLoginRepository mockLoginRepository = MockLoginRepository();

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = GetLogin(mockLoginRepository);
  });

  const tUsername = 'test';
  const tPassword = 'test';
  var ttoken = Token(token: 'test');
  test('should get login from repository', () async {
    // arrange
    when(mockLoginRepository.loginIn(any, any))
        .thenAnswer((_) async => Right(ttoken));
    // act
    Either<Failure, Token> result =
        await usecase(LoginParams(username: tUsername, password: tPassword));
    // assert
    expect(result, Right(ttoken));
    verify(mockLoginRepository.loginIn(tUsername, tPassword));
  });
}
