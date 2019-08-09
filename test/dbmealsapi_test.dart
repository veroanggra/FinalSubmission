import 'package:bismillah_final_submission/api/api_client.dart';
import 'package:bismillah_final_submission/models/meals.dart';
import 'package:test_api/test_api.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;

class ApiTest extends Mock implements http.Client {}

main() {
  MealsApiClient mealsApiProvider = MealsApiClient();
  final client = ApiTest();

  group("Request Seafood test", () {
    test("should request complete", () async {
      when(client.get(
              "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood"))
          .thenAnswer(
        (_) async => http.Response(Meals().toString(), 200),
      );

      expect(
          await mealsApiProvider.getMealsList("Seafood"), isA<MealsResponse>());
    });

    test("request failed", () async {
      when(client.get(
              "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood"))
          .thenAnswer(
        (_) async => http.Response(Meals().toString(), 404),
      );

      expect(
          await mealsApiProvider.getMealsList("Seafood"), isA<MealsResponse>());
    });
  });

  group("Request Dessert test", () {
    test("request complete", () async {
      when(client.get(
              "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"))
          .thenAnswer(
        (_) async => http.Response(Meals().toString(), 200),
      );

      expect(
          await mealsApiProvider.getMealsList("Dessert"), isA<MealsResponse>());
    });

    test("should request failed", () async {
      when(client.get(
              "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"))
          .thenAnswer(
        (_) async => http.Response(Meals().toString(), 404),
      );

      expect(
          await mealsApiProvider.getMealsList("Seafood"), isA<MealsResponse>());
    });
  });

  group("Request detail test", () {
    test("request complete", () async {
      when(client.get(
              "https://www.themealdb.com/api/json/v1/1/lookup.php?i=52819"))
          .thenAnswer(
        (_) async => http.Response(Meals().toString(), 200),
      );

      expect(
          await mealsApiProvider.getDetailMeals("52819"), isA<MealsResponse>());
    });

    test("request failed", () async {
      when(client.get(
              "https://www.themealdb.com/api/json/v1/1/lookup.php?i=52819"))
          .thenAnswer(
        (_) async => http.Response(Meals().toString(), 404),
      );

      expect(
          await mealsApiProvider.getDetailMeals("52819"), isA<MealsResponse>());
    });
  });

  group("Request Search Test", () {
    test("request complete", () async {
      when(client
              .get("https://www.themealdb.com/api/json/v1/1/search.php?s=Tart"))
          .thenAnswer(
        (_) async => http.Response(Meals().toString(), 200),
      );

      expect(await mealsApiProvider.searchMeals("Tart"), isA<MealsResponse>());
    });

    test("should request failed", () async {
      when(client
              .get("https://www.themealdb.com/api/json/v1/1/search.php?s=Enak"))
          .thenAnswer(
        (_) async => http.Response(Meals().toString(), 404),
      );

      expect(await mealsApiProvider.searchMeals("Pecel"), isA<MealsResponse>());
    });
  });
}
