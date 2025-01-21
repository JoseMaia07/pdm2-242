import 'package:flutter/material.dart';

class Tela2t extends StatelessWidget {
  const Tela2t({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 29, 35, 1.0),
      appBar: AppBar(
        title: Text("Tela 2"),
        backgroundColor: Color.fromRGBO(44, 45, 53, 1.0),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.navigate_before, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
