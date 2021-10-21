import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool valorSwitchDia = false;
  bool valorSwitchPequeno = false;
  double size = 0.0;
  double tamanhoFonte = 40;
  Color corFundo = Colors.grey.shade700;
  final String chaveDia = 'DiaNoite';
  final String chaveFonte = 'FonteMaiorMenor';

  @override
  void initState() {
    super.initState();
    _funcaoInicializaShared();
  }

  Future<void> _funcaoInicializaShared() async {
    final _prefs = await SharedPreferences.getInstance();

    setState(() {
      valorSwitchDia = (_prefs.getBool(chaveDia) ?? valorSwitchDia);
      valorSwitchPequeno = (_prefs.getBool(chaveFonte) ?? valorSwitchPequeno);

      valorSwitchDia == true
          ? corFundo = Colors.white
          : corFundo = Colors.grey.shade700;
      valorSwitchPequeno == true ? tamanhoFonte = 20 : tamanhoFonte = 40;
    });
  }

  _atualizaShared(valor, chave) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(chave, valor);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frases'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                _label('Dia:'),
                _switchDia(),
                _label('Pequeno:'),
                _switchPequeno(),
              ]),
              Container(
                width: size,
                height: 400,
                child: Text(
                    'O choro pode durar uma noite, mas a alegria vem pela manhã. Salmos 30:5',
                    style: TextStyle(fontSize: tamanhoFonte)),
                decoration: BoxDecoration(
                  color: corFundo,
                ),
              ),
            ],
          )),
    );
  }

  _label(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Colors.green.shade900,
      ),
    );
  }

  _switchDia() {
    return Container(
      margin: const EdgeInsets.only(right: 30),
      child: Switch(
          value: valorSwitchDia,
          onChanged: (value) async {
            setState(() {
              valorSwitchDia = value;
              valorSwitchDia == true
                  ? corFundo = Colors.white
                  : corFundo = Colors.grey.shade700;
              _atualizaShared(valorSwitchDia, chaveDia);
            });
          }),
    );
  }

  _switchPequeno() {
    return Switch(
        value: valorSwitchPequeno,
        onChanged: (value) {
          setState(() {
            valorSwitchPequeno = value;
            valorSwitchPequeno == true ? tamanhoFonte = 20 : tamanhoFonte = 40;
            _atualizaShared(valorSwitchPequeno, chaveFonte);
          });
        });
  }
}
