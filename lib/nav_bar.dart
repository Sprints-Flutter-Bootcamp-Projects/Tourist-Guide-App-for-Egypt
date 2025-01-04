import 'package:flutter/material.dart';
import 'package:tourist_guide/views/home/home_page.dart';

class MyNavigationBar extends StatefulWidget {
  // MyNavigationBar({required Key key}) : super(key: key);/

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(title: "Home Page"),
    Text('Governments Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Favorites Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Profile Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pin_drop),
              label: 'Government',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Fav',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.greenAccent,
          iconSize: 30,
          onTap: _onItemTapped,
          elevation: 3),
    );
  }
}
