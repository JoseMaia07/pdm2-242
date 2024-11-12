// Agregação e Composição
import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }
  String get nome => _nome;

  Map<String, dynamic> toJson(){
    return {'nome': this._nome};
  }
}



class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }
    Map<String, dynamic> toJson(){
    return {
      'nome': _nome,
      'dependentes': _dependentes.map((d) => d.toJson()).toList(),
    };
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }
  
  Map<String, dynamic> toJson(){
    return {
      'nomeProjeto' : _nomeProjeto,
      'funcionarios' : _funcionarios.map((f) => f.toJson()).toList(),
    };
  }
}

void main() {
  // 1. Criar varios objetos Dependentes
  var dependente1 = new Dependente("José Salvatore");
  var dependente2 = new Dependente("Lucas Falcone");
  var dependente3 = new Dependente("Maria Maroni");
  var dependente4 = new Dependente("Agatha Falcone");
  // 2. Criar varios objetos Funcionario
  // 3. Associar os Dependentes criados aos respectivos
  //    funcionarios
  var funcionario1 = new Funcionario("Carlos Salvatore", [dependente1]);
  var funcionario2 = new Funcionario("Tommy Falcone", [dependente2, dependente4]);
  var funcionario3 = new Funcionario("Vince Maroni", [dependente3]);
  // 4. Criar uma lista de Funcionarios
  var funcionarios = [funcionario1, funcionario2, funcionario3];
  // 5. criar um objeto Equipe Projeto chamando o metodo
  //    contrutor que da nome ao projeto e insere uma
  //    coleção de funcionario
  var equipeProjeto = new EquipeProjeto("Equipe Science", funcionarios);
  // 6. Printar no formato JSON o objeto Equipe Projeto.
  print(jsonEncode(equipeProjeto.toJson()));
  // Para estilizar a saída JSON
  var encoder = JsonEncoder.withIndent('  ');
  var styleJson = encoder.convert(equipeProjeto.toJson());
  // Imprimir o JSON estilizado
  print(styleJson);
  // 1. Criar varios objetos Dependentes
  // 2. Criar varios objetos Funcionario
  // 3. Associar os Dependentes criados aos respectivos
  //    funcionarios
  // 4. Criar uma lista de Funcionarios
  // 5. criar um objeto Equipe Projeto chamando o metodo
  //    contrutor que da nome ao projeto e insere uma
  //    coleção de funcionario
  // 6. Printar no formato JSON o objeto Equipe Projeto.
}