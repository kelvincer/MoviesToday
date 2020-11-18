import 'package:flutter/material.dart';
import 'package:movies_today/pages/home/now_playing_home.dart';
import 'package:movies_today/pages/home/popular_home.dart';
import 'package:movies_today/pages/home/upcoming_home.dart';
import 'package:movies_today/provider/page_notifier.dart';
import 'package:provider/provider.dart';

class HomePageFour extends StatelessWidget {
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
        PopularMoviePage(),
        NowPlayingMoviePage(),
        UpcomingMoviePage()
      ],
    );
  }
}
