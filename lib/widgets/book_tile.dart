import 'package:fishing_match/screens/detail_screen.dart';
import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  final String id;
  final String title;
  final String owner;
  final String leaveDay;
  BookTile(this.id, this.title, this.owner, this.leaveDay);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(DetailScreen.routeName, arguments: id);
      },
      leading: CircleAvatar(child: Text('${owner.substring(0, 2)}')),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
