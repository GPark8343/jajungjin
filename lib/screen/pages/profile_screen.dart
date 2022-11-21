import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const routeName = '/receipt';

  @override
  Widget build(BuildContext context) {
    bool isManager = FirebaseAuth.instance.currentUser?.uid ==
        'MLZicFwQROVuFd36qz7dc59EiBm2';
    return Scaffold(
      body: Center(child: Text(isManager?'나 관리자':'나 손님')),
    );
  }
}
