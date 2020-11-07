import 'package:flutter/material.dart';
import 'package:movies_today/pages/detail_page.dart';
import 'package:movies_today/pages/home_page_four.dart';
import 'package:movies_today/pages/home_page_three.dart';
import 'package:movies_today/provider/page_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NavegationModel())],
      child: MaterialApp(
        title: 'Peliculas',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => HomePageFour(),
          'detalle': (BuildContext context) => MovieDetailPage(),
        },
      ),
    );
  }
}
