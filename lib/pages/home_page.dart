import 'package:flutter/material.dart';
import 'package:movies_today/blocs/home_bloc.dart';
import 'package:movies_today/blocs/home_bloc_provider.dart';
import 'package:movies_today/repositories/movie_repository.dart';
import 'package:movies_today/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieRepository = MovieRepository();
    final homeBloc = HomeBloc(movieRepository: movieRepository);

    return HomeBlocProvider(
      homeBloc: homeBloc,
      child: StreamBuilder(
        initialData: null,
        stream: homeBloc.movies,
        builder: (context, snapshot) {
          if ( snapshot.hasData ) {
          return CardSwiper( movies: snapshot.data );
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
        },
      ),
    );
  }
}
