import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:bismillah_final_submission/models/meals.dart';

class MealsApiClient {
  Client client = Client();

  static final String _baseUrl = 'https://www.themealdb.com/api/json/v1/1/';

  Future<MealsResponse> getMealsList(String mealsType) async {
    final response = await client.get(_baseUrl + "filter.php?c=$mealsType");
    if (response.statusCode == 200) {
      return MealsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<MealsResponse> getDetailMeals(String mealsId) async {
    final response = await client.get(_baseUrl + 'lookup.php?i=$mealsId');
    if (response.statusCode == 200) {
      return MealsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<MealsResponse> searchMeals(String mealsName) async {
    final response = await client.get(_baseUrl + 'search.php?s=$mealsName');
    if (response.statusCode == 200) {
      return MealsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
