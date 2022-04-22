import 'package:fikratechno/core/error/exceptions.dart';
import 'package:meta/meta.dart';

import 'package:fikratechno/core/network/network_info.dart';
import 'package:fikratechno/features/login/data/datasources/login_local_data_source.dart';
import 'package:fikratechno/features/login/data/datasources/login_remote_data_source.dart';
import 'package:fikratechno/features/login/domain/entities/login.dart';
import 'package:fikratechno/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fikratechno/features/login/domain/repositories/login_repository.dart';

class LoginRepostoryImplementaiton implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LoginRepostoryImplementaiton({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, Token>> loginIn(
      String username, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLogin = await remoteDataSource.loginIn(username, password);
        localDataSource.cacheToken(remoteLogin);
        return Right(remoteLogin);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localLogin = await localDataSource.getLastToken();
        return Right(localLogin);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
