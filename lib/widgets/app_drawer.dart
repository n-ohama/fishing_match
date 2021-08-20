import 'package:fishing_match/debag.dart';
import 'package:fishing_match/models/auth_model.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final bool isLogin;
  AppDrawer(this.isLogin);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('メニュー'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text('予約リスト'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          if (isLogin)
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('ログアウトする'),
              onTap: () async {
                await AuthModel().signOut();
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ListTile(
            title: Text('デバック用'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Debag.routeName);
            },
          ),
        ],
      ),
    );
  }
}
