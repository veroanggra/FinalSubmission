import 'package:flutter/material.dart';
import '../models/meals.dart';
import 'package:bismillah_final_submission/pattern/meals_list_bloc.dart';
import 'package:bismillah_final_submission/animation/hero.dart';
import 'package:bismillah_final_submission/route/detail_route.dart';
import 'package:toast/toast.dart';
import 'search_route.dart';
import 'package:bismillah_final_submission/helper/key.dart';

class SeafoodScreen extends StatefulWidget {
  @override
  SeafoodState createState() => new SeafoodState();
}

class SeafoodState extends State<SeafoodScreen> {
  final bloc = MealsBloc();

  @override
  void initState() {
    super.initState();
    bloc.fetchAllMeals('Seafood');
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: FloatingActionButton(
              key: Key(KEY_TAP_SEARCH),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MealsSearch()));
              },
              backgroundColor: Colors.amber,
              child: Icon(Icons.search),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)))),
        ),
        body: getListSeafood());
  }

  getListSeafood() {
    return Container(
      color: Colors.brown,
      child: Center(
        child: StreamBuilder(
          stream: bloc.allMeals,
          builder: (context, AsyncSnapshot<MealsResponse> snapshot) {
            if (snapshot.hasData) {
              return _showSeafood(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
          },
        ),
      ),
    );
  }

  Widget _showSeafood(AsyncSnapshot<MealsResponse> snapshot) =>
      GridView.builder(
        key: Key(KEY_GRID_VIEW_SEAFOOD),
        itemCount: snapshot == null ? 0 : snapshot.data.meals.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Card(
              key: Key("tap_meals" + snapshot.data.meals[index].idMeal),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              margin: EdgeInsets.all(10),
              child: GridTile(
                child: ImageHero(
                  tag: snapshot.data.meals[index].strMeal,
                  onTap: () {
                    showToast(context, snapshot.data.meals[index].strMeal,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 1000),
                          pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) =>
                              DetailPage(
                                  idMeal: snapshot.data.meals[index].idMeal,
                                  strMeal: snapshot.data.meals[index].strMeal,
                                  strMealThumb:
                                      snapshot.data.meals[index].strMealThumb,
                                  type: "seafood"),
                        ));
                  },
                  image: snapshot.data.meals[index].strMealThumb,
                ),
                footer: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    snapshot.data.meals[index].strMeal,
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
void showToast(BuildContext context, String mealsName,
     {int duration, int gravity}) {
   Toast.show(mealsName, context, duration: duration, gravity: gravity);
}

