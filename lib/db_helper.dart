import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'users.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT)',
        );
      },
    );
  }

  static Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await DBHelper.database();
    return db.insert('users', user);
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await DBHelper.database();
    return db.query('users');
  }
}