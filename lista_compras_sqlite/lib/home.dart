import 'package:flutter/material.dart';
import 'package:lista_compras_sqlite/helper/anotacao_helper.dart';
import 'package:lista_compras_sqlite/model/compra.dart';

class Home extends StatefulWidget {
  const Home({Key? key}): super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  final _db = AnotacaoHelper();
  List<Compra> _compras = <Compra>[];
  final _formKey = GlobalKey<FormState>();
  double heightSize = 0.0;

  @override
  Widget build(BuildContext context) {
    heightSize = MediaQuery.of(context).size.height * 0.88;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: heightSize ,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _compras.length,
                  itemBuilder: (context, index) {
                    final compra = _compras[index];
                    return Card(
                      child: ListTile(
                        title: Text(compra.nome),
                        subtitle: Text('Quantidade: ${compra.quantidade}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _exibirTelaCadastro(compra: compra);
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _removerCompra(compra.id!);
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          _exibirTelaCadastro();
        }
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _recuperarCompras();
  }

  exibeModal(textoSalvarAtualizar, Compra? compra) {
    // Exibe o modal
    showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: AlertDialog(
              title: Text('$textoSalvarAtualizar compra '),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'O Campo não pode estar vazio';
                      }
                      return null;
                    },
                    controller: _nomeController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Nome do Produto',
                      hintText: 'Digite o produto...',
                    ),
                  ),
                  TextFormField(
                    maxLength: 2,
                    validator: (value) {
                      String pattern = r'([0-9])';
                      RegExp regExp = RegExp(pattern);
                      if (value == null || value.isEmpty || value == '0') {
                        return 'O campo não pode estar vazio';
                      } else if(!regExp.hasMatch(value)) {
                        return 'Digite um valor valido';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: _quantidadeController,
                    decoration: const InputDecoration(
                      labelText: 'Quantidade',
                      hintText: 'Digite a quantidade...',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      _salvarAtualizarCompra(compraSelecionada: compra);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(textoSalvarAtualizar),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  _exibirTelaCadastro({Compra? compra}) {
    String textoSalvarAtualizar = '';
    if(compra == null) {
      // Campos Tela Salvar
      _nomeController.text = '';
      _quantidadeController.text = '';
      textoSalvarAtualizar = 'Salvar';
    } else {
      // Campos Tela Atualizar
      _nomeController.text = compra.nome;
      _quantidadeController.text = (compra.quantidade).toString();
      textoSalvarAtualizar = 'Atualizar';
    }
    exibeModal(textoSalvarAtualizar, compra);
  }

  _salvarAtualizarCompra({Compra? compraSelecionada}) async {
    String nome = _nomeController.text;
    String quantidade = _quantidadeController.text;

    if(compraSelecionada == null) {
      // Salva no banco
      Compra compra = Compra(nome: nome, quantidade: int.parse(quantidade));
      await _db.salvarCompra(compra);
    } else {
      // Atualiza no banco
      Compra compra = Compra(id:compraSelecionada.id, nome: nome, quantidade: int.parse(quantidade));
      await _db.atualizarCompra(compra);
    }

    _nomeController.clear();
    _quantidadeController.clear();

    _recuperarCompras();
  }

  _removerCompra(int id) async {
    await _db.removerCompra(id);

    _recuperarCompras();
  }

  _recuperarCompras() async {
    List comprasRecuperadas = await _db.recuperarCompras();

    List<Compra> listaTemporaria = <Compra>[];
    for (var item in comprasRecuperadas) {
      Compra compra = Compra.fromMap(item);
      listaTemporaria.add(compra);
    }

    setState(() {
      _compras = listaTemporaria;
    });
    listaTemporaria = [];
  }
}