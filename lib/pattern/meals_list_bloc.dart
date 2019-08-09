import 'package:rxdart/rxdart.dart';
import 'package:bismillah_final_submission/models/meals.dart';
import 'package:bismillah_final_submission/repository/repository.dart';

class MealsBloc {

  final _repository = Repository();
  final _mealsFetcher = PublishSubject<MealsResponse>();

  Observable<MealsResponse> get allMeals => _mealsFetcher.stream;

  fetchAllMeals(String mealsType) async {
    MealsResponse mealsResult = await _repository.fetchAllMeals(mealsType);
    _mealsFetcher.sink.add(mealsResult);
  }

  dispose() {
    _mealsFetcher.close();
  }
}