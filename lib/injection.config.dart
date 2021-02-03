// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/local_datasource.dart';
import 'data/repository.dart';
import 'blocs/theme/theme_bloc.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  final resolvedSharedPreferences = await registerModule.prefs;
  gh.factory<SharedPreferences>(() => resolvedSharedPreferences);
  gh.lazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(get<SharedPreferences>()));
  gh.lazySingleton<Repository>(
      () => RepositoryImpl(localDataSource: get<LocalDataSource>()));
  gh.factory<ThemeBloc>(() => ThemeBloc(repository: get<Repository>()));
  return get;
}

class _$RegisterModule extends RegisterModule {}
