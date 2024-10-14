class BookItem {
  int? _id;
  String? turkish;
  String? english;

  BookItem(int? id, {required this.turkish, required this.english}) : _id = id;

  factory BookItem.fromMap(Map<String, dynamic> map) =>
      BookItem(map['id'], turkish: map['turkish'], english: map["english"]);

  int? get id => _id;

  Map<String, dynamic> toMap() => {
    'id': _id,
    'turkish': turkish,
    'english': english
  };
}
