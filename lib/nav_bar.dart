import 'package:flutter/material.dart';
import 'package:tourist_guide/views/home/favourites_page.dart';
import 'package:tourist_guide/views/government/government_page.dart';
import 'package:tourist_guide/views/home/home_page.dart';
import 'package:tourist_guide/views/profile/profile.dart';
import 'package:easy_localization/easy_localization.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  // MyNavigationBar({required Key key}) : super(key: key);/

  @override
  // ignore: library_private_types_in_public_api
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

bool isLoggedIn = false;
int selectedPage = 0;

class _MyNavigationBarState extends State<MyNavigationBar> {
  final PageController pageController = PageController();
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(title: "Home Page"),
    GovernmentPage(),
    FavouritesPage(),
    Profile(
      name: 'user name',
      email: 'user@example.com',
      password: 'hashedpass',
    ),
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
      //bottom nav bar from material package
      // https://api.flutter.dev/flutter/material/NavigationBar-class.html

      bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.brown[50],
          indicatorColor: Colors.teal[100],
          selectedIndex: selectedPage,
          onDestinationSelected: _onItemTapped,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: tr('home_page'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.pin_drop_outlined),
              selectedIcon: const Icon(Icons.pin_drop),
              label: tr('governorates'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.favorite_outline),
              selectedIcon: const Icon(Icons.favorite),
              label: tr('favourites'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline),
              selectedIcon: const Icon(Icons.person),
              label: tr('profile'),
            ),
          ],
          elevation: 3),
    );
  }
}
