import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lista_tarefas_sqlite/helper/anotacao_helper.dart';
import 'package:lista_tarefas_sqlite/model/anotacao.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final _db = AnotacaoHelper();
  List<Anotacao> _anotacoes = <Anotacao>[];

  _exibirTelaCadastro({Anotacao? anotacao}) {
    String textoSalvarAtualizar = "";
    if (anotacao == null) {
      //salvando
      _tituloController.text = "";
      _descricaoController.text = "";
      textoSalvarAtualizar = "Salvar";
    } else {
      //atualizar
      _tituloController.text = anotacao.titulo;
      _descricaoController.text = anotacao.descricao;
      textoSalvarAtualizar = "Atualizar";
    }

    showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text("$textoSalvarAtualizar anotação"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _tituloController,
                    autofocus: true,
                    decoration: const InputDecoration(
                        labelText: "Título", hintText: "Digite título..."),
                  ),
                  TextField(
                    controller: _descricaoController,
                    decoration: const InputDecoration(
                        labelText: "Descrição", hintText: "Digite descrição..."),
                  )
                ],
              ),
              actions: <Widget>[
                TextButton (
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancelar")),
                TextButton (
                    onPressed: () {
                      //salvar
                      _salvarAtualizarAnotacao(anotacaoSelecionada: anotacao);
          
                      Navigator.pop(context);
                    },
                    child: Text(textoSalvarAtualizar))
              ],
            ),
          );
        }
      );
  }

  _recuperarAnotacoes() async {
    List anotacoesRecuperadas = await _db.recuperarAnotacoes();

    List<Anotacao> listaTemporaria = <Anotacao>[];
    for (var item in anotacoesRecuperadas) {
      Anotacao anotacao = Anotacao.fromMap(item);
      listaTemporaria.add(anotacao);
    }

    setState(() {
      _anotacoes = listaTemporaria;
    });
    //listaTemporaria = null;
    listaTemporaria = [];

    //print("Lista anotacoes: " + anotacoesRecuperadas.toString() );
  }

  _salvarAtualizarAnotacao({Anotacao? anotacaoSelecionada}) async {
    String titulo = _tituloController.text;
    String descricao = _descricaoController.text;

    if (anotacaoSelecionada == null) {
      
      //salvar
      Anotacao anotacao =
          Anotacao(titulo: titulo, descricao: descricao, data: DateTime.now().toString());
      //int resultado = await _db.salvarAnotacao(anotacao);
      await _db.salvarAnotacao(anotacao);
    } else {
      // atualiza
      Anotacao atualizaAnotacao = Anotacao(
        id: anotacaoSelecionada.id,
        titulo: _tituloController.text,
        descricao: _descricaoController.text,
        data: DateTime.now().toString()
      );
      await _db.atualizarAnotacao(atualizaAnotacao);
    }

    _tituloController.clear();
    _descricaoController.clear();

    _recuperarAnotacoes();
  }

  _formatarData(String data) {
    initializeDateFormatting('pt_BR');
    //Year -> y month-> M Day -> d
    // Hour -> H minute -> m second -> s
    //var formatador = DateFormat("d/MMMM/y H:m:s");
    var formatador = DateFormat.yMd("pt_BR");

    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatada = formatador.format(dataConvertida);

    return dataFormatada;
  }

  _removerAnotacao(int id) async {
    await _db.removerAnotacao(id);

    _recuperarAnotacoes();
  }

  @override
  void initState() {
    super.initState();
    _recuperarAnotacoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas anotações"),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 500,
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ListView.builder(
                      itemCount: _anotacoes.length,
                      itemBuilder: (context, index) {
                        final anotacao = _anotacoes[index];
                        return Card(
                          child: ListTile(
                            title: Text(anotacao.titulo),
                            subtitle: Text(
                                "${_formatarData(anotacao.data)} - ${anotacao.descricao}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    _exibirTelaCadastro(anotacao: anotacao);
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
                                    _removerAnotacao(anotacao.id!);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(right: 0),
                                    child: Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                )
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
          onPressed: () {
            _exibirTelaCadastro();
          }),
    );
  }
}
