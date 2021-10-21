import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _titulo(),
        backgroundColor: Colors.white,
        body: _corpo(),
      ),
    );
  }

  _titulo() {
    return AppBar(
      title: const Text("Anúncios"),
      centerTitle: true,
      backgroundColor: Colors.red.shade900,
    );
  }

    _corpo() {
    return Container(
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.only(top: 15),
      height:300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _item('Fogão', 'produto1.jpg'),
          _item('Geladeira', 'produto2.jpg'),
          _item('Microondas', 'produto3.jpg'),
          _item('Máquina de Lavar', 'produto4.jpg'),
          _item('TV', 'produto5.jpg'),
        ],
      ),
    );
  }

  _item(String texto, imagem) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: 200,
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          _foto(imagem),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              texto,
              style: const TextStyle(
                fontSize: 18, 
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }


  _foto(String nomeFoto) {
    return Image.asset(
      "assets/images/$nomeFoto",
      height: 200,
      width: 300,
      //fit: BoxFit.fill,
      //fit: BoxFit.contain,
      //fit: BoxFit.cover,
      fit: BoxFit.fitWidth,
    );
  }
}
