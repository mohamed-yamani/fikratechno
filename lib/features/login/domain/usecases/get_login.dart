import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fikratechno/core/error/failures.dart';
import 'package:fikratechno/core/usecases/usecases.dart';
import 'package:fikratechno/features/login/domain/entities/login.dart';
import 'package:fikratechno/features/login/domain/repositories/login_repository.dart';
import 'package:flutter/cupertino.dart';

class GetLogin implements UseCase<Token, LoginParams> {
  final LoginRepository repository;

  GetLogin(this.repository);

  @override
  Future<Either<Failure, Token>> call(LoginParams params) async {
    return await repository.loginIn(params.username, params.password); 
  }
}

class LoginParams extends Equatable {
  final String username;
  final String password;

  LoginParams({@required this.username, @required this.password})
      : super([username, password]);
}
