import 'dart:io';
import 'dart:async';
import 'package:sqlite3/sqlite3.dart';

Future<void> main() async {
  print("Aluno: José Maia Cavalcante Neto");

  final db = sqlite3.open('banco_de_dados.db');

  db.execute(''' 
    CREATE TABLE IF NOT EXISTS alunos (
      id INTEGER NOT NULL PRIMARY KEY,
      nome TEXT NOT NULL,
      idade INTEGER NOT NULL
    );
  ''');

  db.execute('DELETE FROM alunos');

  await inserirAluno(db, 'José', 17);
  await inserirAluno(db, 'Josemar', 60);

  await consultarAlunos(db);

  await atualizarAluno(db, 1, 'José Maia', 18);

  await excluirAluno(db, 2);

  await consultarAlunos(db);

  db.dispose();
}

Future<void> inserirAluno(Database db, String nome, int idade) async {
  final result = db.select('SELECT * FROM alunos WHERE nome = ? AND idade = ?', [nome, idade]);
  if (result.isEmpty) {
    final stmt = db.prepare('INSERT INTO alunos (nome, idade) VALUES (?, ?)');
    await Future.delayed(Duration(milliseconds: 50));
    stmt.execute([nome, idade]);
    stmt.dispose();
  } else {
    print('Aluno $nome já existe no banco de dados!');
  }
}

Future<void> consultarAlunos(Database db) async {
  final resultSet = db.select('SELECT * FROM alunos');
  print('Consultando alunos:');
  for (final row in resultSet) {
    print('Aluno[id: ${row['id']}, nome: ${row['nome']}, idade: ${row['idade']}]');
  }
}

Future<void> atualizarAluno(Database db, int id, String nome, int idade) async {
  final stmt = db.prepare('UPDATE alunos SET nome = ?, idade = ? WHERE id = ?');
  await Future.delayed(Duration(milliseconds: 50));
  stmt.execute([nome, idade, id]);
  stmt.dispose();
}

Future<void> excluirAluno(Database db, int id) async {
  final stmt = db.prepare('DELETE FROM alunos WHERE id = ?');
  await Future.delayed(Duration(milliseconds: 50));
  stmt.execute([id]);
  stmt.dispose();
}