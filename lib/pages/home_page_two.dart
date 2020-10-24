import 'package:flutter/material.dart';
import 'package:movies_today/blocs/home_bloc.dart';
import 'package:movies_today/blocs/home_bloc_provider.dart';
import 'package:movies_today/models/movie_model.dart';
import 'package:movies_today/repositories/home_repository.dart';

class HomePageMovie extends StatefulWidget {
  @override
  _HomePageMovieState createState() => _HomePageMovieState();
}

class _HomePageMovieState extends State<HomePageMovie> {
  bool _showAppBar = true;

  @override
  Widget build(BuildContext context) {
    //final movieRepository = HomeRepository();
    //final homeMovieBloc = HomeBlocTwo(homeRepository: movieRepository);

    final movieRepository = MovieRepository();
    final homeMovieBloc = HomeBloc(movieRepository: movieRepository);
    return Scaffold(
      body: HomeBlocProvider(
        homeBloc: homeMovieBloc,
        child: StreamBuilder(
          stream: homeMovieBloc.movies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Movie> movies = snapshot.data;
              return _buildHome(context, movies);
            } else {
              return CustomScrollView(
                slivers: <Widget>[
                  _appBarLoader(),
                  SliverFillRemaining(
                    child: Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {},
      ),
    );
  }

  Widget _buildHome(BuildContext context, List<Movie> movies) {
    Movie movie = movies[0];
    return CustomScrollView(
      slivers: <Widget>[
        _crearAppbar(movie),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 10.0),
            _posterTitulo(context, movie),
            _descripcion(movie),
            _descripcion(movie),
            _descripcion(movie),
            _descripcion(movie),
          ]),
        )
      ],
    );
  }

  Widget _appBarLoader() {
    return SliverAppBar(
      elevation: 2.0,
      flexibleSpace: Image(
        image: AssetImage('assets/img/loading.gif'),
        fit: BoxFit.cover,
      ),
      expandedHeight: 200.0,
    );
  }

  Widget _crearAppbar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.blue,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(seconds: 5),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(movie.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.title,
                    style: Theme.of(context).textTheme.headline1,
                    overflow: TextOverflow.ellipsis),
                Text(movie.originalTitle,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(movie.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subhead)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _descripcion(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
