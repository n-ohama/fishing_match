import 'package:fishing_match/freezed/book.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Books extends StateNotifier<List<Book>> {
  Books() : super([]);
}

// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// import 'book.dart';

// class Books with ChangeNotifier {
//   List<Book> _items = [];

//   List<Book> get items => [..._items];

//   Book findById(String id) {
//     return _items.firstWhere((book) => book.id == id);
//   }

//   Future<void> fetchData() async {
//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection('books')
//           .where('leaveDateTime', isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
//           .orderBy('leaveDateTime', descending: true)
//           .get();
//       final bookList = snapshot.docs.map((doc) {
//         Map<String, dynamic> book = doc.data();
//         return Book(
//           id: book['id'],
//           title: book['title'],
//           owner: book['owner'],
//           leaveDay: book['leaveDay'],
//           leaveDateTime: book['leaveDateTime'].toDate(),
//           price: book['price'],
//           address: book['address'],
//           requireNumber: book['requireNumber'],
//           capacity: book['capacity'],
//           target: book['target'],
//           note: book['note'],
//           isRequiredTool: book['isRequiredTool'],
//           memberList: book['memberList'],
//           picture: book['picture'],
//           ownerId: book['ownerId'],
//         );
//       }).toList();
//       bookList.removeWhere((book) => book.capacity == book.memberList.length);
//       _items = bookList;
//       notifyListeners();
//     } catch (e) {
//       print(e.toString() + 'nagatomo!');
//     }
//   }

//   Future<void> addBook(Book formBook, File? imageFile) async {
//     final imageId = formBook.id;
//     String downloadURL = '';
//     final ref = FirebaseStorage.instance.ref('ship_post/$imageId.png');

//     if (imageFile != null) {
//       await ref.putFile(imageFile);
//       downloadURL = await FirebaseStorage.instance.ref('ship_post/$imageId.png').getDownloadURL();
//     }

//     final Book newBook = Book(
//       id: formBook.id,
//       title: formBook.title,
//       owner: formBook.owner,
//       leaveDay: formBook.leaveDay,
//       leaveDateTime: formBook.leaveDateTime,
//       price: formBook.price,
//       address: formBook.address,
//       requireNumber: formBook.requireNumber,
//       capacity: formBook.capacity,
//       target: formBook.target,
//       note: formBook.note,
//       isRequiredTool: formBook.isRequiredTool,
//       memberList: formBook.memberList,
//       picture: downloadURL,
//       ownerId: formBook.ownerId,
//     );

//     final Map<String, dynamic> mapBook = {
//       'id': newBook.id,
//       'title': newBook.title,
//       'owner': newBook.owner,
//       'leaveDay': newBook.leaveDay,
//       'leaveDateTime': newBook.leaveDateTime,
//       'price': newBook.price,
//       'address': newBook.address,
//       'requireNumber': newBook.requireNumber,
//       'capacity': newBook.capacity,
//       'target': newBook.target,
//       'note': newBook.note,
//       'isRequiredTool': newBook.isRequiredTool,
//       'memberList': newBook.memberList,
//       'picture': downloadURL,
//       'ownerId': newBook.ownerId,
//     };
//     await FirebaseFirestore.instance.collection('books').doc(newBook.id).set(mapBook);
//     // _items.add(newBook);
//     _items.insert(0, newBook);
//     notifyListeners();
//   }

//   Future<void> joinBook(Book joinedBook, String uid, BuildContext context) async {
//     final bookIndex = _items.indexWhere((book) => book.id == joinedBook.id);
//     final newMemberList = [...joinedBook.memberList, uid];
//     final Book newBook = Book(
//       id: joinedBook.id,
//       title: joinedBook.title,
//       owner: joinedBook.owner,
//       leaveDay: joinedBook.leaveDay,
//       leaveDateTime: joinedBook.leaveDateTime,
//       price: joinedBook.price,
//       address: joinedBook.address,
//       requireNumber: joinedBook.requireNumber,
//       capacity: joinedBook.capacity,
//       target: joinedBook.target,
//       note: joinedBook.note,
//       isRequiredTool: joinedBook.isRequiredTool,
//       memberList: newMemberList,
//       picture: joinedBook.picture,
//       ownerId: joinedBook.ownerId,
//     );

//     final bookData = await FirebaseFirestore.instance.collection('books').doc(newBook.id).get();
//     if (bookData['memberList'].length > bookData['capacity']) {
//       showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//           title: Text('申し訳ございません。定員がオーバーしたため、参加できませんでした。'),
//         ),
//       ).then((_) {
//         Navigator.of(context).pushReplacementNamed('/');
//       });
//     } else {
//       await FirebaseFirestore.instance.collection('books').doc(newBook.id).update({'memberList': newMemberList});
//       _items[bookIndex] = newBook;
//       notifyListeners();
//     }
//   }

//   Future<void> cancelBook(Book cancelBook, String uid) async {
//     final bookIndex = _items.indexWhere((book) => book.id == cancelBook.id);
//     cancelBook.memberList.remove(uid);
//     final Book newBook = Book(
//       id: cancelBook.id,
//       title: cancelBook.title,
//       owner: cancelBook.owner,
//       leaveDay: cancelBook.leaveDay,
//       leaveDateTime: cancelBook.leaveDateTime,
//       price: cancelBook.price,
//       address: cancelBook.address,
//       requireNumber: cancelBook.requireNumber,
//       capacity: cancelBook.capacity,
//       target: cancelBook.target,
//       note: cancelBook.note,
//       isRequiredTool: cancelBook.isRequiredTool,
//       memberList: cancelBook.memberList,
//       picture: cancelBook.picture,
//       ownerId: cancelBook.ownerId,
//     );
//     await FirebaseFirestore.instance.collection('books').doc(newBook.id).update({'memberList': cancelBook.memberList});
//     _items[bookIndex] = newBook;
//     notifyListeners();
//   }
// }
