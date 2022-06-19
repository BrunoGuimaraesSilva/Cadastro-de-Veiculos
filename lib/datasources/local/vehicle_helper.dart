import 'package:cadastro_veiculos/datasources/datasources.dart';
import 'package:cadastro_veiculos/models/models.dart';
import 'package:sqflite/sqflite.dart';

class VehicleHelper {
  static const createSql = '''
    CREATE TABLE IF NOT EXISTS ${Vehicle.Table} (
      ${Vehicle.codeField} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Vehicle.modelField} TEXT,
      ${Vehicle.yearField} TEXT,
      ${Vehicle.valueField} TEXT,
      ${Vehicle.brandField} INTEGER,
      FOREIGN KEY(${Vehicle.brandField})
        REFERENCES ${Brand.Table}(${Brand.codeField})
    )
  ''';

  Future<Vehicle> insert(Vehicle vehicle) async {
    Database db = await DataBase().db;
    print(vehicle);
    vehicle.code = await db.insert(Vehicle.Table, vehicle.toMap());

    return vehicle;
  }

  Future<int> change(Vehicle vehicle) async {
    Database db = await DataBase().db;

    int affectedLines = await db.update(Vehicle.Table, vehicle.toMap(),
        where: '${Vehicle.codeField} = ?', whereArgs: [vehicle.code]);

    return affectedLines;
  }

  Future<int> delete(Vehicle vehicle) async {
    Database db = await DataBase().db;

    int affectedLines = await db.delete(Vehicle.Table,
        where: '${Vehicle.codeField} = ?', whereArgs: [vehicle.code]);

    return affectedLines;
  }

  Future<List<Vehicle>> getByBrand(int codBrand) async {
    Brand? brand = await BrandHelper().getBrand(codBrand);

    if (brand != null) {
      Database db = await DataBase().db;

      List listData = await db.query(Vehicle.Table,
          where: '${Vehicle.brandField} = ?',
          whereArgs: [codBrand],
          orderBy: Vehicle.modelField);
      return listData.map((e) => Vehicle.fromMap(e, brand)).toList();
    }

    return [];
  }
}
