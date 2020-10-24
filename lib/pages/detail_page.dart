import 'package:flutter/material.dart';
import 'package:movies_today/blocs/detail_bloc.dart';
import 'package:movies_today/models/movie_model.dart';
import 'package:movies_today/repositories/detail_repository.dart';
import 'package:movies_today/utils/constants.dart';
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
    return Scaffold(
      //appBar: AppBar(title: Text("Peli"),),
      body: StreamBuilder(
          stream:
              CombineLatestStream.list([detailBloc.detail, detailBloc.videos]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                  color: Colors.green,
                  child: Center(child: CircularProgressIndicator()));
            }
            final data0 = snapshot.data[0];
            final data1 = snapshot.data[1];

            print(data0);
            print(data1);

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _crearImagen(context, movie),
                  _createDescription(movie),
                  RaisedButton(
                    onPressed: () => launchURL("videoId"),
                    child: Text('Show Flutter homepage'),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget _crearImagen(BuildContext context, Movie movie) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        //onTap: ()=> Navigator.pushNamed(context, 'scroll'),
        child: Image(
          image: NetworkImage(movie.getPosterImg()),
          height: 250.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _createDescription(Movie movie) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Text(
          movie.overview,
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'Open Sans',
              fontSize: 15),
        ));
  }

  @override
  void dispose() {
    detailBloc.dispose();
    super.dispose();
  }
}
