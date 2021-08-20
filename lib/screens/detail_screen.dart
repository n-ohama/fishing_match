import 'package:fishing_match/constants.dart';
import 'package:fishing_match/models/books.dart';
import 'package:fishing_match/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';
  void showUpModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('ログイン後、参加可能です。ログインしますか？'),
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
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    final selectedBook = Provider.of<Books>(context, listen: false).findById(args['id']);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedBook.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: selectedBook.picture != ''
                  ? Image.network(selectedBook.picture)
                  : Image.asset('assets/images/noimage.png'),
            ),
            Row(
              children: [
                Text('現在の参加数', style: bigFontStyle),
                SizedBox(width: 32),
                Consumer<Books>(
                  builder: (_, bookProvider, __) => Text(
                    '${bookProvider.findById(args['id']).currentNumber}名',
                    style: bigFontStyle,
                  ),
                ),
                SizedBox(width: 32),
                Text('(定員${selectedBook.capacity}名)', style: bigFontStyle),
              ],
            ),
            Consumer<Books>(builder: (_, bookProvider, __) {
              int requireNumber = bookProvider.findById(args['id']).requireNumber -
                  bookProvider.findById(args['id']).currentNumber;
              return requireNumber > 0
                  ? Text(
                      '最低でもあと$requireNumber名参加すれば出港可能です。',
                      style: redBigFontStyle,
                    )
                  : Text('出港可能！', style: leaveOkStyle);
            }),
            Consumer<Books>(builder: (_, bookProvider, __) {
              return ElevatedButton(
                onPressed: bookProvider.findById(args['id']).memberList.contains(args['uid'])
                    ? null
                    : () {
                        if (args['isLogin']) {
                          Provider.of<Books>(context, listen: false)
                              .joinBook(bookProvider.findById(args['id']), args['uid']);
                        } else {
                          showUpModal(context);
                        }
                      },
                style: ElevatedButton.styleFrom(primary: Colors.red[300]),
                child: Text(
                  '参加する',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('オーナー', style: bigFontStyle),
                Text('${selectedBook.owner}', style: bigFontStyle),
              ],
            ),
            Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('料金(参加者で割り勘)', style: bigFontStyle),
                Text('${selectedBook.price}円', style: bigFontStyle),
              ],
            ),
            Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('集合場所', style: bigFontStyle),
                Text('${selectedBook.address}', style: bigFontStyle),
              ],
            ),
            Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('日付', style: bigFontStyle),
                Text('${selectedBook.leaveDay}', style: bigFontStyle),
              ],
            ),
            Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('狙い', style: bigFontStyle),
                Text('${selectedBook.target}', style: bigFontStyle),
              ],
            ),
            Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('釣具', style: bigFontStyle),
                selectedBook.isRequiredTool
                    ? Text(
                        '持参です',
                        style: bigFontStyle,
                      )
                    : Text('貸し出せます', style: bigFontStyle),
              ],
            ),
            Divider(thickness: 1),
            if (selectedBook.note.isNotEmpty)
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('備考', style: bigFontStyle),
                    SizedBox(height: 16),
                    Text('${selectedBook.note}', style: bigFontStyle),
                    Divider(thickness: 1),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
