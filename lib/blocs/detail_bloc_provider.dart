import 'package:flutter/material.dart';
import 'package:movies_today/blocs/detail_bloc.dart';


class DetailBlocProvider extends InheritedWidget {
  
  final DetailBloc detailBloc;
  
  const DetailBlocProvider(
      {Key key, Widget child, this.detailBloc})
      : super(key: key, child: child);
   
  @override
  bool updateShouldNotify(DetailBlocProvider old) => detailBloc != old.detailBloc;

}