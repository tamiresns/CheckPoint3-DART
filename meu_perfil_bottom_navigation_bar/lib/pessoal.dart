import 'package:flutter/material.dart';
import 'package:meu_perfil_bottom_navigation_bar/formacao.dart';

import 'experiencia.dart';

class Pessoal extends StatefulWidget {
  const Pessoal({Key? key}) : super(key: key);

  @override
  _PessoalState createState() => _PessoalState();
}

class _PessoalState extends State<Pessoal> {

  int _currentIndex = 0;
  var tabs = [
    const Center(child: Text('Tela Pessoal')), 
    const Formacao(),
    const Experiencia(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  _titulo(),
      backgroundColor: Colors.white,
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Pessoal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: 'Formação',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.work),
              label: 'Experiência',
            ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  _titulo() {
    return AppBar(
      title: const Text("Meu Perfil"),
      centerTitle: true,
      backgroundColor: Colors.green,
    );
  }
}