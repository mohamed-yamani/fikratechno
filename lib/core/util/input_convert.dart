import 'package:dartz/dartz.dart';
import 'package:fikratechno/core/error/failures.dart';

class InputConvert {
  Either<String, int> stringUnsignedIntegerer(String input) {
    try {
      return Right(int.parse(input));
    } on FormatException {
      return Left(input);
    }
  }
}

class InvalidInputFailure extends Failure {}
