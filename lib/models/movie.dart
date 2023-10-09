class Movie {
  final String id;
  final String title;
  final String originalTitle;
  final String posterTitle;
  final String poster;
  final String description;
  final String backgroundPoster;
  final String director;
  final int year;
  final int duration;
  final double score;
  final String trailer;
  final List<String> genres;
  final List<String> gallery;

  const Movie._({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.posterTitle,
    required this.poster,
    required this.description,
    required this.backgroundPoster,
    required this.director,
    required this.year,
    required this.duration,
    required this.score,
    required this.trailer,
    required this.genres,
    required this.gallery,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie._(
      id: json['id'],
      title: json['title'],
      originalTitle: json['original_title'],
      posterTitle: json['poster_title'],
      poster: json['poster'],
      description: json['description'],
      backgroundPoster: json['background_poster'],
      director: json['director'],
      year: int.parse(json['release_year']),
      duration: int.parse(json['duration']),
      score: json['score'].toDouble(),
      trailer: json['trailer'],
      genres: json['genres'].cast<String>(),
      gallery: json['gallery'].cast<String>(),
    );
  }
}
