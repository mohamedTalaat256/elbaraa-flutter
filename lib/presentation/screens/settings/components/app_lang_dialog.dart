import 'package:elbaraa/constants/strings.dart';
import 'package:elbaraa/data/business_logic/settings/app_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

class AppLangDialog extends StatefulWidget {
  const AppLangDialog({Key? key}) : super(key: key);

  @override
  State<AppLangDialog> createState() => _AppLangDialogState();
}

enum LANG{ en_US, ar_EG}

class _AppLangDialogState extends State<AppLangDialog> {
  LANG? _lang;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, SettingsStateInitial>(
      builder: (context, state) {
        // Update _lang to reflect the current language state
        _lang = _lang ?? (state.local.languageCode == 'en' ? LANG.en_US : LANG.ar_EG);

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text('select-app-language'.i18n()),
          content: Container(
            height: 200,
            child: Column(
              children: [
                ListTile(
                  title: const Text('English'),
                  leading: Radio<LANG>(
                    fillColor: MaterialStateColor.resolveWith((states) => kTextGreen),
                    value: LANG.en_US,
                    groupValue: _lang,
                    onChanged: (LANG? value) {
                      setState(() {
                        _lang = value;
                        BlocProvider.of<AppSettingsBloc>(context).add(langChanged(local: Locale('en', 'US')));
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('العربية'),
                  leading: Radio<LANG>(
                    fillColor: MaterialStateColor.resolveWith((states) => kTextGreen),
                    toggleable: true,
                    value: LANG.ar_EG,
                    groupValue: _lang,
                    onChanged: (LANG? value) {
                      setState(() {
                        _lang = value;
                        BlocProvider.of<AppSettingsBloc>(context).add(langChanged(local: Locale('ar', 'EG')));
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
              child: Text('cancel'.i18n(), style: TextStyle(color: kTextGreen)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text('ok'.i18n(), style: TextStyle(color: kTextGreen)),
            ),
          ],
        );
      },
    );
  }
}