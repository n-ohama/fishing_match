import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'book.freezed.dart';
part 'book.g.dart';

@freezed
class Book with _$Book {
  const factory Book({
    required String id,
    required String title,
    required String owner,
    required DateTime leaveDay,
    required int price,
    required String address,
    required int requireNumber,
    required int capacity,
    required String target,
    required List memberList,
    required String ownerId,
    @Default("") String picture,
    @Default("") String note,
    @Default(true) bool isRequireTool,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
