import 'package:flutter/material.dart';
import 'package:bismillah_final_submission/helper/key.dart';
import 'package:toast/toast.dart';
import 'package:bismillah_final_submission/route/detail_route.dart';
import 'package:bismillah_final_submission/pattern/meals_search_bloc.dart';
import 'package:bismillah_final_submission/models/meals.dart';
import 'package:bismillah_final_submission/animation/hero.dart';

class MealsSearch extends StatefulWidget {
  @override
  _MealsSearchState createState() => _MealsSearchState();
}

class _MealsSearchState extends State<MealsSearch> {
  final bloc = MealsSearchBloc();

  @override
  void initState() {
    super.initState();
    bloc.searchAllMeals("");
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                key: Key(KEY_TAP_BACK),
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              centerTitle: true,
              floating: true,
              pinned: true,
              title: TextField(
                key: Key(KEY_FIELD_SEARCH),
                autofocus: true,
                style: TextStyle(fontSize: 17, color: Colors.white),
                decoration: InputDecoration.collapsed(
                  hintText: "Type Menus..",
                  hintStyle: TextStyle(fontSize: 17, color: Colors.white),
                ),
                onChanged: bloc.searchAllMeals,
              ),
            )
          ];
        },
        body: getListResult(),
      ),
    );
  }

  getListResult() {
    return Container(
      color: Colors.brown,
      child: Center(
        child: StreamBuilder(
          stream: bloc.searchMeals,
          builder: (context, AsyncSnapshot<MealsResponse> snapshot) {
            if (snapshot.hasData) {
              return _showListResult(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
            }
          },
        ),
      ),
    );
  }

  Widget _showListResult(AsyncSnapshot<MealsResponse> snapshot) {
    return GridView.builder(
      key: Key(KEY_GRID_SEARCH),
      itemCount: snapshot == null ? 0 : snapshot?.data?.meals?.length ?? 0,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Card(
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
                            ),
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
}
void showToast(BuildContext context, String mealsName,
     {int duration, int gravity}) {
  Toast.show(mealsName, context, duration: duration, gravity: gravity);
}

