import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:bismillah_final_submission/route/seafood_route.dart';
import 'package:bismillah_final_submission/route/desert_route.dart';
import 'package:bismillah_final_submission/route/home_favorite_route.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:bismillah_final_submission/version/meals_config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    DesertPage(),
    SeafoodScreen(),
    FavoriteScreen()
  ];

  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
      appBar: new AppBar(
        title: Text(config.displayName),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.cake, title: 'Dessert'),
            TabData(iconData: Icons.fastfood, title: 'Seafood'),
            TabData(iconData: Icons.favorite, title: 'Favorite')
          ],
          onTabChangedListener: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}

void showToast(BuildContext context, String mealsName,
    {int duration, int gravity}) {
  Toast.show(mealsName, context, duration: duration, gravity: gravity);
}
