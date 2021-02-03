import 'package:flutter/foundation.dart';
import 'package:flutter_calculator_app/core/constants/keys.dart';
import 'package:flutter_calculator_app/core/error/exceptions.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

abstract class LocalDataSource {
  Future<void> setDarkMode({@required bool isDarkModeEnabled});
  Future<bool> isDarkModeEnabled();
}

@LazySingleton(as: LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  const LocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<bool> isDarkModeEnabled() {
    final result = sharedPreferences.getBool(prefThemeKey);
    if (result != null) {
      return Future.value(result);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> setDarkMode({bool isDarkModeEnabled}) {
    return sharedPreferences.setBool(
      prefThemeKey,
      isDarkModeEnabled,
    );
  }
}
