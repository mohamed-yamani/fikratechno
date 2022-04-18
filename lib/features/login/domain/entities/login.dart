import 'package:equatable/equatable.dart';

class Login extends Equatable {
  const Login(this.token);

  final String token;

  @override
  List<Object> get props => [token];
}
