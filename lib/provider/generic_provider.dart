import 'package:flutter/material.dart';
import 'package:movies_today/models/movie_model.dart';
import 'package:movies_today/repositories/popular_repository.dart';
import 'package:movies_today/repositories/home_repository.dart';
import 'package:movies_today/repositories/upcoming_repository.dart';

class GenericHomeProvider<P extends HomeRepository> extends ChangeNotifier {
  P repository;
  String _title = "";
  String get title => _title;
  List<Movie> populares = [];

  GenericHomeProvider({this.repository});

  void getMovies() {
    var resp = repository.getMovies();
    resp.then((value) {
      print("populares movies");
      populares = value;
      _title = populares[0].title;
      notifyListeners();
    });
  }

  void setTitle(int index) {
    _title = populares[index].title;
    notifyListeners();
  }

  String getPrefix() {
    if (repository is PopularMoviesRepository) {
      return "popular";
    } else if (repository is UpcomingRepository) {
      return "upcoming";
    }
    return "now_playing";
  }
}
