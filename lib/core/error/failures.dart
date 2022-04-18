import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List proprities;

  Failure([this.proprities = const <dynamic>[]]);

  @override
  List<Object> get props => [proprities];
}
