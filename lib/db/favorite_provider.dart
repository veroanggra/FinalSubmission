import 'package:bismillah_final_submission/models/meals.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteProvider {
  static final FavoriteProvider db = FavoriteProvider._();
  static Database _database;

  FavoriteProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "meals_favorite.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      String createTable = "CREATE TABLE favorite ("
          "id INTEGER PRIMARY KEY,"
          "idMeal TEXT,"
          "strMeal TEXT,"
          "strCategory TEXT,"
          "strArea TEXT,"
          "strInstructions TEXT,"
          "strMealThumb TEXT,"
          "strIngredient1 TEXT,"
          "strIngredient2 TEXT,"
          "strIngredient3 TEXT,"
          "strIngredient4 TEXT,"
          "strIngredient5 TEXT,"
          "type TEXT"
          ")";
      await db.execute(createTable);
    });
  }

  getFavoriteMealsById(String idMeal) async {
    final db = await database;
    var res =
        await db.query("favorite", where: "idMeal = ?", whereArgs: [idMeal]);
    return res.isEmpty ? null : Meals.fromJson(res.first);
  }

  Future<List<Meals>> getFavoriteMealsByType(String type) async {
    final db = await database;
    var res = await db.query("favorite", where: "type = ?", whereArgs: [type]);
    List<Meals> meals =
        res.isEmpty ? [] : res.map((item) => Meals.fromJson(item)).toList();
    return meals;
  }

  deleteFavoriteMealsById(String id) async {
    final db = await database;
    var res = await db.delete("favorite", where: "idMeal = ?", whereArgs: [id]);
    return res;
  }

  addFavoriteMeals(Meals meals) async {
    final db = await database;
    var res = await db.insert("favorite", meals.toJson());
    return res;
  }
}
