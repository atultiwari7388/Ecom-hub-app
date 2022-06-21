import 'package:ecom_hub/models/product.models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDatabase();
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'favorite.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

//for create table
  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE cart (id INTEGER PRIMARY KEY , productId VARCHAR UNIQUE,productName TEXT,initialPrice INTEGER, productPrice INTEGER , productQuantity INTEGER, productUnitTag TEXT , images TEXT )',
    );
  }

  //for insert data

  Future<ProductModel> insert(ProductModel product) async {
    var dbClient = await db;
    print(product.toMap());
    await dbClient!.insert('cart', product.toMap());
    return product;
  }
//for get data

  Future<List<ProductModel>> getCartList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('cart');
    return queryResult.map((e) => ProductModel.fromMap(e)).toList();
  }

  // delete data
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }
}
