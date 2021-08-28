import 'package:firebase_core/firebase_core.dart';
import 'package:fishing_match/debag.dart';
import 'package:fishing_match/models/books.dart';
import 'package:fishing_match/screens/auth/login_screen.dart';
import 'package:fishing_match/screens/auth/signup_screen.dart';
import 'package:fishing_match/screens/detail_screen.dart';
import 'package:fishing_match/screens/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Books()),
      ],
      child: MaterialApp(
        title: 'Fishing Match',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        routes: {
          DetailScreen.routeName: (_) => DetailScreen(),
          SignupScreen.routeName: (_) => SignupScreen(),
          LoginScreen.routeName: (_) => LoginScreen(),
          Debag.routeName: (_) => Debag(),
        },
        home: ListScreen(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale("en"),
          const Locale("ja"),
        ],
      ),
    );
  }
}
