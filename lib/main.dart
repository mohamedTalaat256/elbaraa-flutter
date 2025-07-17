import 'package:elbaraa/app_router.dart';
import 'package:elbaraa/data/business_logic/settings/app_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
/*   await Firebase.initializeApp();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
 */
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppSettingsBloc()..add(GetCurrentSettingsEvent()),
        child: BlocBuilder<AppSettingsBloc, SettingsStateInitial>(
          builder: (ctx, state) {
            LocalJsonLocalization.delegate.directories = ['lib/i18n'];
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateRoute: appRouter.generateRoute,
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  LocalJsonLocalization.delegate,
                ],
                supportedLocales: [
                  Locale('ar', 'EG'),
                  Locale('en', 'US'),
                ],
                locale: state.local,
                theme: state.themeData);
          },
        ));
  }
}
