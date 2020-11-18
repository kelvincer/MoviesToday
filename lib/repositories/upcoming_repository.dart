import 'dart:convert';

import 'package:movies_today/models/movie_model.dart';
import 'package:movies_today/models/movie_popular_result.dart';
import 'package:movies_today/repositories/home_repository.dart';
import 'package:movies_today/utils/constants.dart';
import 'package:http/http.dart' as http;

class UpcomingRepository extends HomeRepository {
  bool _cargando = false;
  int _popularesPage = 0;

  Future<List<Movie>> getMovies() {
    if (_cargando) return Future<List<Movie>>.value([]);

    _cargando = true;
    _popularesPage++;

    final urlPath = Uri.https(url, '3/movie/upcoming', {
      'api_key': apikey,
      'language': language,
      'page': _popularesPage.toString()
    });

    final resp = _requestPopularMovies(urlPath);
    _cargando = false;
    return resp;
  }

  Future<List<Movie>> _requestPopularMovies(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = Result.fromJson(decodedData);

    return peliculas.results;
  }
}
