import 'package:cadastro_veiculos/datasources/local/local.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBase {
  static final DataBase _instance = DataBase._internal();
  factory DataBase() => _instance;
  DataBase._internal();

  Database? _db;
  Future<Database> get db async {
    _db ??= await _startDb();
    return _db!;
  }

  Future<Database> _startDb() async {
    const nameData = "vehicle_registration.db";
    final path = await getDatabasesPath();
    final pathData = join(path, nameData);

    return await openDatabase(pathData, version: 1,
        onCreate: (Database db, int newVersion) async {
      await db.execute(VehicleHelper.createSql);
      await db.execute(BrandHelper.createSql);
    });
  }

  void close() async {
    _db?.close();
  }
}
