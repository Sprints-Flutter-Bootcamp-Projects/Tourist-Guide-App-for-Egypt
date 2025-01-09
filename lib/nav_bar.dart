import 'package:flutter/material.dart';
import 'package:tourist_guide/views/government/favourites_page.dart';
import 'package:tourist_guide/views/government/government_page.dart';
import 'package:tourist_guide/views/home/home_page.dart';
import 'package:tourist_guide/views/profile/profile.dart';

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
    Profile(name: 'user name',email: 'user@example.com', password: 'hashedpass',),
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
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.pin_drop_outlined),
              selectedIcon: Icon(Icons.pin_drop),
              label: 'Government',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              selectedIcon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          elevation: 3),
    );
  }
}
