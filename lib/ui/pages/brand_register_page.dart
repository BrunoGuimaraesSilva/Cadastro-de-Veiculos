import 'package:cadastro_veiculos/datasources/datasources.dart';
import 'package:cadastro_veiculos/enums/button_enum.dart';
import 'package:cadastro_veiculos/models/models.dart';
import 'package:cadastro_veiculos/ui/components/components.dart';
import 'package:flutter/material.dart';

class BrandRegisterPage extends StatefulWidget {
  final Brand? brand;

  const BrandRegisterPage({this.brand, Key? key}) : super(key: key);

  @override
  State<BrandRegisterPage> createState() => _BrandRegisterPageState();
}

class _BrandRegisterPageState extends State<BrandRegisterPage> {
  final _brandHelper = BrandHelper();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.brand != null) {
      _nameController.text = widget.brand!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Marca'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: _insertBrand,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFieldTxt(controller: _nameController, text: 'Nome da marca:'),
            _createButtonDelete(),
          ],
        ),
      ),
    );
  }

  void _insertBrand() {
    if (_nameController.text.trim().isEmpty) {
      AlertMessage().show(
          context: context,
          title: 'Atenção',
          text: 'Insira a marca!',
          button: [
            Button(
                text: 'OK',
                type: ButtonEnum.text,
                click: () {
                  Navigator.pop(context);
                }),
          ]);
      return;
    }

    if (widget.brand == null) {
      _brandHelper.insert(Brand(name: _nameController.text));
    } else {
      _brandHelper.change(Brand(
        code: widget.brand!.code,
        name: _nameController.text,
      ));
    }

    Navigator.pop(context);
  }

  Widget _createButtonDelete() {
    if (widget.brand != null) {
      return Button(
        icon: Icons.delete,
        click: _deleteBrand,
      );
    }
    return Container();
  }

  void _deleteBrand() {
    AlertMessage().show(
        context: context,
        title: 'Atenção',
        text: 'Deseja excluir essa marca?',
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
    if (widget.brand != null) {
      _brandHelper.delete(widget.brand!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
