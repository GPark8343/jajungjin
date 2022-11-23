import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jajungjin/screen/auth/auth_screen.dart';

import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Log out'),
            automaticallyImplyLeading: false,
          ),
        
         
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
    );
  }
}
