import 'package:flutter/material.dart';
import 'package:atividade06/telas/tela-2t.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 29, 35, 1.0),
      appBar: AppBar(
        title: Text("Tela 1"),
        backgroundColor: Color.fromRGBO(44, 45, 53, 1.0),
        foregroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Tela2t()));
            },
            icon: Icon(Icons.navigate_next, color: Colors.white)),
      ),
    );
  }
}
