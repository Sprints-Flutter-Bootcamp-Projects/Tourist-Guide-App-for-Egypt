import 'package:flutter/material.dart';
import 'package:tourist_guide/views/government/government_page.dart';
import 'package:tourist_guide/views/home/home_page.dart';

class MyNavigationBar extends StatefulWidget {
  // MyNavigationBar({required Key key}) : super(key: key);/

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  final PageController pageController = PageController();
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(title: "Home Page"),
    GovernmentPage(),
    Text('Favorites Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Profile Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          children: _widgetOptions,
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
      //bottom nav bar from material package
      // https://api.flutter.dev/flutter/material/NavigationBar-class.html

      bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.brown[50],
          indicatorColor: Colors.teal[100],
          selectedIndex: _selectedIndex,
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
