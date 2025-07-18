import 'package:elbaraa/presentation/screens/calendar/calendar-screen.dart';
import 'package:elbaraa/presentation/screens/chat/messages.dart';
import 'package:elbaraa/presentation/screens/home/home_screen.dart';
import 'package:elbaraa/presentation/screens/profile/profile_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class ControlView extends StatefulWidget {
  const ControlView({super.key});

  @override
  State<ControlView> createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  PageController pageController = PageController();
  List<Widget> screens = [
      ProfileScreen(),
   
   CalendarScreen(),
    MessagesScreen(),
    HomeScreen(),
  ];

  int selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor:
              Theme.of(context).primaryColor, //kDefaultIconColor,
          unselectedItemColor: Theme.of(context).primaryColor.withOpacity(0.6),
          currentIndex: selectedIndex,
          onTap: _onItemTapped,
          iconSize: 33,
          items: [
            BottomNavigationBarItem(
                icon: Icon(EvaIcons.homeOutline), label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  EvaIcons.calendar,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  EvaIcons.messageCircleOutline,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  EvaIcons.person,
                ),
                label: ''),
          ],
        ));
  }
}
