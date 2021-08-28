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
          if (isLogin) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (ctx) => AddbookScreen(uid),
            );
          } else {
            showDialog(
              context: context,
              builder: (dialogCtx) => AlertDialog(
                title: Text('ログイン後、募集可能です。ログインしますか？'),
                actions: [
                  ElevatedButton(
                    child: Text('Yes'),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                    },
                  ),
                  ElevatedButton(
                    child: Text('No'),
                    style: ElevatedButton.styleFrom(primary: Colors.red[300]),
                    onPressed: () {
                      Navigator.of(dialogCtx).pop();
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
      appBar: AppBar(
        title: Text('予約リスト'),
        actions: [
          if (!isLogin)
            TextButton(
              child: Text('ログイン', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
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
                child: GridView.count(
                  padding: EdgeInsets.all(10.0),
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  children: List.generate(
                    bookList.length,
                    (i) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(DetailScreen.routeName, arguments: {
                          'id': bookList[i].id,
                          'isLogin': isLogin,
                          'uid': uid,
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(5.0, 5.0),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Image.network(bookList[i].picture),
                            Container(
                              margin: EdgeInsets.only(left: 8, top: 4),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      '${bookList[i].title}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      '投稿者: ${bookList[i].owner}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      '料金: ${bookList[i].price}円',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      '日付: ${bookList[i].leaveDay}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
