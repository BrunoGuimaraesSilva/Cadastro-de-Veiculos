import 'package:cadastro_veiculos/extensions/extensions.dart';
import 'package:cadastro_veiculos/models/models.dart';

class Brand {
  static const Table = 'TbBrand';
  static const codeField = 'code';
  static const nameField = 'name';

  int? code;
  String name;

  Brand({this.code, required this.name});

  factory Brand.fromMap(Map mapa) {
    return Brand(
      code: mapa[codeField].toString().toInt(),
      name: mapa[nameField],
    );
  }

  Map<String, dynamic> toMap() {
    return {codeField: code, nameField: name};
  }
}
