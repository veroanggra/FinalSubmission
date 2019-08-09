import 'package:bismillah_final_submission/version/meals_config.dart';
import 'my_app.dart';
import 'package:flutter/material.dart';

void main() {
  var configuredApp = AppConfig(
    displayName: "Premium Recipes App",
    debug: false,
    appId: 1,
    child: MyApp(),
  );

  runApp(configuredApp);
}
