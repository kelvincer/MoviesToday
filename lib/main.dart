import 'package:flutter/material.dart';
import 'package:movies_today/pages/home_page_three.dart';
import 'package:movies_today/pages/movie_detail.dart';

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
        '/'       : ( BuildContext context ) => HomePageThree(),
        'detalle' : ( BuildContext context ) => MovieDetail(),
      },
    );
  }
}
