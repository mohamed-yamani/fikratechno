part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends LoginState {}

class Loading extends LoginState {}

class Loaded extends LoginState {
  final Token token;

  Loaded({@required this.token}) : super([token]);
}

class Error extends LoginState {
  final String message;

  Error({@required this.message}) : super([message]);
}
