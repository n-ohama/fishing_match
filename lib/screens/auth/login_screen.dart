import 'package:fishing_match/constants.dart';
import 'package:fishing_match/models/auth_model.dart';
import 'package:fishing_match/screens/auth/signup_screen.dart';
import 'package:fishing_match/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ログイン')),
      drawer: AppDrawer(false),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Text('メールアドレス'),
                      alignment: Alignment.topLeft,
                    ),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: 'example@gmail.com'),
                    ),
                    SizedBox(height: 8),
                    Container(
                      child: Text('パスワード'),
                      alignment: Alignment.topLeft,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        AuthModel()
                            .signInWithEmailAndPassword(
                                _emailController.text, _passwordController.text)
                            .then(
                          (_) {
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context).pushReplacementNamed('/');
                          },
                        );
                      },
                      child: Text('ログインする'),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text('まだアカウントを持っていない場合は、'),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
                          },
                          child: Text('新規登録ページへ', style: underLineStyle),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
