import 'package:flutter/material.dart';
import 'package:movies_today/blocs/home_bloc.dart';
import 'package:movies_today/blocs/home_bloc_provider.dart';
import 'package:movies_today/models/movie_model.dart';
import 'package:movies_today/repositories/movie_repository.dart';
import 'package:movies_today/widgets/card_swiper_widget.dart';

class HomePageThree extends StatefulWidget {
  @override
  _HomePageThreeState createState() => _HomePageThreeState();
}

class _HomePageThreeState extends State<HomePageThree> {
  List<Movie> movies;
  String movieTitle;
  HomeBloc homeMovieBloc;

  @override
  void initState() {
    final movieRepository = MovieRepository();
    homeMovieBloc = HomeBloc(movieRepository: movieRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pelis"),
      ),
      body: HomeBlocProvider(
        homeBloc: homeMovieBloc,
        child: StreamBuilder(
          stream: homeMovieBloc.movies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              movies = snapshot.data;
              return _buildHome(movies);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Popular',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Now Playing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Upcoming',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {},
      ),
    );
  }

  Widget _buildHome(List<Movie> movies) {
    movieTitle = movies[0].title;
    return Container(
      color: Colors.red,
      child: Column(
        children: [
          //SizedBox(height: 20.0),
          Container(
            height: 60.0,
            child: HomeBlocProvider(
              homeBloc: homeMovieBloc,
              child: StreamBuilder(
                stream: homeMovieBloc.title,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final title = snapshot.data;
                    return Center(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Open Sans',
                            fontSize: 20),
                      ),
                    );
                  }

                  return Text('');
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
              child: Center(
                child: CardSwiper(movies: movies, callback: setTitle),
              ),
            ),
          )
        ],
      ),
    );
  }

  void setTitle(int index) {
    homeMovieBloc.setTitle(index);
  }

  @override
  void dispose() {
    homeMovieBloc.dispose();
    super.dispose();
  }
}
