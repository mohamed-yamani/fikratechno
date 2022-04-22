part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const <dynamic>[]]) : super(props);
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressed({@required this.username, @required this.password})
      : assert(username != null),
        assert(password != null);

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}
