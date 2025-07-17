
import 'package:elbaraa/constants/strings.dart';
import 'package:elbaraa/data/business_logic/auth/auth_bloc.dart';
import 'package:elbaraa/data/business_logic/auth/auth_event.dart';
import 'package:elbaraa/data/business_logic/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(AutoLoginEvent());
  }

  @override
  Widget build(BuildContext context) {


    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if(state is IsLogedInState){
          await Future.delayed(const Duration(seconds: 2), () {
           // Navigator.of(context).pushReplacementNamed(homeScreen);
           Navigator.of(context).pushReplacementNamed('/control_view');
          });
        }else if(state is IsNotLogedInState){
          await Future.delayed(const Duration(seconds: 2), () {
          print('navigate to login screen');
            Navigator.of(context).pushReplacementNamed('/login_screen');
          });
        }
        
      },
      child: Scaffold(
         body: Center(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors:gradientColors,
                )
              ),
              child: Center(
                child: Text(
                  '𝓦𝓲𝓷 𝓐𝓹𝓹'.i18n(),
                  style: TextStyle(
                    fontSize: 68.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
          ),
      ),
    );
    
  }
}