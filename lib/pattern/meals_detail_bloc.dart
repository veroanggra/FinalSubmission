import 'package:rxdart/rxdart.dart';
import 'package:bismillah_final_submission/models/meals.dart';
import 'package:bismillah_final_submission/repository/repository.dart';

class MealsDetailBloc {
  final _repository = Repository();
  final _mealsDetailFetcher = PublishSubject<MealsResponse>();

  Observable<MealsResponse> get detailMeals => _mealsDetailFetcher.stream;

  fetchDetailMeals(String mealsId) async {
    MealsResponse mealsResult = await _repository.fetchDetailMeals(mealsId);
    _mealsDetailFetcher.sink.add(mealsResult);
  }

  dispose() {
    _mealsDetailFetcher.close();
  }
}