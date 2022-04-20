import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Token extends Equatable {
  final String token;

  Token({@required this.token}) : super([token]);
}
