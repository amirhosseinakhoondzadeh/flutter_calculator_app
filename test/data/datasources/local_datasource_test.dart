import 'package:flutter_calculator_app/core/constants/keys.dart';
import 'package:flutter_calculator_app/core/error/exceptions.dart';
import 'package:flutter_calculator_app/data/datasources/local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcher/matcher.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  LocalDataSourceImpl localDataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource = LocalDataSourceImpl(mockSharedPreferences);
  });

  group('isDarkModeEnabled', () {
    test('should return a bool when there is a theme saved in preferences',
        () async {
      //arrange
      when(mockSharedPreferences.getBool(any)).thenReturn(true);
      //act
      final result = await localDataSource.isDarkModeEnabled();
      //assert
      verify(mockSharedPreferences.getBool(prefThemeKey));
      expect(result, isA<bool>());
    });

    test('should return a CacheException where there is not saved theme exists',
        () async {
      //arrange
      when(mockSharedPreferences.getBool(any)).thenReturn(null);
      //act
      final call = localDataSource.isDarkModeEnabled;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('setDarkModeInfo', () {
    const bool tIsDarkModeEnabled = true;
    test('should call setDarkMode to save the selected theme', () {
      //act
      localDataSource.setDarkMode(isDarkModeEnabled: tIsDarkModeEnabled);

      //assert
      verify(
        mockSharedPreferences.setBool(prefThemeKey, tIsDarkModeEnabled),
      );
    });
  });
}
