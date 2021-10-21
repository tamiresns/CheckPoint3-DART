import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _titulo(),
      body: _corpo(),
    );
  }

  _titulo() {
    return AppBar(
      title: const Text('Vagas'),
      centerTitle: true,
      backgroundColor: Colors.purple.shade700,
    );
  }

  _corpo() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _item(_textoTitulo('Desenvolvedor Backend'),'4.000,00','Vaga de Desenvolvedor Backend','(11) 99999-0000'),
            _item(_textoTitulo('Engenheiro de dados'),'5.000,00', 'Vaga de Engenheiro de Dados','(11) 11111-1111'),
            _item(_textoTitulo('Desenvolvedor Front End'),'3.000,00','Vaga de Desenvolvedor Front End','(11) 22222-2222'),
            _item(_textoTitulo('Desenvolvedor Mobile'),'10.000,00','Vaga de Desenvolvedor Mobile','(11) 22222-99999'),
            _item(_textoTitulo('Desenvolvedor Backend'),'9.000,00','Vaga de Desenvolvedor Back','(11) 55555-1111'),
            _item(_textoTitulo('Engenheiro de dados'),'12.000,00', 'Vaga de Engenheiro de Dados','(11) 44444-1111'),
          ],
        ),
      ),
    );
  }

  _textoTitulo(String titulo) {
    return Text(
      titulo,
      style: const TextStyle(
        color: Colors.purple,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _item(titulo, salario, descricao, contato) {
    return Container(
      margin: const EdgeInsets.only(top: 10,),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400)
      ),
      child: Column(
        children: [
          titulo,
          Container(
            margin: const EdgeInsets.only(top:5),
            alignment: Alignment.centerLeft,
            child: Text('Salário: $salario'),
          ),
          Container(
            margin: const EdgeInsets.only(top:2),
            alignment: Alignment.centerLeft,
            child: Text('Descrição: $descricao'),
          ),
          Container(
            margin: const EdgeInsets.only(top:2, bottom:2),
            alignment: Alignment.centerLeft,
            child: Text('Contato: $contato'),
          ),
        ],
      ),
    );
  }
}