import "package:flutter/material.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'mainPages/MainGamePage.dart';
import 'mainPages/loginPage.dart';

void main() => runApp(navigate());

class navigate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
      ],
      locale: const Locale('tr'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      getPages: [
        GetPage(name: "/", page: () => loginPage_Body()),
        GetPage(name: "/mainPage", page: () => maingamePage())
      ],
    );
  }
}
