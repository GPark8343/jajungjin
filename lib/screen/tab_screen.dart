import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jajungjin/screen/pages/channel__list_screen.dart';
import 'package:jajungjin/screen/pages/chat_screen.dart';
import 'package:jajungjin/screen/pages/pay_screen.dart';
import 'package:jajungjin/screen/pages/plus_item_screen.dart';
import 'package:jajungjin/screen/pages/all-receipt_screen.dart';
import 'package:jajungjin/screen/pages/receipt_screen.dart';
import 'package:jajungjin/screen/pages/list_screen.dart';
import 'package:jajungjin/screen/pages/user_chat_screen.dart';
import 'package:jajungjin/screen/pages/user_management_screen.dart';
import 'package:jajungjin/widgets/app_drawer.dart';

class TapScreen extends StatefulWidget {
  const TapScreen({super.key});

  @override
  State<TapScreen> createState() => _TapScreenState();
}

class _TapScreenState extends State<TapScreen> {
  late List<Map<String, Object>> _pages; //
  int _selectedPageIndex = 0;

  bool isManager =
      FirebaseAuth.instance.currentUser?.uid == 'MLZicFwQROVuFd36qz7dc59EiBm2';

  @override
  void initState() {
    _pages = isManager
        ? [
            {'page': UserManagementScreen(), 'title': 'user management'},
            {'page': ListScreen(), 'title': 'refrigerator list'},
            {'page': AllReceiptScreen(), 'title': 'all receipt'},
            {'page': ChannelListScreen(), 'title': 'voice of users'},
          ]
        : [
            {'page': ListScreen(), 'title': 'refrigerator list'},
            {'page': UserChatScreen(), 'title': 'chat to manager'},
            {'page': ReceiptScreen(), 'title': 'my receipt'},
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
              ? (isManager
                  ? [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(PlusItemScreen.routeName);
                          },
                          icon: Icon(Icons.add)),
                    ]
                  : [])
              : (_selectedPageIndex == 3 ? [] : [])),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.fixed,
          items: isManager
              ? [
                  BottomNavigationBarItem(
                      backgroundColor: Theme.of(context).primaryColor,
                      icon: Icon(Icons.people),
                      label: 'UserList'),
                  BottomNavigationBarItem(
                      backgroundColor: Theme.of(context).primaryColor,
                      icon: Icon(Icons.list),
                      label: 'List'),
                  BottomNavigationBarItem(
                      backgroundColor: Theme.of(context).primaryColor,
                      icon: Icon(Icons.people_alt_rounded),
                      label: 'profile'),
                  BottomNavigationBarItem(
                      backgroundColor: Theme.of(context).primaryColor,
                      icon: Icon(Icons.price_change),
                      label: 'voice'),
                ]
              : [
                  BottomNavigationBarItem(
                      backgroundColor: Theme.of(context).primaryColor,
                      icon: Icon(Icons.list),
                      label: 'List'),
                  BottomNavigationBarItem(
                      backgroundColor: Theme.of(context).primaryColor,
                      icon: Icon(Icons.people_alt_rounded),
                      label: 'chat to manager'),
                  BottomNavigationBarItem(
                      backgroundColor: Theme.of(context).primaryColor,
                      icon: Icon(Icons.price_change),
                      label: 'receipt'),
                ]),
    );
  }
}
