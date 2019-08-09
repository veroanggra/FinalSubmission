import 'package:flutter/material.dart';
import 'package:bismillah_final_submission/helper/key.dart';
import 'package:bismillah_final_submission/db/favorite_provider.dart';
import 'package:bismillah_final_submission/pattern/meals_detail_bloc.dart';
import 'package:bismillah_final_submission/models/meals.dart';
import 'package:toast/toast.dart';

class DetailPage extends StatefulWidget {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String type;

  DetailPage(
      {Key key,
      @required this.idMeal,
      this.strMeal,
      this.strMealThumb,
      this.type})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  final bloc = MealsDetailBloc();
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    bloc.fetchDetailMeals(widget.idMeal);
    FavoriteProvider.db.getFavoriteMealsById(widget.idMeal).then((value) {
      setState(() => _isFavorite = value != null);
    });
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
              expandedHeight: 300,
              floating: false,
              pinned: true,
              leading: IconButton(
                key: Key(KEY_TAP_BACK),
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: <Widget>[
                _buildActionAppBar(),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.strMeal.length > 24
                      ? widget.strMeal.substring(0, 24)
                      : widget.strMeal,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                background: Hero(
                  tag: widget.strMeal,
                  child: Material(
                    child: InkWell(
                      child: Image.network(widget.strMealThumb,
                          width: double.infinity, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: getDetail(),
      ),
    );
  }

  Widget _buildActionAppBar() {
    if (_isFavorite) {
      return GestureDetector(
        onTap: () {
          FavoriteProvider.db
              .deleteFavoriteMealsById(widget.idMeal)
              .then((value) {
            if (value > 0) {
              setState(() => _isFavorite = false);
            }
          });
          showToast(context, "Remove from Favorite",
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        },
        child: Padding(
          key: Key(KEY_TAP_ITEM_FAVORITE),
          padding: EdgeInsets.all(16.0),
          child: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          Meals favoriteFood = Meals(
            idMeal: widget.idMeal,
            strMeal: widget.strMeal,
            strMealThumb: widget.strMealThumb,
            type: widget.type,
          );
          FavoriteProvider.db.addFavoriteMeals(favoriteFood).then((value) {
            if (value > 0) {
              setState(() => _isFavorite = true);
            }
          });
          showToast(context, "Add to Favorite",
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        },
        child: Padding(
          key: Key(KEY_TAP_ITEM_FAVORITE),
          padding: EdgeInsets.all(16.0),
          child: Icon(
            Icons.favorite_border,
            color: Colors.red,
          ),
        ),
      );
    }
  }

  getDetail() {
    return StreamBuilder(
        stream: bloc.detailMeals,
        builder: (context, AsyncSnapshot<MealsResponse> snapshot) {
          if (snapshot.hasData) {
            return _showListDetail(
                snapshot.data.meals[0].strCategory,
                snapshot.data.meals[0].strArea,
                snapshot.data.meals[0].strIngredient1,
                snapshot.data.meals[0].strIngredient2,
                snapshot.data.meals[0].strIngredient3,
                snapshot.data.meals[0].strIngredient4,
                snapshot.data.meals[0].strIngredient5,
                snapshot.data.meals[0].strInstructions);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
        });
  }

  Widget _showListDetail(
      String category,
      String area,
      String ingredient1,
      String ingredient2,
      String ingredient3,
      String ingredient4,
      String ingredient5,
      String desc) {
    return SingleChildScrollView(
        child: Card(
      margin: EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Category",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    category,
                    style: TextStyle(
                        fontStyle: FontStyle.normal, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "\nFusion",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    area,
                    style: TextStyle(
                        fontStyle: FontStyle.normal, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "\nIngredients",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ingredient1 +
                        ', ' +
                        ingredient1 +
                        ', ' +
                        ingredient2 +
                        ', ' +
                        ingredient3 +
                        ', ' +
                        ingredient4 +
                        ', ' +
                        ingredient5,
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "\nDescrition",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    desc,
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

void showToast(BuildContext context, String mealsName,
    {int duration, int gravity}) {
  Toast.show(mealsName, context, duration: duration, gravity: gravity);
}
