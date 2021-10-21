import 'package:lista_compras_sqlite/model/compra.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnotacaoHelper{
  static const String nomeTabela = 'compra';

  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper._internal();
  Database? _db;

  factory AnotacaoHelper() => _anotacaoHelper;

  AnotacaoHelper._internal();

  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await inicializarDB();
      return _db;
    }
  }

  _onCreate(Database db, int version) async {
    String sql = 'CREATE TABLE $nomeTabela ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'nome VARCHAR, '
      'quantidade  INTEGER)';
    await db.execute(sql);
  }

  inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, 'banco_compra');

    var db = await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<int> salvarCompra(Compra compra) async {
    var bancoDados = await db;
    int resultado = await bancoDados.insert(nomeTabela, compra.toMap());
    return resultado;
  }

  recuperarCompras() async {
    var bancoDados = await db;
    String sql = 'SELECT * FROM $nomeTabela ORDER BY id DESC';
    List compras = await bancoDados.rawQuery(sql);
    return compras;
  }

  Future<int> atualizarCompra(Compra compra) async {
    var bancoDados = await db;
    return await bancoDados.update(nomeTabela, compra.toMap(), where: 'id = ?', whereArgs: [compra.id]);
  }

  Future<int> removerCompra(int id) async {
    var bancoDados = await db;
    return await bancoDados.delete(nomeTabela, where: 'id = ?', whereArgs: [id]);
  }

}