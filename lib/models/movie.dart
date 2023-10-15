class Movie {
  final String id;
  final String title;
  final String alternativeTitle;
  final String originalTitle;
  final String titleImage;
  final String poster;
  final String alternativePoster;
  final String description;
  final String promotionalImage;
  final String director;
  final int year;
  final int duration;
  final double score;
  final String ageIndication;
  final String trailer;
  final List<String> genres;
  final List<String> gallery;

  const Movie._({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.alternativeTitle,
    required this.titleImage,
    required this.poster,
    required this.alternativePoster,
    required this.description,
    required this.promotionalImage,
    required this.director,
    required this.year,
    required this.duration,
    required this.ageIndication,
    required this.score,
    required this.trailer,
    required this.genres,
    required this.gallery,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final gallery = json['gallery'].cast<String>();
    // Lets things more `dynamic`
    gallery.shuffle();

    return Movie._(
      id: json['id'],
      title: json['title'],
      alternativeTitle: json['alternative_title'],
      originalTitle: json['original_title'],
      titleImage: json['title_image'],
      poster: json['poster'],
      alternativePoster: json['alternative_poster'],
      description: json['description'],
      promotionalImage: json['promotional_image'],
      director: json['director'],
      ageIndication: json['mpaa'],
      year: json['release_year'].toInt(),
      duration: json['duration'].toInt(),
      score: json['score'].toDouble(),
      trailer: json['trailer'],
      genres: json['genres'].cast<String>(),
      gallery: gallery,
    );
  }

  @override
  String toString() => title;

  String get formatedHour {
    final hours = duration ~/60;
    int minutes = duration % 60;
    return '${hours}h ${minutes}m';
  }

  String get formatedGenres {
    return genres.join('/');
  }
}
