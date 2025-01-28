import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 29, 35, 1.0),
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: const Color.fromRGBO(44, 45, 53, 1.0),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Seja bem-vindo ao nosso aplicativo de teste, clique em contador para testar essa função.',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
