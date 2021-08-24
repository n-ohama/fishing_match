import 'package:fishing_match/constants.dart';
import 'package:fishing_match/models/auth_model.dart';
import 'package:fishing_match/screens/auth/login_screen.dart';
import 'package:fishing_match/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('新規登録')),
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
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: 'example@gmail.com'),
                    ),
                    SizedBox(height: 8),
                    Container(
                      child: Text('パスワード'),
                      alignment: Alignment.topLeft,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                    ),
                    SizedBox(height: 8),
                    Container(
                      child: Text('パスワード(確認用)'),
                      alignment: Alignment.topLeft,
                    ),
                    TextField(
                      controller: rePasswordController,
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await AuthModel()
                            .signUpWithEmailAndPassword(
                                emailController.text, passwordController.text)
                            .then((user) {
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.of(context).pushReplacementNamed('/');
                        });
                      },
                      child: Text('登録する'),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text('すでにアカウントを持っている場合は、'),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                            },
                            child: Text('ログインページへ', style: underLineStyle),
                          ),
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
