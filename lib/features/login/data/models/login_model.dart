import 'package:fikratechno/features/login/domain/entities/login.dart';
import 'package:flutter/cupertino.dart';

class TokenModel extends Token {
  TokenModel({@required String token}) : super(token: token);

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(token: json['token'].toString());
  }

  Map<String, dynamic> toJson() {
    return {'token': token};
  }
}
