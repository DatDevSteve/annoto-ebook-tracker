import 'package:annoto/home_page.dart';
import 'package:annoto/library_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;

  final List<Widget> _screens = <Widget>[
    Text("Index 0"),
    LibraryPage(),
    HomePage(),
    Text("Index 3"),
    Text("Index 4"),
  ];

  void _onTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 85,
        //color: Color.fromRGBO(21, 24, 31, 1),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
            //bottom: Radius.circular(20),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              unselectedItemColor: Colors.white,
              iconSize: 40,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color.fromRGBO(16, 19, 24, 1),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.auto_graph),
                  label: " ",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_books),
                  label: " ",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: " ",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.manage_search),
                  label: " ",
                ),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: " "),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Color.fromRGBO(7, 113, 55, 1),
              onTap: _onTapped,
            ),
          ),
        ),
      ),
      body: Center(child: _screens.elementAt(_selectedIndex)),
    );
  }
}
