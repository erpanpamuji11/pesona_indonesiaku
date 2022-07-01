import 'package:bloc/bloc.dart';
import 'package:core/common/styles/theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(themeData: appThemeData[AppTheme.LightTheme]!)) {
    on<ThemeEvent>((event, emit) {
      if (event is ThemeChanged) {
        emit.call(ThemeState(themeData: appThemeData[event.theme]!));
      }
    });
  }
}
