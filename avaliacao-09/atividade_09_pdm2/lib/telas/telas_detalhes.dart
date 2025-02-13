import 'package:flutter/material.dart';
import 'package:atividade_09_pdm2/pokemon.dart';
import 'package:atividade_09_pdm2/api.dart';

class TelaDetalhes extends StatelessWidget {
  final int id;

  const TelaDetalhes({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 29, 35, 1.0),
      appBar: AppBar(
        title: const Text("Detalhes do Pokémon"),
        backgroundColor: const Color.fromRGBO(44, 45, 53, 1.0),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<PokemonDetalhes>(
        future: fetchPokemonDetalhes(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro: ${snapshot.error}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          } else {
            var pokemon = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    pokemon.imageUrl,
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    pokemon.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Altura: ${pokemon.height}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Peso: ${pokemon.weight}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Habilidades:',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  ...pokemon.abilities.map((ability) => Text(
                        ability,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 22,
                        ),
                      )),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
