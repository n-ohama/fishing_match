import 'package:fishing_match/constants.dart';
import 'package:fishing_match/freezed/book.dart';
import 'package:fishing_match/models/state_manager.dart';
import 'package:fishing_match/screens/addbook_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト画面', style: TextStyle(color: Colors.black87)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddbookScreen.routeName);
        },
      ),
      body: Consumer(
        builder: (_, watch, __) {
          final AsyncValue<List<Book>> booksState = watch(bookStateFuture);
          return booksState.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text('Error: $error'),
            data: (books) {
              return ListView.builder(
                itemCount: books.length,
                itemBuilder: (_, i) {
                  return InkWell(
                    onTap: () {},
                    child: Card(
                      child: Row(
                        children: [
                          Image.asset('assets/images/noimage_home.jpeg', height: 100),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${books[i].title}', style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text('投稿者: ${books[i].owner}', style: smallStyle),
                              SizedBox(height: 4),
                              Text(
                                '日付: ${DateFormat('yyyy年MM月dd日 HH:mm').format(books[i].leaveDay)}',
                                style: smallStyle,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
