
import 'package:jajungjin/screen/auth/auth_screen.dart';
import 'package:jajungjin/screen/pages/i_am_port_payment_screen.dart';
import 'package:jajungjin/screen/pages/item_detail_screen.dart';
import 'package:jajungjin/screen/pages/list_screen.dart';
import 'package:jajungjin/screen/pages/plus_item_screen.dart';
import 'package:jajungjin/screen/splash_screen.dart';
import 'package:jajungjin/screen/tab_screen.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
       
       
       
         MaterialApp(
          title: 'FlutterChat',
          theme: ThemeData(
              primarySwatch: Colors.pink,
              backgroundColor: Colors.pink,
              accentColor: Colors.deepPurple,
              accentColorBrightness: Brightness.dark,
              buttonTheme: ButtonTheme.of(context).copyWith(
                  buttonColor: Colors.pink,
                  textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)))),
          home: 
          StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              }
              if (userSnapshot
                  .hasData /*|| FirebaseAuth.instance.currentUser != null*/) {
                return TapScreen();
              }
              return AuthScreen();
            },
          ),
          routes: {
            AuthScreen.routeName:(ctx) => AuthScreen(),
               IamportPaymentScreen.routeName:(ctx) =>  IamportPaymentScreen(),
               PlusItemScreen.routeName:(ctx) =>  PlusItemScreen(),
               ItemDetailScreen.routeName:(ctx) =>  ItemDetailScreen(),
               ListScreen.routeName:(ctx) => ListScreen(),
            // PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
            // ChatScreen.routeName: (ctx) => ChatScreen(),
            // ChannelAddScreen.routeName: (ctx) => ChannelAddScreen(),
            // SplashScreen.routeName: (ctx) => SplashScreen(),
          },
        );
  }
}
