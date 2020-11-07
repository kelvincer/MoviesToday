import 'package:movies_today/models/detail/movie_credit.dart';

String joinNames(List<Cast> casts) {
  final lst = List();
  casts.forEach((element) {
    lst.add(element.name);
  });

  String s = lst.join(', ');
  return s;
}
