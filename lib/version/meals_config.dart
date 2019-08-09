import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  final bool debug;
  final String displayName;
  final int appId;

  AppConfig({this.debug, this.displayName, this.appId, Widget child})
      : super(child: child);

  static AppConfig of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppConfig);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
