class Pokemon {
  final String name;
  final String url;
  final String imageUrl;
  final int id;

  Pokemon({
    required this.name,
    required this.url,
    required this.imageUrl,
    required this.id,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final String name = json['name'];
    final String url = json['url'];
    final String id = url.split('/')[6];
    final String imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

    return Pokemon(
      name: name,
      url: url,
      imageUrl: imageUrl,
      id: int.parse(id),
    );
  }
}

class PokemonDetalhes {
  final String name;
  final int id;
  final int height;
  final int weight;
  final List<String> abilities;
  final String imageUrl;

  PokemonDetalhes({
    required this.name,
    required this.id,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.imageUrl,
  });

  factory PokemonDetalhes.fromJson(Map<String, dynamic> json) {
    final String name = json['name'];
    final int id = json['id'];
    final int height = json['height'];
    final int weight = json['weight'];
    final String imageUrl = json['sprites']['front_default'];
    final List<String> abilities = (json['abilities'] as List)
        .map((item) => item['ability']['name'] as String)
        .toList();

    return PokemonDetalhes(
      name: name,
      id: id,
      height: height,
      weight: weight,
      abilities: abilities,
      imageUrl: imageUrl,
    );
  }
}
