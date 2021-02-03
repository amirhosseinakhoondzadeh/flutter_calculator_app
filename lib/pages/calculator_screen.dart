import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calculator_app/blocs/theme/theme_bloc.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Switch.adaptive(
              value: state.themeMode == ThemeMode.dark ? true : false,
              onChanged: (isModeChanged) =>
                  BlocProvider.of<ThemeBloc>(context).add(
                ThemeEvent.changed(isDarkTheme: isModeChanged),
              ),
            ),
          ),
        );
      },
    );
  }
}
