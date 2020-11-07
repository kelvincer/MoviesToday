import 'dart:convert';

import 'package:movies_today/models/detail/movie_credit.dart';
import 'package:movies_today/models/detail/movie_detail.dart';
import 'package:movies_today/models/detail/movie_similar.dart';
import 'package:movies_today/models/detail/movie_video.dart';
import 'package:movies_today/utils/constants.dart';
import 'package:http/http.dart' as http;

class DetailRepository {
  Future<MovieDetailModel> getMovieDetail(int id) {
    final urlPath = Uri.https(
        url, '3/movie/$id', {'api_key': apikey, 'language': language});

    final resp = _requestMovieDetail(urlPath);
    return resp;
  }

  Future<MovieDetailModel> _requestMovieDetail(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movie = MovieDetailModel.fromJson(decodedData);

    return movie;
  }

  Future<MovieVideoModel> getMovieVideo(int id) {
    final urlPath = Uri.https(
        url, '3/movie/$id/videos', {'api_key': apikey, 'language': language});
    final resp = _requestMovieVideo(urlPath);
    return resp;
  }

  Future<MovieVideoModel> _requestMovieVideo(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movie = MovieVideoModel.fromJson(decodedData);

    return movie;
  }

  Future<MovieCreditModel> getMovieCredits(int id) {
    final urlPath = Uri.https(
        url, '3/movie/$id/credits', {'api_key': apikey, 'language': language});
    final resp = _requestMovieCredit(urlPath);
    return resp;
  }

  Future<MovieCreditModel> _requestMovieCredit(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final credit = MovieCreditModel.fromJson(decodedData);

    return credit;
  }

  Future<MovieSimilarModel> getMovieSimilars(int id) {
    final urlPath = Uri.https(
        url, '3/movie/$id/similar', {'api_key': apikey, 'language': language,
        'page': 1.toString()});
    final resp = _requestMovidSimilar(urlPath);
    return resp;
  }

  Future<MovieSimilarModel> _requestMovidSimilar(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final similar = MovieSimilarModel.fromJson(decodedData);
    return similar;
  }
}
