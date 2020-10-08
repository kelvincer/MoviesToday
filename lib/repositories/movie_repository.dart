import 'dart:convert';

import 'package:movies_today/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:movies_today/models/movie_popular_result.dart';

class MovieRepository {
  String _apikey = '6435183fc8e829478cb5f8539efd1e71';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 0;
  bool _cargando = false;
  List<Movie> _populares = new List();

  
  Future<List<Movie>> getMovies() {
    if (_cargando) return Future<List<Movie>>.value([]);

    _cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = _requestPopularMovies(url);

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
