import 'dart:async';
import 'dart:io';
import 'package:anime_app/models/sqlite/connection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
// Usado para definir as colunas da tabelas.
  String animeTable = 'Anime';
  String colId = 'id';
  String colNome = 'nome';
  String colFavorite = 'favorite';
  String colImgCard = 'imgCard';
  String colLastView = 'lastView';
  String colLinkEp = 'linkEp';

// Construtor nomeado para criar instância da classe.
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      //executa somente uma vez.
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'contatos.db';

    var animeDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return animeDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $animeTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colNome TEXT, '
        '$colFavorite TEXT, $colImgCard TEXT, $colLastView TEXT, $colLinkEp TEXT ');
  }

// Incluir um objeto anime no banco de dados.
  Future<int> insertAnime(Anime anime) async {
    Database db = await this.database;
    var resultado = await db.insert(animeTable, anime.toMap());
    return resultado;
  }

// Retorna um anime pelo id.
  Future<Anime> getAnime(int id) async {
    Database db = await this.database;
    List<Map> maps = await db.query(animeTable,
        columns: [
          colId,
          colNome,
          colFavorite,
          colImgCard,
          colLastView,
          colLinkEp
        ],
        where: "$colId = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Anime.fromMap(maps.first);
    } else {
      return null;
    }
  }

// Atualizar o objeto Anime e salvar no banco de dados.
  Future<int> updateAnime(Anime anime) async {
    var db = await this.database;

    var resultado = await db.update(animeTable, anime.toMap(),
        where: "$colId = ?", whereArgs: [anime.id]);
    return resultado;
  }

// Deletar um objeto Anime do banco de dados.
  Future<int> deleteAnime(int id) async {
    var db = await this.database;
    int resultado =
        await db.delete(animeTable, where: "$colId = ?", whereArgs: [id]);
    return resultado;
  }

// Obtem o número de objetos anime no banco de dados.
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $animeTable');
    int resultado = Sqflite.firstIntValue(x);
    return resultado;
  }

// Fechar conexão com o banco de dados.
  Future close() async {
    Database db = await this.database;
    db.close();
  }
}
