import 'package:cadastro_veiculos/datasources/datasources.dart';
import 'package:cadastro_veiculos/models/models.dart';
import 'package:sqflite/sqflite.dart';

class BrandHelper {
  static const createSql = '''
    CREATE TABLE IF NOT EXISTS ${Brand.Table} (
      ${Brand.codeField} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Brand.nameField} TEXT
    )
  ''';

  Future<Brand> insert(Brand brand) async {
    Database db = await DataBase().db;

    brand.code = await db.insert(Brand.Table, brand.toMap());

    return brand;
  }

  Future<int> change(Brand brand) async {
    Database db = await DataBase().db;

    int data = await db.update(Brand.Table, brand.toMap(),
        where: '${Brand.codeField} = ?', whereArgs: [brand.code]);

    return data;
  }

  Future<int> delete(Brand brand) async {
    Database db = await DataBase().db;

    int data = await db.delete(Brand.Table,
        where: '${Brand.codeField} = ?', whereArgs: [brand.code]);

    return data;
  }

  Future<List<Brand>> getAll() async {
    Database db = await DataBase().db;

    List listData = await db.query(Brand.Table);

    return listData.map((e) => Brand.fromMap(e)).toList();
  }

  Future<Brand?> getBrand(int code) async {
    Database db = await DataBase().db;

    List listData = await db.query(Brand.Table,
        columns: [Brand.codeField, Brand.nameField],
        where: '${Brand.codeField} = ?',
        whereArgs: [code]);

    if (listData.isNotEmpty) {
      return Brand.fromMap(listData.first);
    }
    return null;
  }

  Future<int> getTotal() async {
    Database db = await DataBase().db;

    return Sqflite.firstIntValue(
            await db.rawQuery("SELECT COUNT(*) FROM ${Brand.Table}")) ??
        0;
  }
}
