import 'dart:convert';
import 'package:ghibli_movie_site/models/movie.dart';
import 'package:http/http.dart' as http;

class Api {
  static const path = 'studio-ghibli-movies-api.onrender.com';

  static Future<List<Movie>> search({required String titleMovie}) async {
    final url = '/movies/search/$titleMovie';
    final response = await http.get(Uri.https(path, url));

    final List<Movie> movies = [];
    if (response.statusCode != 200) { return movies; }

    List<dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));

    for (var data in json) {
      try {
        final movie = Movie.fromJson(data);
        movies.add(movie);
      } catch (e) {
        print('Error while processing movie: $e');
      }
    }
    return movies;
  }

  static Future<Movie> findByID({required String id}) async {
    final url = '/movies/get/$id';
    final response = await http.get(Uri.https(path, url));

    // `utf8` decode is needed because japanese text is wrongly interpreted without it
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    final movie = Movie.fromJson(json);
    return movie;
  }

  static Future<Movie> random() async {
    final response = await http.get(Uri.https(path, '/movies/random'));

    // `utf8` decode is needed because japanese text is wrongly interpreted without it
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    final movie = Movie.fromJson(json);
    return movie;
  }

  static Future<List<Movie>> all() async {
    final response = await http.get(Uri.https(path, '/movies/all'));
    List<dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));

    final List<Movie> movies = [];
    for (var data in json) {
      try {
        final movie = Movie.fromJson(data);
        movies.add(movie);
      } catch (e) {
        print('Error while processing movie: $e');
      }
    }

    return movies;
  }
}
