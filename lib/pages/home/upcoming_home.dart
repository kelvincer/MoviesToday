import 'package:flutter/material.dart';
import 'package:movies_today/provider/home_provider.dart';
import 'package:movies_today/repositories/upcoming_repository.dart';
import 'package:movies_today/widgets/card_swiper_widget_two.dart';
import 'package:provider/provider.dart';

class UpcomingMoviePage extends StatefulWidget {
  @override
  _UpcomingMoviePageState createState() => _UpcomingMoviePageState();
}

class _UpcomingMoviePageState extends State<UpcomingMoviePage>
    with AutomaticKeepAliveClientMixin {
  /* UpcomingProvider upcomingProvider =
      UpcomingProvider(upcomingRepository: UpcomingRepository()); */

  HomeProvider provider = HomeProvider<UpcomingRepository>(
      repository: UpcomingRepository());

  @override
  void initState() {
    super.initState();
    provider.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider.value(
      value: provider,
      child: Consumer<HomeProvider>(
        builder: (context, model, child) {
          if (model.populares.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              color: Colors.green,
              child: CardSwiper(provider: model),
            );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
