import 'package:elbaraa/presentation/screens/settings/components/app_lang_dialog.dart';
import 'package:elbaraa/presentation/screens/settings/components/app_theme_dialog.dart';
import 'package:elbaraa/presentation/widgets/custome_text.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: CustomScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                floating: true,
                pinned: true,
                snap: false,
                centerTitle: false,
                title: Row(
                  children: [
                    CustomeText(
                      text: 'Settings',
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                sliver: MultiSliver(
                  children: [
                    ProfileMenueItem(
                      onPressed: () async {
                        _changeAppThemDialog(context);
                      },
                      text: 'app-theme'.i18n(),
                      icon: Icons.dark_mode_rounded,
                      iconColor: Theme.of(context).primaryColor,
                    ),
                    ProfileMenueItem(
                      onPressed: () {
                        _changeAppLangDialog(context);
                      },
                      text: 'app-language'.i18n(),
                      icon: Icons.language_rounded,
                      iconColor: Colors.blue,
                    ),
                  ],
                ),
              )
            ]));
  }

  Future<String?> _changeAppThemDialog(BuildContext context) {
    return showDialog<String>(
        context: context, builder: (BuildContext context) => AppThemeDialog());
  }

  Future<String?> _changeAppLangDialog(BuildContext context) {
    return showDialog<String>(
        context: context, builder: (BuildContext context) => AppLangDialog());
  }
}

class ProfileMenueItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;
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
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        icon,
                        color: iconColor,
                      )),
                  SizedBox(width: 6),
                  CustomeText(
                    text: text,
                    fontSize: 19,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
