import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_today/blocs/home_bloc.dart';
import 'package:movies_today/blocs/home_bloc_provider.dart';

class CardSwiper extends StatelessWidget {
  final HomeBloc bloc;

  CardSwiper({this.bloc});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      //padding: EdgeInsets.all(10.0),
      child: Stack(
        children: [
          HomeBlocProvider(
            homeBloc: bloc,
            child: StreamBuilder(
              stream: bloc.movies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var movies = snapshot.data;
                  return Swiper(
                    layout: SwiperLayout.STACK,
                    itemWidth: _screenSize.width * 1,
                    itemHeight: _screenSize.height * 1,
                    itemBuilder: (BuildContext context, int index) {
                      movies[index].uniqueId = '${movies[index].id}-tarjeta';

                      return Hero(
                        tag: movies[index].uniqueId,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: GestureDetector(
                              /* onTap: () => Navigator.pushNamed(context, 'detalle',
                            arguments: movies[index]), */
                              child: FadeInImage(
                                image:
                                    NetworkImage(movies[index].getPosterImg()),
                                placeholder:
                                    AssetImage('assets/img/no-image.jpg'),
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
                      bloc.setTitle(index);
                    },
                  );
                }

                return Container();
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: HomeBlocProvider(
              homeBloc: bloc,
              child: StreamBuilder(
                stream: bloc.title,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final title = snapshot.data;
                    return Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                    
                      ),
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
          )
        ],
      ),
    );
  }
}
