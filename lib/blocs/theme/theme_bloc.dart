import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_event.dart';
part 'theme_state.dart';
part 'theme_bloc.freezed.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial());

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    yield* event.map(
      started: (e) async* {
        yield state;
      },
      changed: (e) async* {
        final themeMode = e.isDarkTheme ? ThemeMode.dark : ThemeMode.light;
        yield state.copyWith(themeMode: themeMode);
      },
    );
  }
}
