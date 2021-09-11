import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fishing_match/freezed/book.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookStateFuture = FutureProvider<List<Book>>((ref) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('books')
      .where('leaveDay', isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
      .orderBy('leaveDay', descending: true)
      .get();
  return snapshot.docs.map((doc) {
    Map<String, dynamic> data = doc.data();
    return Book.fromJson(data);
  }).toList();
});
