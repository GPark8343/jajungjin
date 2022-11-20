import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jajungjin/screen/pages/pay_screen.dart';
import 'package:jajungjin/screen/pages/plus_item_screen.dart';
import 'package:jajungjin/screen/pages/third_screen.dart';
import 'package:jajungjin/screen/pages/list_screen.dart';
import 'package:jajungjin/widgets/app_drawer.dart';

class TapScreen extends StatefulWidget {
  const TapScreen({super.key});

  @override
  State<TapScreen> createState() => _TapScreenState();
}

class _TapScreenState extends State<TapScreen> {
  late List<Map<String, Object>> _pages; //
  int _selectedPageIndex = 1;

  bool isManager = FirebaseAuth.instance.currentUser?.uid!='MLZicFwQROVuFd36qz7dc59EiBm2';
 
  @override
  void initState() {
    _pages = [
      {'page': ListScreen(), 'title': 'List'},
      {'page': ThreeScreen(), 'title': isManager?'profile':'난 관리자'},
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
          actions: _selectedPageIndex == 1
              ? (isManager? []:[
                  IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(PlusItemScreen.routeName);
                      },
                      icon: Icon(Icons.add)),
                ])
              : [
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
                icon: Icon(Icons.list),
                label: 'List'),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.people_alt_rounded),
                label: 'people'),
          ]),
    );
  }
}
