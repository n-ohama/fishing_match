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
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _isObscure = true;
  bool _isReObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('新規登録')),
      drawer: AppDrawer(false),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        child: Text('メールアドレス'),
                        alignment: Alignment.topLeft,
                      ),
                      TextFormField(
                        controller: emailController,
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
                        controller: passwordController,
                        validator: (value) {
                          return value!.length > 5 ? null : "6文字以上で入力してください。";
                        },
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.visibility),
                            onPressed: () {
                              _isObscure = !_isObscure;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: Text('パスワード(確認用)'),
                        alignment: Alignment.topLeft,
                      ),
                      TextFormField(
                        controller: rePasswordController,
                        validator: (value) {
                          return value == passwordController.text ? null : '上と同じように入力してください。';
                        },
                        obscureText: _isReObscure,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.visibility),
                            onPressed: () {
                              _isReObscure = !_isReObscure;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
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
            ),
    );
  }
}
