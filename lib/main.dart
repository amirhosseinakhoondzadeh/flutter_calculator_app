import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calculator_app/pages/calculator_screen.dart';

import 'blocs/theme/theme_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => ThemeBloc()..add(const ThemeEvent.started()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeBloc, ThemeState>(
      buildWhen: (p, c) => p.themeMode != c.themeMode,
      listener: (context, state) {
        // This is to handle statusBarColor when ThemeMode Changes
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarBrightness: state.themeMode == ThemeMode.light
                ? Brightness.light
                : Brightness.dark,
          ),
        );
      },
      builder: (context, state) => MaterialApp(
        title: 'Calculator',
        themeMode: state.themeMode,
        darkTheme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff374352),
          brightness: Brightness.dark,
          primaryColor: const Color(0xff374352),
          appBarTheme: const AppBarTheme(
            brightness: Brightness.dark,
            color: Color(0xff374352),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color(0xffF9FBFF),
          appBarTheme: const AppBarTheme(
            brightness: Brightness.light,
            color: Color(0xffF9FBFF),
          ),
          scaffoldBackgroundColor: const Color(0xffF9FBFF),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const CalculatorScreen(),
      ),
    );
  }
}
