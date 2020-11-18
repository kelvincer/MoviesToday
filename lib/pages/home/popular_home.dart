import 'package:flutter/material.dart';
import 'package:movies_today/provider/generic_provider.dart';
import 'package:movies_today/repositories/popular_repository.dart';
import 'package:movies_today/widgets/card_swiper_widget_two.dart';
import 'package:provider/provider.dart';

class PopularMoviePage extends StatefulWidget {
  @override
  _PopularPageState createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularMoviePage>
    with AutomaticKeepAliveClientMixin {
  /* PopularProvider popularProvider =
      PopularProvider(popularMoviesRepository: PopularMoviesRepository());
 */
  GenericHomeProvider provider = GenericHomeProvider<PopularMoviesRepository>(
      repository: PopularMoviesRepository());
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
      child: Consumer<GenericHomeProvider>(
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
