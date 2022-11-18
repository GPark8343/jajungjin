import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jajungjin/screen/pages/pay_screen.dart';
import 'package:jajungjin/screen/pages/third_screen.dart';
import 'package:jajungjin/screen/pages/two_screen.dart';
import 'package:jajungjin/widgets/app_drawer.dart';

class TapScreen extends StatefulWidget {
  const TapScreen({super.key});

  @override
  State<TapScreen> createState() => _TapScreenState();
}

class _TapScreenState extends State<TapScreen> {
  late List<Map<String, Object>> _pages; //
  int _selectedPageIndex = 1;

  @override
  void initState() {
    _pages = [
      {'page': PayScreen(), 'title': 'List'},
      {'page': TwoScreen(), 'title': 'Map'},
      {'page': ThreeScreen(), 'title': 'Chat'},
      // {'page': FilterScreen(), 'title': 'Filter'},
      // {'page': UserFreindScreen(), 'title': 'Friend'},
      // {'page': UserListScreen(), 'title': 'People'},
      // {'page': ProfileScreen(), 'title': 'Profile'},
      // {'page': BulletinBoardScreen(), 'title': 'BulletinBoard'},
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['title'] as String),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
          ]),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.chat),
                label: 'chat'),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.people),
                label: 'friend'),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.people_alt_rounded),
                label: 'people'),
          ]),
    );
  }
}
