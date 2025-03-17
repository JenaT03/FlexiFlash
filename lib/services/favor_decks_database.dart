import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavorDecksDatabase {
  static final FavorDecksDatabase instance = FavorDecksDatabase._init();
  static Database? _database;

  FavorDecksDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favor_deck.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favor_deck(
        deckId TEXT PRIMARY KEY
      )
    ''');
  }

  //  Thêm một deckId vào danh sách yêu thích
  Future<void> insertFavDeck(String deckId) async {
    final db = await instance.database;
    await db.insert(
      'favor_deck',
      {'deckId': deckId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Kiểm tra xem deckId có tồn tại trong danh sách yêu thích không
  Future<bool> isFavDeck(String deckId) async {
    final db = await instance.database;
    final result = await db.query(
      'favor_deck',
      where: 'deckId = ?',
      whereArgs: [deckId],
    );
    return result.isNotEmpty;
  }

  // Lấy danh sách tất cả các deckId yêu thích
  Future<List<String>> getAllFavDecks() async {
    final db = await instance.database;
    final result = await db.query('favor_deck');

    return result.map((map) => map['deckId'] as String).toList();
  }

  // Xóa một deckId khỏi danh sách yêu thích
  Future<void> deleteFavDeck(String deckId) async {
    final db = await instance.database;
    await db.delete('favor_deck', where: 'deckId = ?', whereArgs: [deckId]);
  }
}
