import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pokemon.dart';

Future<List<Pokemon>> fetchPokemonList() async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=20'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['results'];
    return jsonResponse.map((data) => Pokemon.fromJson(data)).toList();
  } else {
    throw Exception('Falha ao carregar os Pokémon');
  }
}

Future<PokemonDetalhes> fetchPokemonDetalhes(int id) async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

  if (response.statusCode == 200) {
    return PokemonDetalhes.fromJson(json.decode(response.body));
  } else {
    throw Exception('Falha ao carregar detalhes do Pokémon');
  }
}
