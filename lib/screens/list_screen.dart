import 'package:fishing_match/models/books.dart';
import 'package:fishing_match/models/shared_model.dart';
import 'package:fishing_match/screens/addbook_screen.dart';
import 'package:fishing_match/screens/auth/login_screen.dart';
import 'package:fishing_match/screens/detail_screen.dart';
import 'package:fishing_match/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool isLogin = false;
  bool _isLoading = false;
  String uid = '';

  void checkIsLogin() async {
    await SharedModel.getLoggedIn().then((value) {
      if (value == true) {
        setState(() {
          isLogin = true;
        });
      }
    });
    await SharedModel.getUid().then((value) {
      setState(() {
        if (value != null && value.isNotEmpty) {
          uid = value;
        } else {
          isLogin = false;
        }
      });
    });
  }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    checkIsLogin();
    Provider.of<Books>(context, listen: false).fetchData().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookList = Provider.of<Books>(context).items;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (ctx) => AddbookScreen(uid),
          );
        },
      ),
      appBar: AppBar(
        title: Text('予約リスト'),
        actions: [
          if (!isLogin)
            TextButton(
              child: Text('ログイン', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
              },
            )
        ],
      ),
      drawer: AppDrawer(isLogin),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.only(top: 8),
              child: RefreshIndicator(
                onRefresh: () async {
                  await Provider.of<Books>(context, listen: false).fetchData();
                },
                child: ListView.builder(
                  itemCount: bookList.length,
                  itemBuilder: (_, i) => ListTile(
                    leading: CircleAvatar(
                        child: Text('${bookList[i].owner.substring(0, 2)}')),
                    title: Text(bookList[i].title),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(DetailScreen.routeName, arguments: {
                        'id': bookList[i].id,
                        'isLogin': isLogin,
                        'uid': uid,
                      });
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
