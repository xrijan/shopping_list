import 'dart:io' as di;
import 'package:path_provider/path_provider.dart';
import 'package:project1/shopping_list.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DataBaseSupport {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return null;
  }

// create database for local storage memory
  initDatabase() async {
    di.Directory docDict = await getApplicationDocumentsDirectory();
    String path = join(docDict.path, "ShoppingList.db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async{
    await db.execute(
      "CREATE TABLE shoppingList (id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE,productNames TEXT,productData TEXT,totalNumberOfProducts INTEGER)"
    );
  }

  Future<ShoppingList> insert(ShoppingList shoppingList) async {
    // print(shoppingList.toMap());
    var dbClient = await db;
    await dbClient!.insert("shoppingList" , shoppingList.toMap());
    return shoppingList;
  }

  Future<List<ShoppingList>> getShoppingList() async {
    var dbClient = await db;
    final List<Map<String , Object ?>> queryResult = await dbClient!.query("shoppingList");
    return queryResult.map((e) => ShoppingList.fromMap(e)).toList();

  }

  Future<int> delete(int id) async{
    var dbClient = await db;
    return await dbClient!.delete(
      "shoppingList",
      where: "id = ?",
        whereArgs: [id]
    );
  }

  Future<int> totalItems(ShoppingList shoppingList) async{
    var dbClient = await db;
    return await dbClient!.update(
        "shoppingList",
        shoppingList.toMap(),
        where: "id = ?",
        whereArgs: [shoppingList.id]
    );
  }
}

