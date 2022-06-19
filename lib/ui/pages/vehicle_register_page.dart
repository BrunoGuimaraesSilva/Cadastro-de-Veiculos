import 'package:cadastro_veiculos/datasources/datasources.dart';
import 'package:cadastro_veiculos/ui/components/components.dart';
import 'package:cadastro_veiculos/enums/button_enum.dart';
import 'package:cadastro_veiculos/models/models.dart';
import 'package:flutter/material.dart';

class VehicleRegisterPage extends StatefulWidget {
  final Brand brand;
  final Vehicle? vehicle;

  const VehicleRegisterPage({required this.brand, this.vehicle, Key? key})
      : super(key: key);

  @override
  State<VehicleRegisterPage> createState() => _VehicleRegisterPageState();
}

class _VehicleRegisterPageState extends State<VehicleRegisterPage> {
  final _vehicleHelper = VehicleHelper();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _valueController = TextEditingController();
  final dropValue = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    if (widget.vehicle != null) {
      _modelController.text = widget.vehicle!.model;

      _yearController.text = widget.vehicle!.year;

      _valueController.text = widget.vehicle!.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de veículos'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: _insertVehicle,
      ),
      body: ListView(
        children: [
          TextFieldTxt(controller: _modelController, text: 'Nome do modelo'),
          TextFieldTxt(
            controller: _yearController,
            text: 'Ano do veículo',
            keyboard: TextInputType.number,
          ),
          TextFieldTxt(
              controller: _valueController,
              text: 'Valor do veículo',
              keyboard: TextInputType.number),
          _createButtonDelete(),
        ],
      ),
    );
  }

  Widget _createButtonDelete() {
    if (widget.vehicle != null) {
      return Button(
        text: 'Excluir',
        click: _deleteVehicle,
      );
    }
    return Container();
  }

  void _deleteVehicle() {
    AlertMessage().show(
        context: context,
        title: 'Atenção',
        text: 'Deseja excluir esse veículo?',
        button: [
          Button(text: 'Sim', type: ButtonEnum.text, click: _confirmDelete),
          Button(
              text: 'Não',
              click: () {
                Navigator.pop(context);
              }),
        ]);
  }

  void _confirmDelete() {
    if (widget.vehicle != null) {
      _vehicleHelper.delete(widget.vehicle!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _insertVehicle() {
    //int valueVehicle = int.tryParse(_valueController.text) ?? 0;
    //int yearVehicle = int.tryParse(_yearController.text) ?? 0;
    if (_modelController.text.trim().isEmpty) {
      AlertMessage().show(
          context: context,
          title: 'Atenção',
          text: 'Insira o veículo!',
          button: [
            Button(
                text: 'OK',
                type: ButtonEnum.text,
                click: () {
                  Navigator.pop(context);
                })
          ]);

      return;
    }

    if (widget.vehicle == null) {
      _vehicleHelper.insert(
        Vehicle(
            model: _modelController.text,
            year: _yearController.text,
            value: _valueController.text,
            brand: widget.brand),
      );
    } else {
      _vehicleHelper.change(Vehicle(
          code: widget.vehicle!.code,
          model: _modelController.text,
          year: _yearController.text,
          value: _valueController.text,
          brand: widget.brand));
    }

    Navigator.pop(context);
  }
}
