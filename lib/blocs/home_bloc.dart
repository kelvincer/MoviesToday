import 'dart:async';

import 'package:movies_today/models/movie_model.dart';
import 'package:movies_today/repositories/movie_repository.dart';
import 'package:rxdart/subjects.dart';

class HomeBloc {
  final MovieRepository movieRepository;

  final StreamController<List<Movie>> moviesController =
      StreamController<List<Movie>>();
  Sink<List<Movie>> get addMovies => moviesController.sink;
  Stream<List<Movie>> get movies => moviesController.stream;

  final StreamController<String> titleController =
      BehaviorSubject<String>(); //StreamController<String>.broadcast();
  Stream<String> get title => titleController.stream;
  Sink<String> get addTitle => titleController.sink;

  final StreamController<bool> hasDataController = StreamController<bool>();
  Sink<bool> get addHasData => hasDataController.sink;
  Stream<bool> get data => hasDataController.stream;

  //Data
  List<Movie> moviesData;

  HomeBloc({this.movieRepository}) {
    getMovies();
  }

  void dispose() {
    moviesController.close();
    titleController.close();
    hasDataController.close();
  }

  void getMovies() {
    final movies = movieRepository.getMovies();
    movies.then((value) {
      moviesData = value;
      addHasData.add(true);
      addMovies.add(value);
      addTitle.add(moviesData[0].title);
      print('new movies');
    });
  }

  void setTitle(int index) {
    addTitle.add(moviesData[index].title);
  }
}
