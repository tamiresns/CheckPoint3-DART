import 'package:flutter/material.dart';

class Experiencia extends StatelessWidget {
  const Experiencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return const Center(
        child: Text(
            'Técnico de Enfermagem: Receber escolas e organizar fichas individuais junto com cuidados/horários das medicações. Administrar medicações. Atender qualquer incidente médico com crianças/responsáveis e em qualquer ocasião. \n Tecnologia: Desenvolvimento e manutenção de sistemas e hotsites utilizando: HTML, CSS, Javascript, Bootstrap, PHP 7, Drupal 8 e MySQL. Utilizando versionamento com GIT e desenvolvendo em ambientes Windows e Linux (Ubuntu)'));
  }
}
