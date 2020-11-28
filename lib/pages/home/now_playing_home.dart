import 'package:flutter/material.dart';
import 'package:movies_today/provider/home_provider.dart';
import 'package:movies_today/repositories/now_playing_repository.dart';
import 'package:movies_today/widgets/card_swiper_widget_two.dart';
import 'package:provider/provider.dart';

class NowPlayingMoviePage extends StatefulWidget {
  @override
  _NowPlayingMoviePageState createState() => _NowPlayingMoviePageState();
}

class _NowPlayingMoviePageState extends State<NowPlayingMoviePage>
    with AutomaticKeepAliveClientMixin {
  /* NowPlayingProvider provider =
      NowPlayingProvider(nowPlayingRepository: NowPlayingRepository());
 */

  HomeProvider provider = HomeProvider<NowPlayingRepository>(repository: NowPlayingRepository());

  @override
  void initState() {
    super.initState();
    provider.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("now playing");
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
                child: CardSwiper(provider: provider),
              );
            }
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
