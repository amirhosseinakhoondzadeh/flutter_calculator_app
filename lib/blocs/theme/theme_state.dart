part of 'theme_bloc.dart';

@freezed
abstract class ThemeState with _$ThemeState {
  const factory ThemeState({
    @required ThemeMode themeMode,
  }) = _ThemeState;

  factory ThemeState.initial() => const ThemeState(themeMode: ThemeMode.system);
}
