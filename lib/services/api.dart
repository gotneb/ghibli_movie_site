import 'dart:convert';
import 'package:ghibli_movie_site/models/movie.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class Api {
  static const path = 'studio-ghibli-movies-api.onrender.com';
  static final dio = Dio();

  static Future<List<Movie>> search({required String titleMovie}) async {
    final url = '/movie/$titleMovie';
    final response = await http.get(Uri.https(path, url));

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

  static Future<Movie> findByID({required String id}) async {
    final url = '/movie/id/$id';
    final response = await http.get(Uri.https(path, url));

    // `utf8` decode is needed because japanese text is wrongly interpreted without it
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    final movie = Movie.fromJson(json);
    return movie;
  }
}
