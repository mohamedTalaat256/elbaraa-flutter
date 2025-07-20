import 'package:elbaraa/app_router.dart';
import 'package:elbaraa/data/business_logic/settings/app_settings_bloc.dart';
import 'package:elbaraa/utils/snackbar_helper.dart';
import 'package:flutter/foundation.dart';
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
              navigatorKey: navigatorKey,
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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ErrorHandler extends StatefulWidget {
  final Widget child;

  const ErrorHandler({super.key, required this.child});

  @override
  State<ErrorHandler> createState() => _ErrorHandlerState();
}

class _ErrorHandlerState extends State<ErrorHandler> {
  final FlutterExceptionHandler? _originalOnError = FlutterError.onError;

  @override
  void initState() {
    super.initState();
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      showGlobalSnackBar(details.exception.toString());
      _originalOnError?.call(details);
    };
  }

  @override
  void dispose() {
    FlutterError.onError = _originalOnError;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}