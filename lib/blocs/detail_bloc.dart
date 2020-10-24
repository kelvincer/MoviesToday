import 'dart:async';

import 'package:movies_today/models/detail/movie_detail.dart';
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

  DetailBloc({this.detailRepository}) {}

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
      if(value.results.isNotEmpty)
        print(value.results[0].key);
      addVideo.add(value);
    });
  }

  void dispose() {
    moviesController.close();
    videoController.close();
  }
}
