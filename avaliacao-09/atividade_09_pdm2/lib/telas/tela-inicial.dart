import 'package:flutter/material.dart';
import 'package:atividade_09_pdm2/pokemon.dart';
import 'package:atividade_09_pdm2/api.dart';
import 'package:atividade_09_pdm2/telas/telas_detalhes.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  late Future<List<Pokemon>> futurePokemonList;

  @override
  void initState() {
    super.initState();
    futurePokemonList = fetchPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 29, 35, 1.0),
      appBar: AppBar(
        title: const Text("Pokédex"),
        backgroundColor: const Color.fromRGBO(44, 45, 53, 1.0),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder<List<Pokemon>>(
          future: futurePokemonList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text(
                'Erro: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text(
                'Nenhum Pokémon encontrado',
                style: TextStyle(color: Colors.white),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Pokemon pokemon = snapshot.data![index];
                  return Card(
                    color: const Color.fromRGBO(44, 45, 53, 1.0),
                    child: ListTile(
                      leading: Image.network(pokemon.imageUrl,
                          width: 50, height: 50),
                      title: Text(
                        pokemon.name[0].toUpperCase() +
                            pokemon.name.substring(1),
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaDetalhes(id: pokemon.id),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
