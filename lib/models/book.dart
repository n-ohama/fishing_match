class Book {
  final String id;
  final String title;
  final String owner;
  final String leaveDay;
  final DateTime leaveDateTime;
  final int price;
  final String address;
  final int requireNumber;
  final int capacity;
  final String target;
  final String note;
  final bool isRequiredTool;
  final List memberList;
  final String picture;
  final String ownerId;
  Book({
    required this.id,
    required this.title,
    required this.owner,
    required this.leaveDay,
    required this.leaveDateTime,
    required this.price,
    required this.address,
    required this.requireNumber,
    required this.capacity,
    required this.target,
    required this.isRequiredTool,
    this.note = '',
    required this.memberList,
    this.picture = '',
    required this.ownerId,
  });
}
