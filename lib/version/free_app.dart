import 'package:bismillah_final_submission/version/meals_config.dart';
import 'package:flutter/material.dart';
import 'my_app.dart';

void main() {
  var settingApp = AppConfig(
    displayName: "Free Recipes App",
    debug: true,
    appId: 1,
    child: MyApp(),
  );
  runApp(settingApp);
}
