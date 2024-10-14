import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:word_book/models/book_item.dart';

class DatabaseHelper{
  static final _databaseHelper = DatabaseHelper._internal();
  
  final String _tableName = 'dict';

  Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _databaseHelper;
  
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }
  
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'word_book.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database db, int version) async {

    await db.execute('''
    CREATE TABLE IF NOT EXISTS $_tableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    turkish TEXT,
    english TEXT)''');
  }
  
  Future<int> add(BookItem entity) async{
    final Database db = await database;

    return await db.insert(_tableName, entity.toMap());
  }
  
  Future<int> update(BookItem entity) async{
    if(entity.id == null) throw Exception('The id field can not be null!');

    final Database db = await database;
    
    return await db.update(_tableName, entity.toMap(), where: 'id = ?', whereArgs: [entity.id]);
  }

  Future<int> delete(int id) async{
    final Database db = await database;

    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<BookItem>> getAll() async {
    final Database db = await database;

    List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (index)=>BookItem.fromMap(maps[index]));
  }

  Future<BookItem?> getById(int id) async {
    final Database db = await database;

    List<Map<String, dynamic>> maps = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);

    return (maps.isEmpty) ? null : BookItem.fromMap(maps.first);

  }
}