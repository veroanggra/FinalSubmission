import 'package:bismillah_final_submission/api/api_client.dart';
import 'dart:async';
import 'package:bismillah_final_submission/models/meals.dart';

class Repository {
  final mealsApiProvider = MealsApiClient();

  Future<MealsResponse> fetchAllMeals(String mealsType) =>
      mealsApiProvider.getMealsList(mealsType);

  Future<MealsResponse> fetchDetailMeals(String mealsId) =>
      mealsApiProvider.getDetailMeals(mealsId);

  Future<MealsResponse> searchMeals(String mealsName) =>
      mealsApiProvider.searchMeals(mealsName);
}
