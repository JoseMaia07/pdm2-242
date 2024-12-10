import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Aluno {
  final int? id;
  final String nome;
  final String dataNascimento;

  Aluno({this.id, required this.nome, required this.dataNascimento});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'data_nascimento': dataNascimento,
    };
  }

  @override
  String toString() {
    return 'Aluno(id: $id, nome: $nome, dataNascimento: $dataNascimento)';
  }
}

class AlunoDatabase {
  static final AlunoDatabase instance = AlunoDatabase._init();

  static Database? _database;

  AlunoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('aluno.db');
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE TB_ALUNOS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        data_nascimento TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertAluno(Aluno aluno) async {
    final db = await database;
    return await db.insert('TB_ALUNOS', aluno.toMap());
  }

  Future<Aluno?> getAluno(int id) async {
    final db = await database;
    final maps = await db.query(
      'TB_ALUNOS',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    return Aluno(
      id: maps.first['id'] as int,
      nome: maps.first['nome'] as String,
      dataNascimento: maps.first['data_nascimento'] as String,
    );
  }

  Future<List<Aluno>> getAllAlunos() async {
    final db = await database;
    final maps = await db.query('TB_ALUNOS');

    return List.generate(maps.length, (i) {
      return Aluno(
        id: maps[i]['id'] as int,
        nome: maps[i]['nome'] as String,
        dataNascimento: maps[i]['data_nascimento'] as String,
      );
    });
  }

  Future<int> updateAluno(Aluno aluno) async {
    final db = await database;
    return await db.update(
      'TB_ALUNOS',
      aluno.toMap(),
      where: 'id = ?',
      whereArgs: [aluno.id],
    );
  }

  Future<int> deleteAluno(int id) async {
    final db = await database;
    return await db.delete(
      'TB_ALUNOS',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

Future<void> main() async {
  // Inicializar o banco de dados
  final db = AlunoDatabase.instance;

  // Inserir alunos
  final aluno1 = Aluno(nome: 'João', dataNascimento: '2000-01-01');
  final aluno2 = Aluno(nome: 'José Maia', dataNascimento: '2007-05-12');
  final aluno3 = Aluno(
      nome: 'Leandro',
      dataNascimento: '1879-03-14'); // Data de nascimento de Einstein

  int aluno1Id = await db.insertAluno(aluno1);
  int aluno2Id = await db.insertAluno(aluno2);
  int aluno3Id = await db.insertAluno(aluno3);

  // Buscar e exibir os alunos pelo ID
  Aluno? retrievedAluno1 = await db.getAluno(aluno1Id);
  Aluno? retrievedAluno2 = await db.getAluno(aluno2Id);
  Aluno? retrievedAluno3 = await db.getAluno(aluno3Id);

  // Atualizar os dados de um aluno
  if (retrievedAluno1 != null) {
    final updatedAluno = Aluno(
      id: retrievedAluno1.id,
      nome: 'João da Silva',
      dataNascimento: retrievedAluno1.dataNascimento,
    );
    await db.updateAluno(updatedAluno);
  }

  print('Aluno 1 recuperado: $retrievedAluno1');
  print('Aluno 2 recuperado: $retrievedAluno2');
  print('Aluno 3 recuperado: $retrievedAluno3');

  // Buscar todos os alunos e exibir
  List<Aluno> alunos = await db.getAllAlunos();
  print('Todos os alunos: $alunos');

  // Deletar um aluno
  await db.deleteAluno(aluno1Id);
}
