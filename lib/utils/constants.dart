import 'package:url_launcher/url_launcher.dart';

const String apikey = '6435183fc8e829478cb5f8539efd1e71';
const String url = 'api.themoviedb.org';
const String language = 'de-DE';

launchURL(String videoId) async {
  String url = "https://www.youtube.com/watch?v={$videoId}";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
