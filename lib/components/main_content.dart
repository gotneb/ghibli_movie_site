import 'package:flutter/material.dart';
import 'package:ghibli_movie_site/components/iframe_movie.dart';
import 'package:ghibli_movie_site/models/movie.dart';
import 'package:ghibli_movie_site/styles.dart';
import 'package:ghibli_movie_site/views/movie_detail.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class MainContent extends StatefulWidget {
  const MainContent({
    super.key,
    required this.ratio,
    required this.movie,
    required this.trailerRatio,
  });

  final double ratio;
  final double trailerRatio;
  final Movie movie;

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  var showTrailer = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    final blackGradient = Container(
      width: screenWidth,
      height: widget.ratio * screenHeight,
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: CustomStyle.blackColor),
        color: CustomStyle.blackColor,
        gradient: const LinearGradient(
            colors: [CustomStyle.blackColor, Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            stops: [.35, .6]),
      ),
    );

    final trailer = Align(
      alignment: Alignment.centerRight,
      child: _buildVideo(context, movie: widget.movie),
    );

    final mainContent = Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.04 * screenWidth),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMovieBanner(widget.movie,
                width: screenWidth, height: screenHeight)
          ]),
    );

    return SizedBox(
      width: screenWidth,
      height: widget.ratio * screenHeight,
      child: Stack(children: [trailer, blackGradient, mainContent]),
    );
  }

  Widget _buildMovieBanner(Movie movie, {required width, required height}) {
    final stars = SmoothStarRating(
      allowHalfRating: true,
      onRatingChanged: (_) {},
      starCount: 5,
      rating: movie.score / 2,
      size: 24.0,
      filledIconData: Icons.star_rounded,
      halfFilledIconData: Icons.star_half_rounded,
      color: CustomStyle.primaryColor,
      borderColor: CustomStyle.primaryColor,
      spacing: 2.0,
    );

    final playButton = FittedBox(
      child: ElevatedButton(
        onPressed: () => _loadMovieScreen(context, movie: movie),
        style: CustomStyle.mainButtonStyle,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Icon(Icons.play_arrow_rounded, size: 32),
          const SizedBox(width: 12),
          Text('Play', style: CustomStyle.buttonText),
        ]),
      ),
    );

    final tarilerButton = FittedBox(
      child: ElevatedButton(
        onPressed: () => setState(() {
          showTrailer = true;
        }),
        style: CustomStyle.mainButtonStyle2,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Icon(Icons.theaters_rounded, size: 32),
          const SizedBox(width: 12),
          Text('Trailer', style: CustomStyle.buttonText),
        ]),
      ),
    );

    return SizedBox(
      width: 0.37 * width,
      height: 0.55 * height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            movie.titleImage,
            fit: BoxFit.fitWidth,
            height: 0.2 * height,
          ),
          const SizedBox(height: 24),
          stars,
          const SizedBox(height: 8),
          Text(
            '${movie.originalTitle} (${movie.alternativeTitle})',
            style: CustomStyle.movieTitle,
          ),
          const SizedBox(height: 8),
          Text(
            '${movie.year} | ${movie.formatedHour} | ${movie.formatedGenres}',
            style: CustomStyle.normalText,
          ),
          const SizedBox(height: 24),
          Flexible(
              child: Text(
            movie.description,
            style: CustomStyle.description,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )),
          const SizedBox(height: 24),
          Row(children: [playButton, SizedBox(width: 0.02 * width), tarilerButton]),
        ],
      ),
    );
  }

  Widget _buildVideo(BuildContext context, {required Movie movie}) {
    return IframeMovie(
      ratio: widget.trailerRatio,
      showTrailer: showTrailer,
      movie: movie,
    );
  }

  void _loadMovieScreen(BuildContext context, {required Movie movie}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetail(movie: movie),
        ));
  }
}
