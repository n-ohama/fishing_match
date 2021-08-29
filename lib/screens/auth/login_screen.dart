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
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ログイン')),
      drawer: AppDrawer(false),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: ListView(
                    // mainAxisSize: MainAxisSize.min,
                    shrinkWrap: true,
                    children: [
                      Container(
                        child: Text('メールアドレス'),
                        alignment: Alignment.topLeft,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!)
                              ? null
                              : "メールアドレスの入力です。";
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(hintText: 'example@gmail.com'),
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: Text('パスワード'),
                        alignment: Alignment.topLeft,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          return value!.length > 5 ? null : "6文字以上で入力してください。";
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              _isObscure = !_isObscure;
                              setState(() {});
                            },
                          ),
                        ),
                        obscureText: _isObscure,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          setState(() {
                            isLoading = true;
                          });
                          AuthModel()
                              .signInWithEmailAndPassword(
                                  _emailController.text, _passwordController.text)
                              .then(
                            (value) {
                              setState(() {
                                isLoading = false;
                              });
                              if (value.isEmpty) {
                                Navigator.of(context).pushReplacementNamed('/');
                              } else {
                                final String errorMsg = value == 'user-not-found'
                                    ? 'ユーザが見つかりません。'
                                    : value == 'wrong-password'
                                        ? 'パスワードが間違っています。'
                                        : value;
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text(errorMsg),
                                    actions: [
                                      ElevatedButton(
                                        child: Text('OK'),
                                        // style: ElevatedButton.styleFrom(primary: Colors.red[300]),
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          );
                        },
                        child: Text('ログインする'),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text('まだアカウントを持っていない場合は、'),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
                              },
                              child: Text('新規登録ページへ', style: underLineStyle),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
