import 'package:flutter/material.dart';

class Dados extends StatelessWidget {
  final String text;

  const Dados({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Realizado!'),
      ),
      body: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          )
        ),
    );
  }

}