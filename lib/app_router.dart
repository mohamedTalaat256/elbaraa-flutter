import 'package:elbaraa/constants/strings.dart';
import 'package:elbaraa/data/business_logic/auth/auth_bloc.dart';
import 'package:elbaraa/data/business_logic/auth/auth_cubit.dart';
import 'package:elbaraa/data/business_logic/auth/auth_state.dart';
import 'package:elbaraa/data/business_logic/chat/chat_bloc.dart';
import 'package:elbaraa/data/business_logic/chat/chat_cubit.dart';
import 'package:elbaraa/data/business_logic/home/home_cubit.dart';
import 'package:elbaraa/data/business_logic/instructor/instructor_cubit.dart';
import 'package:elbaraa/data/business_logic/plan/plan_cubit.dart';
import 'package:elbaraa/data/business_logic/profile/profile_bloc.dart';
import 'package:elbaraa/data/business_logic/profile/profile_cubit.dart';
import 'package:elbaraa/data/business_logic/session/session_cubit.dart';
import 'package:elbaraa/data/business_logic/settings/app_settings_bloc.dart';
import 'package:elbaraa/data/models/user.dart';
import 'package:elbaraa/data/repository/auth_repository.dart';
import 'package:elbaraa/data/repository/chats_repository.dart';
import 'package:elbaraa/data/repository/home_repository.dart';
import 'package:elbaraa/data/repository/instructor_repository.dart';
import 'package:elbaraa/data/repository/plan_repository.dart';
import 'package:elbaraa/data/repository/session_repository.dart';
import 'package:elbaraa/data/repository/users_repository.dart';
import 'package:elbaraa/data/web_services/chats_web_service.dart';
import 'package:elbaraa/data/web_services/users_web_service.dart';
import 'package:elbaraa/presentation/screens/auth/login_screen.dart';
import 'package:elbaraa/presentation/screens/chat/chat_mesages.dart';
import 'package:elbaraa/presentation/screens/control_view.dart';
import 'package:elbaraa/presentation/screens/home/home_screen.dart';
import 'package:elbaraa/presentation/screens/profile/edit_profile_screen.dart';
import 'package:elbaraa/presentation/screens/settings/setting_screen.dart';
import 'package:elbaraa/presentation/screens/splash_screen.dart';
import 'package:elbaraa/presentation/screens/subscrip-to-plan/subscrip-to-plan-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late final AuthRepository authRepository;
  late final UsersRepository usersRepository;
  late final ChatRepository chatRepository;
  late final SessionRepository sessionRepository;
  late final HomeRepository homeRepository;
  late final PlanRepository planRepository;
  late final InstructorRepository instructorRepository;

  late final AuthState authState;
  late final AuthBloc authBloc;
  late final AuthCubit authCubit;
  late final HomeCubit homeCubit;
  late final SessionCubit sessionCubit;
  late final ProfileCubit profileCubit;
  late final ProfileBloc profileBloc;
  late final ChatCubit chatCubit;
  late final ChatBloc chatBloc;
  late final PlanCubit planCubit;
  late final InstructorCubit instructorCubit;

  AppRouter() {
    homeRepository = HomeRepository();
    authRepository = AuthRepository();
    usersRepository = UsersRepository(UsersWebService());
    chatRepository = ChatRepository(ChatWebService());
    sessionRepository = SessionRepository();
    planRepository = PlanRepository();
    instructorRepository = InstructorRepository();

    authState = AuthState();
    authBloc = AuthBloc(authRepository);
    authCubit = AuthCubit(authState);
    homeCubit = HomeCubit(homeRepository);
    sessionCubit = SessionCubit(sessionRepository);
    profileCubit = ProfileCubit(authRepository);
    profileBloc = ProfileBloc(authRepository);
    chatCubit = ChatCubit(chatRepository);
    chatBloc = ChatBloc(chatRepository);
    planCubit = PlanCubit(planRepository);
    instructorCubit = InstructorCubit(instructorRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: homeCubit),
              BlocProvider.value(value: sessionCubit),
            ],
            child: const HomeScreen(),
          ),
        );

      case loginScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(value: authBloc, child: const LoginScreen()),
        );

      case controlViewScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: homeCubit),
              BlocProvider.value(value: sessionCubit),
              BlocProvider.value(value: profileCubit),
              BlocProvider.value(value: chatCubit),
              BlocProvider.value(value: authBloc),
              BlocProvider.value(value: authCubit),
              BlocProvider.value(value: planCubit),
              BlocProvider.value(value: instructorCubit),
            ],
            child: const ControlView(),
          ),
        );

      case settingScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => AppSettingsBloc(),
            child: SettingScreen(),
          ),
        );

      case editProfileScreen:
        final userInfo = settings.arguments as User;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: profileBloc,
            child: EditProfileScreen(userInfo: userInfo),
          ),
        );

      case chatMessagesScreen:
        final secondPerson = settings.arguments as User;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: chatCubit),
              BlocProvider.value(value: chatBloc),
            ],
            child: ChatMessagesScreen(secondPerson: secondPerson),
          ),
        );

      case splashScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(value: authBloc, child: const SplashScreen()),
        );

      case subscripToPlanScreen:
        final planId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: planCubit),
              BlocProvider.value(value: instructorCubit),
            ],
            child: SupscripToPlanScreen(planId: planId),
          ),
        );

      default:
        return null;
    }
  }
}
