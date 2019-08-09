import 'package:flutter/material.dart';
import 'package:bismillah_final_submission/models/meals.dart';
import 'package:bismillah_final_submission/db/favorite_provider.dart';
import 'package:bismillah_final_submission/helper/key.dart';
import 'package:bismillah_final_submission/animation/hero.dart';
import 'package:toast/toast.dart';
import 'package:bismillah_final_submission/route/detail_route.dart';

class DessertFavorite extends StatefulWidget {
  @override
  _DessertFavoriteState createState() => _DessertFavoriteState();
}

class _DessertFavoriteState extends State<DessertFavorite> {
  Future<List<Meals>> _dessertFavoriteFoods;

  @override
  void initState() {
    super.initState();
    _dessertFavoriteFoods =
        FavoriteProvider.db.getFavoriteMealsByType("dessert");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown,
      child: FutureBuilder(
        initialData: <Meals>[],
        future: _dessertFavoriteFoods,
        builder: (BuildContext context, AsyncSnapshot<List<Meals>> snapshot) {
          if (snapshot.hasError) {
            showToast(context, snapshot.error.toString(),
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            return Center(
              child: Text("Not Available"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Meals> favoriteFoods = snapshot.data;
            if (favoriteFoods.isEmpty) {
              return Center(
                child: Text(
                  "There is no data here",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return _showListFavoriteDessert(favoriteFoods);
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _showListFavoriteDessert(List<Meals> favoriteFoods) {
    return GridView.builder(
      key: Key(KEY_GRID_FAVORITE_DESSERT),
      itemCount: favoriteFoods.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Card(
            key: Key("tap_meals_favorite_" + favoriteFoods[index].idMeal),
            elevation: 2.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            margin: EdgeInsets.all(10),
            child: GridTile(
              child: ImageHero(
                tag: favoriteFoods[index].strMeal,
                onTap: () {
                  showToast(context, favoriteFoods[index].strMeal,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 800),
                        pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) =>
                            DetailPage(
                                idMeal: favoriteFoods[index].idMeal,
                                strMeal: favoriteFoods[index].strMeal,
                                strMealThumb: favoriteFoods[index].strMealThumb,
                                type: "seafood"),
                      ));
                },
                image: favoriteFoods[index].strMealThumb,
              ),
              footer: Container(
                color: Colors.white,
                padding: EdgeInsets.all(6),
                child: Text(
                  favoriteFoods[index].strMeal,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

void showToast(BuildContext context, String mealsName,
    {int duration, int gravity}) {
  Toast.show(mealsName, context, duration: duration, gravity: gravity);
}
