import 'package:elbaraa/constants/strings.dart';
import 'package:elbaraa/data/business_logic/auth/auth_bloc.dart';
import 'package:elbaraa/data/business_logic/auth/auth_event.dart';
import 'package:elbaraa/data/business_logic/auth/auth_state.dart';
import 'package:elbaraa/data/business_logic/profile/profile_cubit.dart';
import 'package:elbaraa/data/models/user.dart';
import 'package:elbaraa/presentation/widgets/custome_text.dart';
import 'package:elbaraa/presentation/widgets/transition_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User profile;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getMyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          //  controller.getMyProfile();
        },
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (cxt, state) {
            if (state is ProfileLoaded) {
              profile = (state).profile;

              return CustomScrollView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  TransitionAppBar(
                    avatar: profile.imageUrl,
                    title: "${profile.firstName} ${profile.lastName}",
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    sliver: MultiSliver(
                      children: [
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomeText(
                            text: "${profile.firstName} ${profile.lastName}",
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: kTextColor,
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: defaultBorderColor),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.mail, color: Colors.blue),
                                    SizedBox(width: 20),
                                    Flexible(
                                      child: CustomeText(
                                        text: profile.email,
                                        fontSize: 16,
                                        color: Theme.of(
                                          context,
                                        ).primaryColor.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(height: 20),
                                Row(
                                  children: [
                                    Icon(Icons.person),
                                    SizedBox(width: 20),
                                  ],
                                ),
                                Divider(height: 20),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.pin_drop_sharp,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 20),
                                    Flexible(
                                      child: CustomeText(
                                        text: 'alex Egypt',
                                        fontSize: 16,
                                        color: Theme.of(
                                          context,
                                        ).primaryColor.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(height: 20),
                                Row(
                                  children: [
                                    Icon(Icons.phone, color: Colors.green),
                                    SizedBox(width: 20),
                                    Flexible(
                                      child: CustomeText(
                                        text: profile.phone,
                                        fontSize: 16,
                                        color: Theme.of(
                                          context,
                                        ).primaryColor.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        ProfileMenueItem(
                          onPressed: () {},
                          text: 'my-orders'.i18n(),
                          icon: Icons.menu_outlined,
                          iconColor: kTextGreen,
                        ),
                        SizedBox(height: 5),
                        ProfileMenueItem(
                          onPressed: () {},
                          text: 'payments'.i18n(),
                          icon: Icons.payment_rounded,
                          iconColor: Colors.green,
                        ),
                        SizedBox(height: 5),
                        ProfileMenueItem(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              '/edit_profile_screen',
                              arguments: profile,
                            );
                          },
                          text: 'edit-profile'.i18n(),
                          icon: Icons.edit_outlined,
                          iconColor: Colors.blueAccent,
                        ),
                        SizedBox(height: 5),
                        ProfileMenueItem(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/setting_screen');
                          },
                          text: 'settings'.i18n(),
                          icon: Icons.settings,
                          iconColor: Theme.of(context).primaryColor,
                        ),
                        SizedBox(height: 5),
                        BlocListener<AuthBloc, AuthState>(
                          listener: (ctx, state) {
                            if (state is LogoutLoadingState) {
                              setState(() {
                                loading = true;
                              });
                            } else if (state is UserLogoutSuccessState) {
                              Navigator.of(
                                context,
                              ).pushReplacementNamed('/login_screen');
                            }
                          },
                          child: loading
                              ? SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : ProfileMenueItem(
                                  onPressed: () async {
                                    BlocProvider.of<AuthBloc>(
                                      context,
                                    ).add(LogoutButtonPressed());
                                  },
                                  text: 'logout'.i18n(),
                                  icon: Icons.exit_to_app,
                                  iconColor: Colors.redAccent,
                                ),
                        ),
                        SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is ProfileLoadingError) {
              return Center(child: Text(state.errorMessage));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class ProfileMenueItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color iconColor;
  const ProfileMenueItem({
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(6),
                    child: Icon(icon, color: iconColor.withOpacity(0.7)),
                  ),
                  SizedBox(width: 6),
                  CustomeText(
                    text: text,
                    fontSize: 19,
                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
