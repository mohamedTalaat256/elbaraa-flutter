part of 'app_settings_bloc.dart';


@immutable
abstract class ThemeState {}


class SettingsStateInitial extends Equatable {
  
  final ThemeData themeData;
  final Locale local;
  const SettingsStateInitial({required this.themeData, required this.local});
 
  @override
  List<Object?> get props => [themeData];
}


class ThemeChangeState extends ThemeState{}



class LangChangedState extends ThemeState{}
