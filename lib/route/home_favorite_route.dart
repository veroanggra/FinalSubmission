import 'package:flutter/material.dart';
import 'package:bismillah_final_submission/route/seafood_favorite_route.dart';
import 'package:bismillah_final_submission/route/dessert_favorite_route.dart';
import 'package:bismillah_final_submission/helper/key.dart';


class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.brown,
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white54,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  key: Key(KEY_TAB_ITEM_FAVORITE_DESSERT),
                  text: "Dessert",
                ),
                Tab(
                  key: Key(KEY_TAB_ITEM_FAVORITE_SEAFOOD),
                  text: "Seafood",
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            DessertFavorite(),
            SeafoodFavorite(),
          ],
        ),
      ),
    );
  }

}