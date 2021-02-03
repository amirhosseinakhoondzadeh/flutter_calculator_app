import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_calculator_app/core/error/exceptions.dart';
import 'package:flutter_calculator_app/core/error/failures.dart';
import 'package:flutter_calculator_app/data/datasources/local_datasource.dart';
import 'package:injectable/injectable.dart';

abstract class Repository {
  Future<Either<Failure, void>> saveIsDarkModeEnabled(
      {@required bool isDarkModeEnabled});
  Future<Either<Failure, bool>> isDarkModeEnabled();
}

@LazySingleton(as: Repository)
class RepositoryImpl implements Repository {
  final LocalDataSource _localDataSource;

  const RepositoryImpl({@required LocalDataSource localDataSource})
      : assert(localDataSource != null),
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, bool>> isDarkModeEnabled() async {
    try {
      final isDarkModeEnabled = await _localDataSource.isDarkModeEnabled();
      return Right(isDarkModeEnabled);
    } on CacheException catch (_) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveIsDarkModeEnabled(
      {bool isDarkModeEnabled}) async {
    final result = await _localDataSource.setDarkMode(
        isDarkModeEnabled: isDarkModeEnabled);
    return Right(result);
  }
}
