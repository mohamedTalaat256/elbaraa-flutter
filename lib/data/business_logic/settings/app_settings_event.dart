part of 'app_settings_bloc.dart';

abstract class AppSettingsEvent extends Equatable {
  List<Object?> get props => [];
  const AppSettingsEvent();
}

class GetCurrentSettingsEvent extends AppSettingsEvent {}

class ThemeChanged extends AppSettingsEvent {
  final AppTheme theme;

  ThemeChanged({required this.theme});
  @override
  List<Object?> get props => [theme];
}

class langChanged extends AppSettingsEvent {
  final Locale local;

  langChanged({required this.local});
  @override
  List<Object?> get props => [local];
}
