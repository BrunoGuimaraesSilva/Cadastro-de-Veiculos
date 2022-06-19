import 'package:cadastro_veiculos/extensions/extensions.dart';
import 'package:cadastro_veiculos/models/models.dart';

class Vehicle {
  static const Table = 'TbVehicle';
  static const codeField = 'code';
  static const modelField = 'model';
  static const yearField = 'year';
  static const valueField = 'value';
  static const brandField = 'brand';

  int? code;
  String model;
  String year;
  String value;
  Brand brand;

  Vehicle({
    this.code,
    required this.model,
    required this.year,
    required this.value,
    required this.brand,
  });

  factory Vehicle.fromMap(Map map, Brand brand) {
    return Vehicle(
      code: map[codeField].toString().toInt(),
      model: map[modelField],
      year: map[yearField],
      value: map[valueField],
      brand: brand,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      codeField: code,
      modelField: model,
      yearField: year,
      valueField: value,
      brandField: brand.code,
    };
  }
}
