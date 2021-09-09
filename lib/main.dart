import 'package:firebase_core/firebase_core.dart';
import 'package:fishing_match/screens/addbook_screen.dart';
import 'package:fishing_match/screens/auth/login_screen.dart';
import 'package:fishing_match/screens/auth/signup_screen.dart';
import 'package:fishing_match/screens/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All Match',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routes: {
        SignupScreen.routeName: (_) => SignupScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        AddbookScreen.routeName: (_) => AddbookScreen(),
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
    );
  }
}
