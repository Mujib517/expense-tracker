import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:tracker/model/category.dart';
import 'package:tracker/model/entry.dart';
import 'package:tracker/util/queries.dart';

class DbHelper {
  String tblData = "entry", tblCat = "category";
  static Database _db;

  Future<Database> get db async {
    if (_db == null) _db = await init();
    return _db;
  }

  // Singleton
  static final _dbHelper = new DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future<Database> init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, "t7.db");
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(Queries.createCatTable);
    await db.execute(Queries.createEntryTable);
    await db.execute(Queries.seedCatData);
  }

  Future<int> insertCategory(Category category) async {
    Database db = await this.db;
    return await db.insert(tblCat, category.toMap());
  }

  Future<int> insertEntry(Entry entry) async {
    Database db = await this.db;
    return await db.insert(tblData, entry.toMap());
  }

  Future<List> getCategories() async {
    Database db = await this.db;
    return await db.rawQuery("SELECT * FROM $tblCat");
  }

  Future<List> getEntriesByType(int type) async {
    Database db = await this.db;
    return await db.rawQuery(Queries.getExpensesEntry, [type]);
  }

  Future<List> getCategoriesByType(int type) async {
    Database db = await this.db;
    return await db.rawQuery("SELECT * FROM $tblCat WHERE type=$type");
  }

//  Future<int> update(Item item) async {
//    var db = await this.db;
//    return await db
//        .update(tbl, item.toMap(), where: 'id=?', whereArgs: [item.id]);
//  }

  Future<int> deleteCategory(int id) async {
    var db = await this.db;
    return await db.delete(tblCat, where: 'id=?', whereArgs: [id]);
  }
}
