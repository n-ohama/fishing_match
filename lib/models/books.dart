import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'book.dart';

class Books with ChangeNotifier {
  List<Book> _items = [];

  List<Book> get items => [..._items];

  Book findById(String id) {
    return _items.firstWhere((book) => book.id == id);
  }

  Future<void> fetchData() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('books').get();
      final bookList = snapshot.docs.map((doc) {
        Map<String, dynamic> book = doc.data();
        return Book(
          id: book['id'],
          title: book['title'],
          owner: book['owner'],
          leaveDay: book['leaveDay'],
          price: book['price'],
          address: book['address'],
          currentNumber: book['currentNumber'],
          requireNumber: book['requireNumber'],
          capacity: book['capacity'],
          target: book['target'],
          note: book['note'],
          isRequiredTool: book['isRequiredTool'],
          memberList: book['memberList'],
          picture: book['picture'],
          ownerId: book['ownerId'],
        );
      }).toList();
      _items = bookList;
      notifyListeners();
    } catch (e) {
      print(e.toString() + 'nagatomo!');
    }
  }

  Future<void> addBook(Book formBook, File? imageFile) async {
    final imageId = formBook.id;
    String downloadURL = '';
    final ref = FirebaseStorage.instance.ref('ship_post/$imageId.png');

    if (imageFile != null) {
      await ref.putFile(imageFile);
      downloadURL = await FirebaseStorage.instance.ref('ship_post/$imageId.png').getDownloadURL();
    }

    final Book newBook = Book(
      id: formBook.id,
      title: formBook.title,
      owner: formBook.owner,
      leaveDay: formBook.leaveDay,
      price: formBook.price,
      address: formBook.address,
      currentNumber: formBook.currentNumber,
      requireNumber: formBook.requireNumber,
      capacity: formBook.capacity,
      target: formBook.target,
      note: formBook.note,
      isRequiredTool: formBook.isRequiredTool,
      memberList: formBook.memberList,
      picture: downloadURL,
      ownerId: formBook.ownerId,
    );

    final Map<String, dynamic> mapBook = {
      'id': newBook.id,
      'title': newBook.title,
      'owner': newBook.owner,
      'leaveDay': newBook.leaveDay,
      'price': newBook.price,
      'address': newBook.address,
      'currentNumber': newBook.currentNumber,
      'requireNumber': newBook.requireNumber,
      'capacity': newBook.capacity,
      'target': newBook.target,
      'note': newBook.note,
      'isRequiredTool': newBook.isRequiredTool,
      'memberList': newBook.memberList,
      'picture': downloadURL,
      'ownerId': newBook.ownerId,
    };
    await FirebaseFirestore.instance.collection('books').add(mapBook);
    _items.add(newBook);
    notifyListeners();
  }

  void joinBook(Book joinedBook, String uid) {
    final bookIndex = _items.indexWhere((book) => book.id == joinedBook.id);
    final newMemberList = [...joinedBook.memberList, uid];
    final Book newBook = Book(
      id: joinedBook.id,
      title: joinedBook.title,
      owner: joinedBook.owner,
      leaveDay: joinedBook.leaveDay,
      price: joinedBook.price,
      address: joinedBook.address,
      currentNumber: joinedBook.currentNumber + 1,
      requireNumber: joinedBook.requireNumber,
      capacity: joinedBook.capacity,
      target: joinedBook.target,
      note: joinedBook.note,
      isRequiredTool: joinedBook.isRequiredTool,
      memberList: newMemberList,
      picture: joinedBook.picture,
      ownerId: joinedBook.ownerId,
    );
    _items[bookIndex] = newBook;
    notifyListeners();
  }
}
