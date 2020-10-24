import 'package:flutter/material.dart';
import 'package:movies_today/pages/detail_page.dart';
import 'package:movies_today/pages/home_page_four.dart';
import 'package:movies_today/pages/home_page_three.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/'       : ( BuildContext context ) => HomePageFour(),
        'detalle' : ( BuildContext context ) => MovieDetailPage(),
      },
    );
  }
}
