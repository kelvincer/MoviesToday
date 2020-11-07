import 'dart:async';

import 'package:movies_today/models/detail/movie_credit.dart';
import 'package:movies_today/models/detail/movie_detail.dart';
import 'package:movies_today/models/detail/movie_similar.dart';
import 'package:movies_today/models/detail/movie_video.dart';
import 'package:movies_today/repositories/detail_repository.dart';
import 'package:rxdart/rxdart.dart';

class DetailBloc {
  DetailRepository detailRepository;

  final StreamController<MovieDetailModel> moviesController =
      StreamController<MovieDetailModel>();
  Sink<MovieDetailModel> get addDetail => moviesController.sink;
  Stream<MovieDetailModel> get detail => moviesController.stream;

  final StreamController<MovieVideoModel> videoController =
      StreamController<MovieVideoModel>();
  Sink<MovieVideoModel> get addVideo => videoController.sink;
  Stream<MovieVideoModel> get videos => videoController.stream;

  final StreamController<MovieCreditModel> creditController =
      StreamController<MovieCreditModel>();
  Sink<MovieCreditModel> get addCredit => creditController.sink;
  Stream<MovieCreditModel> get credit => creditController.stream;

  final StreamController<MovieSimilarModel> similarController =
      StreamController<MovieSimilarModel>();
  Sink<MovieSimilarModel> get addSimilar => similarController.sink;
  Stream<MovieSimilarModel> get similar => similarController.stream;

  DetailBloc({this.detailRepository});

  getMovieDetail(int id) {
    final movie = detailRepository.getMovieDetail(id);
    movie.then((value) {
      print(value.originalTitle);
      addDetail.add(value);
    });
  }

  getMovieVideo(int id) {
    final video = detailRepository.getMovieVideo(id);
    video.then((value) {
      if (value.results.isNotEmpty) print(value.results[0].key);
      addVideo.add(value);
    });
  }

  getMovieCredit(int id) {
    final credit = detailRepository.getMovieCredits(id);
    credit.then((value) {
      addCredit.add(value);
    });
  }

  getMovieSimilar(int id) {
    final similar = detailRepository.getMovieSimilars(id);
    similar.then((value) {
      addSimilar.add(value);
    });
  }

  void dispose() {
    moviesController.close();
    videoController.close();
    creditController.close();
    similarController.close();
  }
}
