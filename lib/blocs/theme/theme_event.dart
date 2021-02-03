part of 'theme_bloc.dart';

@freezed
abstract class ThemeEvent with _$ThemeEvent {
  const factory ThemeEvent.started() = _Started;
  const factory ThemeEvent.changed({@required bool isDarkTheme}) = _Changed;
}
