import 'package:cadastro_veiculos/datasources/datasources.dart';
import 'package:cadastro_veiculos/enums/button_enum.dart';
import 'package:cadastro_veiculos/models/models.dart';
import 'package:cadastro_veiculos/ui/components/components.dart';
import 'package:cadastro_veiculos/ui/pages/pages.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _brandHelper = BrandHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de marcas de veículos"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _openRegisterBrand();
        },
      ),
      body: FutureBuilder(
        future: _brandHelper.getAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const WaitingCircle();
            default:
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return _createBrandList(snapshot.data as List<Brand>);
              }
          }
        },
      ),
    );
  }

  Widget _createBrandList(List<Brand> listBrand) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      itemCount: listBrand.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.horizontal,
          child: _createListItem(listBrand[index]),
          background: Container(
            alignment: const Alignment(-1, 0),
            color: Colors.blue,
            child: const Text(
              "Editar",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          secondaryBackground: Container(
            alignment: const Alignment(1, 0),
            color: Colors.red,
            child: const Text(
              "Excluir",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              _brandHelper.delete(listBrand[index]);
            } else if (direction == DismissDirection.startToEnd) {
              _openRegisterBrand(brand: listBrand[index]);
            }
          },
          confirmDismiss: (DismissDirection direction) async {
            if (direction == DismissDirection.endToStart) {
              return await AlertMessage().show(
                  context: context,
                  title: "Atenção",
                  text: "Deseja excluir esta marca?",
                  button: [
                    Button(
                      text: 'Sim',
                      type: ButtonEnum.text,
                      click: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                    Button(
                      text: 'Não',
                      click: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ]);
            }
            return true;
          },
        );
      },
    );
  }

  Widget _createListItem(Brand brand) {
    return GestureDetector(
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                brand.name,
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => VehiclePage(brand)));
      },
      onLongPress: () {
        _openRegisterBrand(brand: brand);
      },
    );
  }

  void _openRegisterBrand({Brand? brand}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BrandRegisterPage(
                  brand: brand,
                )));
    setState(() {});
  }
}
