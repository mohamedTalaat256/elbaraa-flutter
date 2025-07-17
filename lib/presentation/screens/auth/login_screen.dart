import 'package:elbaraa/constants/strings.dart';
import 'package:elbaraa/data/business_logic/auth/auth_bloc.dart';
import 'package:elbaraa/data/business_logic/auth/auth_event.dart';
import 'package:elbaraa/data/business_logic/auth/auth_state.dart';
import 'package:elbaraa/presentation/widgets/custome_button.dart';
import 'package:elbaraa/presentation/widgets/custome_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            setState(() {
              isLoading = true;
            });
          } else if (state is UserLoginSuccessState) {
            Navigator.of(context).pushReplacementNamed('/control_view');
          } else if (state is LoginErrorState) {
            _showDialog(context, state.message);
            setState(() {
              isLoading = false;
            });
          }
        },
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
           
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomeText(
                          text: 'login'.i18n(),
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                       
                      ],
                    ),
                    SizedBox(height: 40),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                              labelText: 'البريد الإلكتروني',
                              hintText: 'example@email.com',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال البريد الإلكتروني';
                              }
                              final emailRegex = RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              );
                              if (!emailRegex.hasMatch(value)) {
                                return 'البريد الإلكتروني غير صالح';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              // Save the value
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: password,
                            decoration: InputDecoration(
                              labelText: 'كلمة المرور',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال كلمة المرور';
                              }
                              if (value.length < 6) {
                                return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          isLoading
                              ? SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : CustomeButton(
                                  onPressed: () {
                                    BlocProvider.of<AuthBloc>(context).add(
                                      LoginButtonPressed(
                                        email: email.text,
                                        password: password.text,
                                      ),
                                    );
                                  },
                                  borderRaduis: 6,
                                  backgroundColor: Color.fromARGB(
                                    255,
                                    209,
                                    84,
                                    0,
                                  ),
                                  paddingAll: 8,
                                  text: 'sign in',
                                  textColor: Colors.white,
                                ),
                          SizedBox(height: 10),
                          CustomeText(text: '-OR-', color: Colors.grey),

                           GestureDetector(
                          onTap: () {},
                          child: CustomeText(
                            text: 'register'.i18n(),
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> _showDialog(BuildContext context, String message) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        title: Text(message),
        content: const Text('Fail to login'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel', style: TextStyle(color: kTextGreen)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK', style: TextStyle(color: kTextGreen)),
          ),
        ],
      ),
    );
  }
}
