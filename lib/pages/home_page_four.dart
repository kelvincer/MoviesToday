import 'package:flutter/material.dart';
import 'package:movies_today/blocs/home_bloc.dart';
import 'package:movies_today/blocs/home_bloc_provider.dart';
import 'package:movies_today/models/movie_model.dart';
import 'package:movies_today/repositories/home_repository.dart';
import 'package:movies_today/widgets/card_swiper_widget.dart';

class HomePageFour extends StatefulWidget {
  @override
  _HomePageFourState createState() => _HomePageFourState();
}

class _HomePageFourState extends State<HomePageFour> {
  HomeBloc homeMovieBloc;

  @override
  void initState() {
    super.initState();
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
              List<Movie> movies = snapshot.data;
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
    return Container(
      color: Colors.red,
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.green,
              child: CardSwiper(bloc: homeMovieBloc, movies: movies)
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    homeMovieBloc.dispose();
    super.dispose();
  }
}
