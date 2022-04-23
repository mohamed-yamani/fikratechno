import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fikratechno/core/error/failures.dart';
import 'package:fikratechno/features/login/domain/entities/login.dart';
import 'package:fikratechno/features/login/domain/usecases/get_login.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input Failure';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    @required GetLogin getlogin,
  })  : assert(getlogin != null),
        getLogin = getlogin,
        super(null);

  final GetLogin getLogin;

  @override
  LoginState get initialState => Empty();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    yield Loading();
    if (event is LoginButtonPressed) {
      final failureOrLogin = await getLogin(
        LoginParams(
          username: event.username,
          password: event.password,
        ),
      );
      yield failureOrLogin.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (login) => Loaded(token: login),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
