import 'dart:async';
import 'dart:isolate';

import 'package:sqflite/sqflite.dart';
import 'package:workers/model/bankmodel.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }
  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();
  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _randomUser = 'random_user';
  static const String _tblCacheArticle = 'cache_article';
  static const String _bankDetails = 'bank_details';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/newsapp.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblCacheArticle(
        id INTEGER PRIMARY KEY,
        source TEXT,
        author TEXT,
        title TEXT,
        description TEXT,
        url TEXT,
        urlToImage TEXT,
        publishedAt TEXT,
        content TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_bankDetails(
        did INTEGER PRIMARY KEY,
        id INTEGER,
        uid TEXT,
        account_number TEXT,
        iban TEXT,
        bank_name TEXT,
        routing_number TEXT,
        swift_bic TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_randomUser (
        did INTEGER PRIMARY KEY,
        id INTEGER,
        uid INTEGER,
        password TEXT,
        first_name TEXT,
        last_name TEXT,
        username TEXT,
        email TEXT,
        avatar TEXT,
        gender TEXT,
        phone_number TEXT,
        social_insurance_number,
        date_of_birth TEXT,
        employment TEXT,
        address TEXT,
        credit_card TEXT,
        subscription TEXT
      );
    ''');
  }

  Future<void> insertUsers(List userdata) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final data in userdata) {
        if (data.isNotEmpty) {
          txn.insert(_randomUser, data);
        }
      }
    });
  }

  Future<void> insertArticles(List articles) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final article in articles) {
        txn.insert(_tblCacheArticle, article);
      }
    });
  }

  Future<void> insertBanks(List details) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final detail in details) {
        txn.insert(_bankDetails, detail);
      }
    });
  }

  Future<List<UserData>> getCacheUser() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _randomUser,
    );
    print(">>>>>>$results");
    return results.map((e) => UserData.fromMap(e)).toList();
  }

  Future<List<Map<String, dynamic>>> getCacheArticles() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCacheArticle,
    );
    return results;
  }

  Future<List<Map<String, dynamic>>> getBankDetails() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _bankDetails,
    );
    return results;
  }

  Future<int> clearCacheUser() async {
    final db = await database;
    return db!.delete(
      _randomUser,
    );
  }

  Future<int> clearCacheBank() async {
    final db = await database;
    return db!.delete(
      _bankDetails,
    );
  }

  Future<int> clearCacheNews() async {
    final db = await database;
    return db!.delete(
      _tblCacheArticle,
    );
  }

  @pragma('vm:entry-point')
  static getdataintoLoacal(SendPort sendPort) async {
    //   ${prefs.getString("value")}
    print(">>>>>>>>>>>Stored data into pref using isolate q");
    sendPort.send("Stored data into pref using isolate ");
  }
}
