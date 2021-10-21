import 'package:flutter/material.dart';

class Formacao extends StatelessWidget {
  const Formacao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return const Center(child: Text('Tela Formacao'));
  }
}