import 'package:flutter/material.dart';

class Experiencia extends StatelessWidget {
  const Experiencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return const Center(child: Text('Tela Experiencia'));
  }
}