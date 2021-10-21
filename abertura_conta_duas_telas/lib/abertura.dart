import 'package:abertura_conta_duas_telas/dados.dart';
import 'package:flutter/material.dart';

class Abertura extends StatefulWidget {
  const Abertura({Key? key}) : super(key: key);

  @override
  _AberturaState createState() => _AberturaState();  
}

class _AberturaState extends State<Abertura> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _titulo(),
      body: _corpo(context),
    );
  }

  _titulo() {
    return AppBar(
      title: const Text('Cadastro de Conta Bancária'),
      centerTitle: true,
      backgroundColor: Colors.red.shade800,
    );
  }

  _corpo(BuildContext context) {
    size = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.white,
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
                  color: Colors.red.shade700,
                ),
              ),
              controller: nome,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration (
                labelText: 'Idade: ',
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.red.shade700,
                ),
              ),
              controller: idade,
            ),
            Row (
              children: [
                _label('Sexo: '),
                _dropdownSexo(sexo),
              ],
            ),
            Row (
              children: [
                _label('Escolaridade: '),
                _dropdownEscolaridade(escolaridade),
              ],
            ),
            Row (
              children: [
                _label('Limite: '),
                _slider(),
              ],
            ),
            Row(
              children: [
                _label('Brasileiro: '),
                _switch(),
              ],
            ),
            _botaoEnviar(context),
          ],
        ),
      ),
    );
  }

  _label(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Colors.red.shade700,
      ),
    );
  }

  _dropdownSexo(listaSexo) {
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
        items: listaSexo.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String> (
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  _dropdownEscolaridade(listaEscolaridade) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: DropdownButton(
        value: _dropdownValueEscolar,
        hint: const Text('Selecione...'),
        icon: const Icon(Icons.arrow_downward),
        iconSize: 20,
        onChanged: (String? newValue) {
          _dropdownValueEscolar = newValue;
        },
        items: listaEscolaridade.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value:  value,
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
      inactiveColor: Colors.red.shade200,
      activeColor: Colors.red.shade800,
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
      activeTrackColor: Colors.red.shade800,
      activeColor: Colors.red.shade800,
      inactiveTrackColor: Colors.red.shade200,
    );
  }

  _botaoEnviar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 40,
      width: size,
      child: ElevatedButton(
        onPressed: () {
          _resultados(context);
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.red.shade800,
        ),
        child: const Text(
          'Confirmar',
          style: TextStyle (
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  void _resultados(BuildContext context) {
    String nome1 = nome.text;
    String idade1 = idade.text;
    resultados = 'Nome: $nome1\nIdade: $idade1 \nSexo: $_dropdownValueSexo \nEscolaridade: $_dropdownValueEscolar \nLimite: $valorSlider \nBrasileiro: $brasileiro';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Dados(text: resultados,),
      ),
    );
  }
}

