import 'package:flutter/material.dart';

class Tela2t extends StatefulWidget {
  const Tela2t({super.key});

  @override
  State<Tela2t> createState() => _Tela2tState();
}

class _Tela2tState extends State<Tela2t> {
  int _counter = 0;
  bool _isPressed = false; // Inicialização correta da variável.

  void _incrementCounter() {
    setState(() {
      _isPressed = true; // Define como verdadeiro para ativar a animação.
      _counter++; // Incrementa o contador.
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _isPressed = false; // Retorna ao estado original.
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 29, 35, 1.0),
      appBar: AppBar(
        title: const Text("Contador"),
        backgroundColor: const Color.fromRGBO(44, 45, 53, 1.0),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Contador: $_counter',
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 20),
            AnimatedScale(
              scale: _isPressed ? 1.2 : 1.0, // Controla o tamanho do botão.
              duration: const Duration(milliseconds: 200),
              child: ElevatedButton(
                onPressed: _incrementCounter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Cor de fundo roxa.
                ),
                child: const Text(
                  'Aumentar Contador',
                  style: TextStyle(color: Colors.white), // Texto branco.
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
