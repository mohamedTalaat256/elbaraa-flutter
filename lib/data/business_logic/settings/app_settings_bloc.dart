import 'package:bloc/bloc.dart';
import 'package:elbaraa/constants/app_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, SettingsStateInitial> {
  AppSettingsBloc()
      : super(SettingsStateInitial(
          themeData: AppThemeData[AppTheme.DarkTheme]!,
          local: const Locale('en', 'US'),
        )) {
    on<GetCurrentSettingsEvent>((event, emit) async {
      final sp = await SharedPreferences.getInstance();
      String? currentTheme = sp.getString('app_theme');
      String? currentLang = sp.getString('app_lang') ?? 'ar_EG';

      final theme = currentTheme == AppTheme.DarkTheme.name
          ? AppTheme.DarkTheme
          : AppTheme.LightTheme;

      final themeData = AppThemeData[theme]!;

      emit(SettingsStateInitial(
        themeData: themeData,
        local: Locale(currentLang.substring(0, 2), currentLang.substring(3, 5)),
      ));
    });

    on<ThemeChanged>((event, emit) async {
      final sp = await SharedPreferences.getInstance();
      await sp.setString('app_theme', event.theme.name);

      String? currentLang = sp.getString('app_lang') ?? 'ar_EG';

      emit(SettingsStateInitial(
        themeData: AppThemeData[event.theme]!,
        local: Locale(currentLang.substring(0, 2), currentLang.substring(3, 5)),
      ));
    });

    on<langChanged>((event, emit) async {
      final sp = await SharedPreferences.getInstance();
      await sp.setString('app_lang', '${event.local.languageCode}_${event.local.countryCode}');

      String? currentTheme = sp.getString('app_theme');
      final theme = currentTheme == AppTheme.DarkTheme.name
          ? AppTheme.DarkTheme
          : AppTheme.LightTheme;

      emit(SettingsStateInitial(
        themeData: AppThemeData[theme]!,
        local: event.local,
      ));
    });
  }
}
