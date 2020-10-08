import 'package:json_annotation/json_annotation.dart';

import 'movie_model.dart';

part 'movie_popular_result.g.dart';

@JsonSerializable()
class Result {
  int page;
  int totalResults;
  int totalPages;
  List<Movie> results;

  Result({
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
