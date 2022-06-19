import 'package:cadastro_veiculos/ui/components/components.dart';
import 'package:cadastro_veiculos/datasources/datasources.dart';
import 'package:cadastro_veiculos/ui/pages/pages.dart';
import 'package:cadastro_veiculos/models/models.dart';
import 'package:flutter/material.dart';

class VehiclePage extends StatefulWidget {
  final Brand brand;

  const VehiclePage(this.brand, {Key? key}) : super(key: key);

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  final _vehicleHelper = VehicleHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.brand.name),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _openRegisterVehicle,
      ),
      body: FutureBuilder(
        future: _vehicleHelper.getByBrand(widget.brand.code ?? 0),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const WaitingCircle();
            default:
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return _listCreate(snapshot.data as List<Vehicle>);
          }
        },
      ),
    );
  }

  Widget _listCreate(List<Vehicle> dataList) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return _createItemList(dataList[index]);
        });
  }

  Widget _createItemList(Vehicle vehicle) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [Text(vehicle.model)],
          ),
        ),
      ),
      onTap: () {
        _openRegisterVehicle(vehicle: vehicle);
      },
    );
  }

  void _openRegisterVehicle({Vehicle? vehicle}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                VehicleRegisterPage(brand: widget.brand, vehicle: vehicle)));

    setState(() {});
  }
}
