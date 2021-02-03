import 'package:flutter_calculator_app/data/datasources/local_datasource.dart';
import 'package:flutter_calculator_app/data/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLocalDataSource extends Mock implements LocalDataSource {}

void main() {
  RepositoryImpl repository;
  MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = RepositoryImpl(
      localDataSource: mockLocalDataSource,
    );
  });
}
