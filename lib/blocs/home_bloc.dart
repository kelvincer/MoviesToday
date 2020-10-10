import 'dart:async';

import 'package:movies_today/models/movie_model.dart';
import 'package:movies_today/repositories/movie_repository.dart';

class HomeBloc {
  final MovieRepository movieRepository;

  final StreamController<List<Movie>> moviesController =
      StreamController<List<Movie>>();
  Sink<List<Movie>> get addMovies => moviesController.sink;
  Stream<List<Movie>> get movies => moviesController.stream;

  final StreamController<String> titleController = StreamController<String>();
  Sink<String> get addTitle => titleController.sink;
  Stream<String> get title => titleController.stream;

  //Data
  List<Movie> moviesData;

  HomeBloc({this.movieRepository}) {
    getMovies();
  }

  void dispose() {
    moviesController.close();
    titleController.close();
  }

  void getMovies() {
    final movies = movieRepository.getMovies();
    movies.then((value) {
      moviesData = value;
      addMovies.add(value);
      addTitle.add(moviesData[0].title);
      print('new movies');
    });
  }

  void setTitle(int index) {
    addTitle.add(moviesData[index].title);
  }
}
