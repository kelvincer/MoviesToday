import 'package:flutter/material.dart';
import 'package:movies_today/blocs/detail_bloc.dart';
import 'package:movies_today/models/detail/movie_credit.dart';
import 'package:movies_today/models/detail/movie_similar.dart';
import 'package:movies_today/models/detail/movie_video.dart';
import 'package:movies_today/models/movie_model.dart';
import 'package:movies_today/repositories/detail_repository.dart';
import 'package:movies_today/utils/constants.dart';
import 'package:movies_today/utils/text_util.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailPage extends StatefulWidget {
  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  DetailBloc detailBloc;

  @override
  void initState() {
    super.initState();
    detailBloc = DetailBloc(detailRepository: DetailRepository());
  }

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    detailBloc.getMovieDetail(movie.id);
    detailBloc.getMovieVideo(movie.id);
    detailBloc.getMovieCredit(movie.id);
    detailBloc.getMovieSimilar(movie.id);
    return Scaffold(
      body: StreamBuilder(
          stream: CombineLatestStream.list([
            detailBloc.detail,
            detailBloc.videos,
            detailBloc.credit,
            detailBloc.similar
          ]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
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
            final data0 = snapshot.data[0];
            final data1 = snapshot.data[1];
            final data2 = snapshot.data[2];
            final data3 = snapshot.data[3];

            print(data0);
            print(data1);
            print(data2);

            /* return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _crearImagen(context, movie),
                  _firstSection(data1),
                  _secondSection(movie),
                  _thirdSection(data2),
                  _fourSection(data3),
                  RaisedButton(
                    onPressed: () => launchURL("videoId"),
                    child: Text('Show Flutter homepage'),
                  ),
                ],
              ),
            ); */
            return CustomScrollView(slivers: <Widget>[
              _crearAppbar(movie),
              SliverList(
                delegate: SliverChildListDelegate([
                  _firstSection(data1),
                  _secondSection(movie),
                  _thirdSection(data2),
                  _fourSection(data3),
                  RaisedButton(
                    onPressed: () => launchURL("videoId"),
                    child: Text('Show Flutter homepage'),
                  ),
                ]),
              )
            ]);
          }),
    );
  }

  Widget _crearImagen(BuildContext context, Movie movie) {
    return Hero(
      tag: movie.uniqueId,
      child: Container(
        width: double.infinity,
        child: GestureDetector(
          child: Image(
            image: NetworkImage(movie.getPosterImg()),
            height: 250.0,
            fit: BoxFit.cover,
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
          /* model.results.isEmpty
              ? Visibility(
                  child: Container(),
                  visible: false,
                )
              : Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                      customBorder: CircleBorder(),
                      onTap: () {
                        print("video: ${model.results[0].key}");
                        launchURL(model.results[0].key);
                      },
                      child: _accion(Icons.movie, "Video")),
                ), */
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
          _accion(Icons.favorite, "Vote"),
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

  /* Widget _crearAppbar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 240.0,
      //floating: true,
      //pinned: true,
      title: Text("Kelvin"),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.all(2.0),
        centerTitle: true,
        title: Opacity(
          opacity: 0.75,
          child: Container(
            color: Colors.grey[600],
            //margin: EdgeInsets.symmetric(horizontal: 10.0),
            //padding: EdgeInsets.all(5.0),
            child: Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        background: Hero(
          tag: movie.uniqueId,
          child: FadeInImage(
            image: NetworkImage(movie.getPosterImg()),
            placeholder: AssetImage('assets/img/loading.gif'),
            fadeInDuration: Duration(milliseconds: 150),
            fit: BoxFit.fitWidth,
            height: 250.0,
          ),
        ),
      ),
    );
  } */

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
        titlePadding: EdgeInsets.all(2.0),
        background: Hero(
          tag: movie.uniqueId,
          child: FadeInImage(
            image: NetworkImage(movie.getPosterImg()),
            placeholder: AssetImage('assets/img/loading.gif'),
            fadeInDuration: Duration(milliseconds: 150),
            fit: BoxFit.fitWidth,
            height: 240.0,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    detailBloc.dispose();
    super.dispose();
  }
}
