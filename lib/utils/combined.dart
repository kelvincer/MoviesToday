import 'package:movies_today/models/detail/movie_credit.dart';
import 'package:movies_today/models/detail/movie_detail.dart';
import 'package:movies_today/models/detail/movie_similar.dart';
import 'package:movies_today/models/detail/movie_video.dart';

class StreamCombined {
  MovieDetailModel movieDetailModel;
  MovieVideoModel movieVideoModel;
  MovieCreditModel movieCreditModel;
  MovieSimilarModel movieSimilarModel;

  int initial = 0;

  StreamCombined(this.movieDetailModel, this.movieVideoModel,
      this.movieCreditModel, this.movieSimilarModel);
}
