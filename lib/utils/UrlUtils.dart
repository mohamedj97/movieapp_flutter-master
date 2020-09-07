import 'package:url_launcher/url_launcher.dart';

class UrlUtils {
  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchImdb(String imdbID) async {
    String url = 'https://www.imdb.com/title/$imdbID';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchYouTube(String videoID) async {
    String url = 'https://www.youtube.com/watch?v=$videoID';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
