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
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  final valor = TextEditingController();
  List<String> moedas = ['Dólar','Real','Euro'];
  String? _dropdownM1;
  String? _dropdownM2;
  double size = 0.0;
  String resultados = '';

  _resultados() {
    double value = double.parse(valor.text);
    double resConversao = 0.0;
    if(_dropdownM1 == 'Dólar') {
      if (_dropdownM2 == 'Dólar') {
        resConversao = value;
      } else if (_dropdownM2 == 'Real') {
        resConversao = value * 5.34;
      } else if (_dropdownM2 == 'Euro') {
        resConversao = value * 0.85;
      }
    } else if (_dropdownM1 == 'Real') {
      if (_dropdownM2 == 'Dólar') {
        resConversao = value * 0.19;
      } else if (_dropdownM2 == 'Real') {
        resConversao = value;
      } else if (_dropdownM2 == 'Euro') {
        resConversao = value * 0.16;
      }
    } else if (_dropdownM1 == 'Euro') {
      if (_dropdownM2 == 'Dólar') {
        resConversao = value * 1.17;
      } else if (_dropdownM2 == 'Real') {
        resConversao = value * 6.25;
      } else if (_dropdownM2 == 'Euro') {
        resConversao = value;
      }
    }
    resultados = 'Valor convertido para $_dropdownM2: ${resConversao.toStringAsFixed(2)}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _titulo(),
      body: _corpo(),
    );
  }

  _titulo() {
    return AppBar(
      title: const Text('Conversor de Moedas \n    Dólar, Real e Euro'),
      centerTitle: true,
      backgroundColor: Colors.red.shade700,
    );
  }

  _label(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Colors.red.shade900,
      ),
    );
  }

  _dropdownMoeda1(lista) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: DropdownButton(
        value: _dropdownM1,
        hint: const Text('Selecione...'),
        icon: const Icon(Icons.arrow_downward),
        iconSize: 20,
        onChanged: (String? newValue) {
          setState(() {
            _dropdownM1 = newValue!;
          });
        },
        items: lista.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  _dropdownMoeda2(lista) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: DropdownButton(
        value: _dropdownM2,
        hint: const Text('Selecione...'),
        icon: const Icon(Icons.arrow_downward),
        iconSize: 20,
        onChanged: (String? newValue) {
          setState(() {
            _dropdownM2 = newValue!;
          });
        },
        items: lista.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  _botaoEnviar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      height: 40,
      width: size,
      child: ElevatedButton(
        onPressed: _resultados,
        style: ElevatedButton.styleFrom(
          primary: Colors.red.shade700,
        ),
        child: const Text(
          'Confirmar', 
          style: TextStyle(
            color: Colors.white, 
            fontSize: 20
          ),
        ),
      ),
    );
  }

  _corpo() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10,),
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration (
              labelText: 'Valor: ',
              labelStyle: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.w400,
                color: Colors.red.shade900,
              ),
            ),
            controller: valor,
          ),
          Row(
            children: [
              _label('De:'),
              _dropdownMoeda1(moedas),
            ],
          ),
          Row(
            children: [
              _label('Para:'),
              _dropdownMoeda2(moedas),
            ],
          ),
          _botaoEnviar(),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: size,
            child: Text(
              resultados,
              textAlign: TextAlign.left,  
            ),
          ),
        ],
      ),
    );
  }
}