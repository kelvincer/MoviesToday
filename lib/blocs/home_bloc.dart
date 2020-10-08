import 'dart:async';

import 'package:movies_today/models/movie_model.dart';
import 'package:movies_today/repositories/movie_repository.dart';

class HomeBloc {
  final MovieRepository movieRepository;

  final StreamController<List<Movie>> moviesController =
      StreamController<List<Movie>>();
  Sink<List<Movie>> get addMovies => moviesController.sink;
  Stream<List<Movie>> get movies => moviesController.stream;

  HomeBloc({this.movieRepository}) {
    getMovies();
  }

  void dispose() {
    moviesController.close();
  }

  void getMovies() {
    final movies = movieRepository.getMovies();
    movies.then((value) {
      addMovies.add(value);
      print('new movies');
    });
  }
}
