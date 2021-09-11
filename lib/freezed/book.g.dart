// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Book _$_$_BookFromJson(Map<String, dynamic> json) {
  return _$_Book(
    id: json['id'] as String,
    title: json['title'] as String,
    owner: json['owner'] as String,
    // leaveDay: DateTime.parse(json['leaveDay'] as String),
    leaveDay: json['leaveDay'].toDate(),
    price: json['price'] as int,
    address: json['address'] as String,
    requireNumber: json['requireNumber'] as int,
    capacity: json['capacity'] as int,
    target: json['target'] as String,
    memberList: json['memberList'] as List<dynamic>,
    ownerId: json['ownerId'] as String,
    picture: json['picture'] as String? ?? '',
    note: json['note'] as String? ?? '',
    isRequireTool: json['isRequireTool'] as bool? ?? true,
  );
}

Map<String, dynamic> _$_$_BookToJson(_$_Book instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'owner': instance.owner,
      // 'leaveDay': instance.leaveDay.toIso8601String(),
      'leaveDay': instance.leaveDay,
      'price': instance.price,
      'address': instance.address,
      'requireNumber': instance.requireNumber,
      'capacity': instance.capacity,
      'target': instance.target,
      'memberList': instance.memberList,
      'ownerId': instance.ownerId,
      'picture': instance.picture,
      'note': instance.note,
      'isRequireTool': instance.isRequireTool,
    };
