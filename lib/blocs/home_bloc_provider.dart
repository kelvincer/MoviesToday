

import 'package:flutter/material.dart';
import 'package:movies_today/blocs/home_bloc.dart';

class HomeBlocProvider extends InheritedWidget {
  
  final HomeBloc homeBloc;
  
  const HomeBlocProvider(
      {Key key, Widget child, this.homeBloc})
      : super(key: key, child: child);
   
  @override
  bool updateShouldNotify(HomeBlocProvider old) => homeBloc != old.homeBloc;

}