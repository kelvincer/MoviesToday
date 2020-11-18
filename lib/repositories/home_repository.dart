import 'package:movies_today/models/movie_model.dart';

abstract class HomeRepository {
  Future<List<Movie>> getMovies();
}
