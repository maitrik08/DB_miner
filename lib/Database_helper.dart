import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuoteHelper {
  static final QuoteHelper _instance = QuoteHelper._internal();
  late Database _database;
  String TableName = 'quotes';

  factory QuoteHelper() => _instance;

  QuoteHelper._internal();

  Future<void> initializeDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'quotes.db');

    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $TableName (
        id INTEGER PRIMARY KEY,
        category TEXT,
        quote TEXT,
        author TEXT
      )
    ''');

    String jsonString = await rootBundle.loadString('assets/quotes.json');
    Map<String, dynamic> data = json.decode(jsonString);

    data.forEach((category, quotes) {
      if (quotes is List) {
        quotes.forEach((quote) async {
          await db.insert(
            'quotes',
            {
              'category': category,
              'quote': quote['quote'],
              'author': quote['author'], // Include author in the database
            },
          );
        });
      }
    });
  }

  Future<List<Map<String, dynamic>>> queryAllContacts() async {
    return await _database.query(TableName);
  }

  Future<List<Map<String, dynamic>>> getQuotesByCategory(String category) async {
    return await _database.query('quotes', where: 'category = ?', whereArgs: [category]);
  }
}
