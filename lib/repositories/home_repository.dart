import 'dart:convert';

import 'package:movies_today/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:movies_today/models/movie_popular_result.dart';
import 'package:movies_today/utils/constants.dart';

class MovieRepository {
  int _popularesPage = 0;
  bool _cargando = false;
  List<Movie> _populares = new List();

  Future<List<Movie>> getMovies() {
    if (_cargando) return Future<List<Movie>>.value([]);

    _cargando = true;
    _popularesPage++;

    final urlPath = Uri.https(url, '3/movie/popular', {
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
