import 'package:flutter/material.dart';
import 'package:movies_today/blocs/home_bloc.dart';
import 'package:movies_today/blocs/home_bloc_provider.dart';
import 'package:movies_today/models/movie_model.dart';
import 'package:movies_today/provider/page_notifier.dart';
import 'package:movies_today/repositories/home_repository.dart';
import 'package:movies_today/widgets/card_swiper_widget.dart';
import 'package:provider/provider.dart';

class HomePageFour extends StatefulWidget {
  @override
  _HomePageFourState createState() => _HomePageFourState();
}

class _HomePageFourState extends State<HomePageFour> {
  HomeBloc homeMovieBloc;
  int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    final movieRepository = MovieRepository();
    homeMovieBloc = HomeBloc(movieRepository: movieRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pelis"),
      ),
      body: _buildPages(context),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final navegationModel = Provider.of<NavegationModel>(context);

    return BottomNavigationBar(
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
      currentIndex: navegationModel.paginaActual,
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        navegationModel.paginaActual = index;
      },
    );
  }

  Widget _buildPages(BuildContext context) {
    final navegationModel = Provider.of<NavegationModel>(context);
    return PageView(
      controller: navegationModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Page(homeBloc: homeMovieBloc),
        _buildNowPlayingPage(context),
        _buildUpcomingPage(context)
      ],
    );
  }

  Widget _buildNowPlayingPage(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }

  Widget _buildUpcomingPage(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }

  @override
  void dispose() {
    homeMovieBloc.dispose();
    super.dispose();
  }
}

class Page extends StatefulWidget {
  final HomeBloc homeBloc;

  Page({Key key, this.homeBloc}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return HomeBlocProvider(
      homeBloc: widget.homeBloc,
      child: StreamBuilder(
        stream: widget.homeBloc.movies,
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
                child: CardSwiper(bloc: widget.homeBloc, movies: movies)),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
