import 'package:flutter/material.dart';

void main() {
  runApp (const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home()
    );
  }

}

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home>{
  List<String> sexo = ['Masculino', 'Feminino', 'Prefiro não informar'];
  List<String> escolaridade = ['Médio Incompleto', 'Médio Completo', 'Superior Incompleto', 'Superior Completo'];
  String? _dropdownValueSexo;
  String? _dropdownValueEscolar;
  double valorSlider = 0;
  bool valorSwitch = false;
  double size = 0.0;
  String resultados = '';
  String brasileiro = '';
  final nome = TextEditingController();
  final idade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _titulo(),
        body: _corpo(),
      );
  }
  _resultados () {
    String nome1 = nome.text;
    String idade1 = idade.text;
    setState(() {});
    resultados = 'Nome: $nome1\nIdade: $idade1 \nSexo: $_dropdownValueSexo \nEscolaridade: $_dropdownValueEscolar \nLimite: $valorSlider \nBrasileiro: $brasileiro';
  }

  _titulo() {
    return AppBar(
      title: const Text('Abrir Conta Bancária'),
      centerTitle: true,
      backgroundColor: Colors.amber.shade900,
    );
  }

  _corpo() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration (
                  labelText: 'Nome: ',
                  labelStyle: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.w400,
                    color: Colors.amber.shade900,
                  ),
                ),
                controller: nome,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration (
                  labelText: 'Idade:',
                  labelStyle: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.w400,
                    color: Colors.amber.shade900,
                  ),
                ),
                controller: idade,
              ),
              Row (
                children: <Widget>[
                  _label('Sexo: '),
                  _dropdownSexo(sexo),
                ],
              ),
              Row (
                children: <Widget>[
                  _label('Escolaridade: '),
                  _dropdownEscolaridade(escolaridade),
                ],
              ),
              Row (
                children: <Widget>[
                  _label('Limite: '),
                  _slider(),
                ],
              ),
              Row (
                children: <Widget>[
                  _label('Brasileiro: '),
                  _switch(),
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
        ),
      ),
    );
  }

  _label(String campoLabel) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Text(
        campoLabel, 
        style: TextStyle(
          fontSize: 18, 
          fontWeight: FontWeight.w400,
          color: Colors.amber.shade900,
        ),
      ),
    );
  }

  _dropdownSexo(lista) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: DropdownButton(
        value: _dropdownValueSexo,
        hint: const Text('Selecione...'),
        icon: const Icon(Icons.arrow_downward),
        iconSize: 20,
        onChanged: (String? newValue) {
          setState(() {
            _dropdownValueSexo = newValue!;

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

  _dropdownEscolaridade(lista) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: DropdownButton(
        value: _dropdownValueEscolar,
        hint: const Text('Selecione...'),
        icon: const Icon(Icons.arrow_downward),
        iconSize: 20,
        onChanged: (String? newValue) {
          setState(() {
            _dropdownValueEscolar = newValue!;
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

  _slider() {
    return Slider(
      value: valorSlider,
      min: 0,
      max: 10000,
      divisions: 100,
      label: valorSlider.round().toString(),
      inactiveColor: Colors.amber.shade600,
      activeColor: Colors.amber.shade900,
      onChanged: (double value) {
        setState(() {
          valorSlider = value;
        });
      },
    );
  }

  _switch() {
    return Switch(
      value: valorSwitch,
      onChanged: (value) {
        setState(() {
          valorSwitch = value;
          brasileiro = valorSwitch ? brasileiro = 'Sim' : brasileiro = 'Não';
        });
      },
      activeTrackColor: Colors.amber.shade900,
      activeColor: Colors.amber.shade900,
      inactiveTrackColor: Colors.amber.shade600,
    );
  }

  _botaoEnviar() {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 40,
        width: size,
        child: ElevatedButton(
          onPressed: _resultados,
          style: ElevatedButton.styleFrom(
            primary: Colors.amber.shade900,
          ),
          child: const Text(
            'Confirmar', 
            style: TextStyle(
              color: Colors.white, 
              fontSize: 20
            )
          ),
        ),
      );
  }
}





