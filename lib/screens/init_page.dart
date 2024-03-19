import 'package:faszen/screens/categories-section/categories_page.dart';
import 'package:faszen/screens/community-section/community_hub.dart';
import 'package:faszen/screens/fizard-section/chat_bot.dart';
import 'package:faszen/screens/home-section/home_page.dart';
import 'package:faszen/screens/profile-section/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

// ignore: must_be_immutable
class InitPage extends StatefulWidget {
  bool? showSearchBarHelp;
  InitPage({super.key, this.showSearchBarHelp});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  
  late final List<Widget> _pages;
  int currentPageIndex = 0;
  bool _showBottomNavigationBar = true;

  @override
  void initState() {
    super.initState();
    _initPages();
  }

  void _initPages() {
    _pages = [
      ShowCaseWidget(builder: Builder(builder: (context) => HomePage(showSearchBarHelp: widget.showSearchBarHelp ?? false))),
      const CategoryPage(),
      Chat(ongetBack: onReset),
      CommunityPage(ongetBack: onReset),
      const ProfilePage(),
    ];
  }

  void onReset() {
    setState(() {
      currentPageIndex = 0;
      _showBottomNavigationBar = true;
      widget.showSearchBarHelp = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: _showBottomNavigationBar
            ? NavigationBar(
                backgroundColor: Colors.white,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                selectedIndex: currentPageIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    if (index == 2) {
                      _showBottomNavigationBar = false;
                    }
                    currentPageIndex = index;
                    widget.showSearchBarHelp = false;
                  });
                },
                destinations: <NavigationDestination>[
                  NavigationDestination(
                    icon: Image.asset(
                      "assets/icons/home_nav.png",
                      height: 30,
                      width: 30,
                    ),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Image.asset(
                      "assets/icons/categories_nav.png",
                      height: 30,
                      width: 30,
                    ),
                    label: 'Categories',
                  ),
                  NavigationDestination(
                    icon: Image.asset(
                      "assets/icons/faszen_nav.png",
                      height: 30,
                      width: 30,
                    ),
                    label: 'Fizard',
                  ),
                  NavigationDestination(
                    icon: Image.asset(
                      "assets/icons/community_nav.png",
                      height: 30,
                      width: 30,
                    ),
                    label: 'Community',
                  ),
                  NavigationDestination(
                    icon: Image.asset(
                      "assets/icons/profile_nav.png",
                      height: 30,
                      width: 30,
                    ),
                    label: 'Profile',
                  ),
                ],
              )
            : null,
        body: _pages[currentPageIndex],
      ),
    );
  }
}
