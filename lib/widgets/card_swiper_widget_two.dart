import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_today/models/movie_model.dart';
import 'package:movies_today/provider/home_provider.dart';

class CardSwiper extends StatelessWidget {
  final HomeProvider provider;

  CardSwiper({this.provider});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final List<Movie> movies = provider.populares;
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Swiper(
            layout: SwiperLayout.STACK,
            itemWidth: _screenSize.width * 1,
            itemHeight: _screenSize.height * 1,
            itemBuilder: (BuildContext context, int index) {
              movies[index].uniqueId = '${movies[index].id}-tarjeta-${provider.getPrefix()}';

              return Hero(
                tag: movies[index].uniqueId,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: GestureDetector(
                      /* onTap: () => Navigator.pushNamed(context, 'detalle',
                            arguments: movies[index]), */
                      child: FadeInImage(
                        image: NetworkImage(movies[index].getPosterImg()),
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        fit: BoxFit.cover,
                        fadeInDuration: Duration(milliseconds: 200),
                      ),
                    )),
              );
            },
            itemCount: movies.length,
            // pagination: new Swipe

            //control: new SwiperControl(),
            onIndexChanged: (index) {
              provider.setTitle(index);
            },
            onTap: (index) => Navigator.pushNamed(context, 'detalle',
                arguments: movies[index]),
          ),
          Align(alignment: Alignment.bottomCenter, child: _builChild(context)),
        ],
      ),
    );
  }

  Widget _builChild(BuildContext context) {
    if (provider.title.isNotEmpty) {
      return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Text(
          provider.title,
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
    } else {
      return Container();
    }
  }
}
