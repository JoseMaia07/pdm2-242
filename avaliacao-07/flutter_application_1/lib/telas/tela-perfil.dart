import 'package:flutter/material.dart';

class TelaPerfil extends StatelessWidget {
  const TelaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 29, 35, 1.0),
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: const Color.fromRGBO(44, 45, 53, 1.0),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Perfil',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
