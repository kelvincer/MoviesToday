import 'dart:convert';

class MovieSimilarModel {
    MovieSimilarModel({
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

    int page;
    List<ResultSimilar> results;
    int totalPages;
    int totalResults;

    factory MovieSimilarModel.fromRawJson(String str) => MovieSimilarModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MovieSimilarModel.fromJson(Map<String, dynamic> json) => MovieSimilarModel(
        page: json["page"],
        results: List<ResultSimilar>.from(json["results"].map((x) => ResultSimilar.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class ResultSimilar {
    ResultSimilar({
        this.adult,
        this.backdropPath,
        this.genreIds,
        this.id,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.releaseDate,
        this.posterPath,
        this.popularity,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount,
    });

    bool adult;
    dynamic backdropPath;
    List<int> genreIds;
    int id;
    String originalLanguage;
    String originalTitle;
    String overview;
    DateTime releaseDate;
    dynamic posterPath;
    double popularity;
    String title;
    bool video;
    double voteAverage;
    int voteCount;

    factory ResultSimilar.fromRawJson(String str) => ResultSimilar.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResultSimilar.fromJson(Map<String, dynamic> json) => ResultSimilar(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        releaseDate: DateTime.parse(json["release_date"]),
        posterPath: json["poster_path"],
        popularity: json["popularity"].toDouble(),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "poster_path": posterPath,
        "popularity": popularity,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };

    getBackgroundImg() {

    if ( posterPath == null ) {
      return 'https://cdn11.bigcommerce.com/s-auu4kfi2d9/stencil/59512910-bb6d-0136-46ec-71c445b85d45/e/933395a0-cb1b-0135-a812-525400970412/icons/icon-no-image.svg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }

  }
}
