import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calculator_app/core/error/failures.dart';
import 'package:flutter_calculator_app/data/repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'theme_event.dart';
part 'theme_state.dart';
part 'theme_bloc.freezed.dart';

@injectable
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({@required Repository repository})
      : assert(repository != null),
        _repository = repository,
        super(ThemeState.initial());

  final Repository _repository;

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    yield* event.map(
      started: (e) async* {
        final successOrFailure = await _repository.isDarkModeEnabled();
        yield successOrFailure.fold(
          (_) => state,
          (isDarkModeEnabled) => state.copyWith(
            themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
          ),
        );
      },
      changed: (e) async* {
        final themeMode = e.isDarkTheme ? ThemeMode.dark : ThemeMode.light;
        _repository.saveIsDarkModeEnabled(isDarkModeEnabled: e.isDarkTheme);
        yield state.copyWith(themeMode: themeMode);
      },
    );
  }
}
