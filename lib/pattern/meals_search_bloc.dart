import 'package:rxdart/rxdart.dart';
import 'package:bismillah_final_submission/models/meals.dart';
import 'package:bismillah_final_submission/repository/repository.dart';

class MealsSearchBloc {

  final _repository = Repository();
  final _mealsFetcher = PublishSubject<MealsResponse>();

  Observable<MealsResponse> get searchMeals => _mealsFetcher.stream;

  searchAllMeals(String mealsName) async {
    MealsResponse mealsResult = await _repository.searchMeals(mealsName);
    _mealsFetcher.sink.add(mealsResult);
  }

  dispose() {
    _mealsFetcher.close();
  }
}