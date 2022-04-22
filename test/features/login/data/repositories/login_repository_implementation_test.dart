import 'package:dartz/dartz.dart';
import 'package:fikratechno/core/error/exceptions.dart';
import 'package:fikratechno/core/error/failures.dart';
import 'package:fikratechno/core/network/network_info.dart';
import 'package:fikratechno/features/login/data/datasources/login_local_data_source.dart';
import 'package:fikratechno/features/login/data/datasources/login_remote_data_source.dart';
import 'package:fikratechno/features/login/data/models/login_model.dart';
import 'package:fikratechno/features/login/data/repositories/login_repository_implementation.dart';
import 'package:fikratechno/features/login/domain/entities/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements LoginRemoteDataSource {}

class MockLocalDataSource extends Mock implements LoginLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  LoginRepostoryImplementaiton repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = LoginRepostoryImplementaiton(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getLogin token', () {
    const String testusername = 'test';
    const String testpassword = 'test';
    final testtoken = TokenModel(token: 'test');
    final Token testTokenEntity = TokenModel(token: 'test');
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.loginIn(testusername, testpassword);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.loginIn(any, any))
              .thenAnswer((_) async => testtoken);
          // act
          final result = await repository.loginIn(testusername, testpassword);
          // assert
          verify(mockRemoteDataSource.loginIn(testusername, testpassword));
          expect(result, equals(Right(testTokenEntity)));
        },
      );
      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.loginIn(any, any))
              .thenAnswer((_) async => testtoken);
          // act
          await repository.loginIn(testusername, testpassword);
          // assert
          verify(mockRemoteDataSource.loginIn(testusername, testpassword));
          verify(mockLocalDataSource.cacheToken(testtoken));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.loginIn(any, any))
              .thenThrow(ServerException());
          // act
          final result = await repository.loginIn(testusername, testpassword);
          // assert
          verify(mockRemoteDataSource.loginIn(testusername, testpassword));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastToken())
              .thenAnswer((_) async => testtoken);
          // act
          final result = await repository.loginIn(testusername, testpassword);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastToken());
          expect(result, equals(Right(testTokenEntity)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastToken()).thenThrow(CacheException());
          // act
          final result = await repository.loginIn(testusername, testpassword);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastToken());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
