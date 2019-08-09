import 'package:flutter/material.dart';
import 'package:bismillah_final_submission/version/meals_config.dart';
import 'package:bismillah_final_submission/route/home_route.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);
    return _buildApp(config.displayName, config.debug);
  }

  Widget _buildApp(String appName, bool debug) {
    return MaterialApp(
      debugShowCheckedModeBanner: debug,
      title: appName,
      theme: ThemeData(
        primaryColor: Colors.brown,
      ),
      home: HomePage(),
    );
  }
}
