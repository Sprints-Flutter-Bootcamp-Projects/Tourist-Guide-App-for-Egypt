import 'package:flutter/material.dart';
import 'package:tourist_guide/views/home/favourites_page.dart';
import 'package:tourist_guide/views/government/government_page.dart';
import 'package:tourist_guide/views/home/home_page.dart';
import 'package:tourist_guide/views/profile/profile.dart';
import 'package:easy_localization/easy_localization.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

int selectedPage = 0;

class _MyNavigationBarState extends State<MyNavigationBar> {
  final PageController pageController = PageController();
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    GovernmentPage(),
    FavouritesPage(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedPage = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              selectedPage = index;
            });
          },
          children: _widgetOptions),
      bottomNavigationBar: NavigationBar(
          animationDuration: const Duration(milliseconds: 1000),
          selectedIndex: selectedPage,
          onDestinationSelected: _onItemTapped,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: context.tr('home_page'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.pin_drop_outlined),
              selectedIcon: const Icon(Icons.pin_drop),
              label: context.tr('governorates'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.favorite_outline),
              selectedIcon: const Icon(Icons.favorite),
              label: context.tr('favorites'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline),
              selectedIcon: const Icon(Icons.person),
              label: context.tr('profile'),
            ),
          ],
          elevation: 3),
    );
  }
}
