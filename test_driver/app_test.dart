import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:bismillah_final_submission/helper/key.dart';

void main() {
  group("Premium Recipes App", () {
    FlutterDriver driver;

    final tapItemFavoriteSeafoodKey = find.byValueKey(KEY_TAP_ITEM_FAVORITE_SEAFOOD);
    final tapItemFavoriteDessertKey = find.byValueKey(KEY_TAB_ITEM_FAVORITE_DESSERT);
    final enterField = find.byValueKey(KEY_FIELD_SEARCH);
    final tapBackButtonKey = find.byValueKey(KEY_TAP_BACK);
    final gridDessertKey = find.byValueKey(KEY_GRID_DESSERT);
    final gridSeafoodKey = find.byValueKey(KEY_GRID_VIEW_SEAFOOD);

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Tap Favorite Item ', () async {
      //fav seafood
      await driver.tap(tapItemFavoriteSeafoodKey);
      await Future.delayed(Duration(microseconds: 800));

      //fav desserst
      await driver.tap(tapItemFavoriteDessertKey);
      await Future.delayed(Duration(microseconds: 800));

      //back button
      await driver.tap(tapBackButtonKey);
      await Future.delayed(Duration(seconds: 1));
    });

    test('Search Item ', () async {
      //search intinary
      await driver.tap(enterField);
      await driver.enterText("Tart");
      await Future.delayed(Duration(microseconds: 1000));
    });

    test('List Item ', () async {
      //list dessert
      await driver.waitFor(gridDessertKey);
      await Future.delayed(Duration(seconds: 1));
      await driver.scroll(gridDessertKey, 0, 200, Duration(milliseconds: 500));

      //list seafood
      await driver.waitFor(gridSeafoodKey);
      await Future.delayed(Duration(seconds: 1));
      await driver.scroll(gridSeafoodKey, 0, 200, Duration(milliseconds: 500));
    });
  });
}
