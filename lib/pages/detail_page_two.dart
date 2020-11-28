import 'package:flutter/material.dart';
import 'package:movies_today/models/detail/movie_credit.dart';
import 'package:movies_today/models/detail/movie_similar.dart';
import 'package:movies_today/models/detail/movie_video.dart';
import 'package:movies_today/models/movie_model.dart';
import 'package:movies_today/provider/detail_provider.dart';
import 'package:movies_today/repositories/detail_repository.dart';
import 'package:movies_today/utils/combined.dart';
import 'package:movies_today/utils/constants.dart';
import 'package:movies_today/utils/text_util.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DetailProvider detailProvider;

  @override
  void initState() {
    super.initState();
    detailProvider = DetailProvider(DetailRepository());
  }

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    detailProvider.getMovieDetail(movie.id);
    detailProvider.getMovieVideo(movie.id);
    detailProvider.getMovieCredit(movie.id);
    detailProvider.getMovieSimilar(movie.id);
    return Scaffold(
      body: StreamProvider.value(
          value: Rx.combineLatest4(
              detailProvider.detail,
              detailProvider.videos,
              detailProvider.credit,
              detailProvider.similar,
              (a, b, c, d) => StreamCombined(a, b, c, d)),
          child: Consumer<StreamCombined>(
            builder: (context, value, _) {
              if (value == null) {
                return CustomScrollView(
                  slivers: <Widget>[
                    _crearAppbar(movie),
                    SliverFillRemaining(
                      //hasScrollBody: false,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  ],
                );
              }
              return CustomScrollView(slivers: <Widget>[
                _crearAppbar(movie),
                SliverList(
                  delegate: SliverChildListDelegate([
                    _firstSection(value.movieVideoModel),
                    _secondSection(movie),
                    _thirdSection(value.movieCreditModel),
                    _fourSection(value.movieSimilarModel),
                  ]),
                )
              ]);
            },
          )),
    );
  }

  Widget _crearAppbar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      expandedHeight: 240.0,
      floating: true,
      pinned: true,
      title: Text(
        movie.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: movie.uniqueId,
          child: FadeInImage(
            image: NetworkImage(movie.getPosterImg()),
            placeholder: AssetImage('assets/img/loading.gif'),
            fadeInDuration: Duration(milliseconds: 150),
            fit: BoxFit.cover,
            height: 240.0,
          ),
        ),
      ),
    );
  }

  Widget _secondSection(Movie movie) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontFamily: 'Open Sans',
                fontSize: 15),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            movie.overview,
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black, fontFamily: 'Open Sans', fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _firstSection(MovieVideoModel model) {
    return Container(
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (model.results.isNotEmpty)
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                  customBorder: CircleBorder(),
                  onTap: () {
                    print("video: ${model.results[0].key}");
                    launchURL(model.results[0].key);
                  },
                  child: _accion(Icons.movie, "Video")),
            ),
          _accion(Icons.thumb_up, "Vote"),
          _accion(Icons.star, "Star")
        ],
      ),
    );
  }

  Widget _accion(IconData icon, String texto) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Icon(icon, size: 30.0),
          SizedBox(height: 5.0),
          Text(
            texto,
            style: TextStyle(fontSize: 15.0, color: Colors.blue),
          )
        ],
      ),
    );
  }

  Widget _thirdSection(MovieCreditModel credit) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cast",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontFamily: 'Open Sans',
                fontSize: 15),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            joinNames(credit.cast),
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.black, fontFamily: 'Open Sans', fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _fourSection(MovieSimilarModel similars) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Similar",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontFamily: 'Open Sans',
                fontSize: 15),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            height: 150,
            width: double.infinity,
            child: ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: similars.results.length,
              itemBuilder: (BuildContext context, int index) => Card(
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: 250.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          similars.results[index].getBackgroundImg()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
