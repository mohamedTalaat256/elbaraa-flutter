import 'package:elbaraa/constants/app_theme.dart';
import 'package:elbaraa/constants/strings.dart';
import 'package:elbaraa/data/business_logic/settings/app_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

class AppThemeDialog extends StatefulWidget {
  const AppThemeDialog({Key? key}) : super(key: key);

  @override
  State<AppThemeDialog> createState() => _AppThemeDialogState();
}



enum THEME { theme_light, theme_dark }

class _AppThemeDialogState extends State<AppThemeDialog> {

  THEME? _theme;




  @override
  Widget build(BuildContext context) {
   
    Brightness brightness = Theme.of(context).brightness;
    if( brightness == Brightness.dark){
      _theme = THEME.theme_dark;
      print(_theme.toString());
      print(brightness.toString());
    }else{
      _theme = THEME.theme_light;
      print(_theme.toString());
      print(brightness.toString());

    }
    return  AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Text('select-app-theme'.i18n()),
        content: Container(
          height: 200,
          child: Column(
            children: [
              ListTile(
                title: Text('light-theme'.i18n()),
                leading: Radio<THEME>(
                  fillColor: MaterialStateColor.resolveWith((states) => kTextGreen),
                  value: THEME.theme_light,
                  groupValue: _theme,
                  onChanged: (THEME? value) {
                   setState(() {
                     _theme = value;
                      BlocProvider.of<AppSettingsBloc>(context).add(ThemeChanged(theme: AppTheme.LightTheme));
                    });
                  },
                ),
              ),

              ListTile(
                title: Text('dark-theme'.i18n()),
                leading: Radio<THEME>(
                  fillColor: MaterialStateColor.resolveWith((states) => kTextGreen),
                  value: THEME.theme_dark,
                  groupValue: _theme,
                  onChanged: (THEME? value) {
                    setState(() {
                     _theme = value;
                      BlocProvider.of<AppSettingsBloc>(context).add(ThemeChanged(theme: AppTheme.DarkTheme,));
                    });
                  },
                ),
              ),
  
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text('cancel'.i18n(), style: TextStyle(
              color: kTextGreen
            )),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child:  Text('ok'.i18n(), style: TextStyle(
              color: kTextGreen
            )),
          ),
        ],
      );
    
  }
}