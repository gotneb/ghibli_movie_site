import 'package:flutter/material.dart';
import 'package:ghibli_movie_site/components/search_field.dart';
import 'package:ghibli_movie_site/components/small_movie_banner.dart';
import 'package:ghibli_movie_site/custom_widgets/custom_scroll.dart';
import 'package:ghibli_movie_site/models/movie.dart';
import 'package:ghibli_movie_site/services/api.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import 'package:ghibli_movie_site/styles.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const searchHeight = 65.0;
  static const mainContentRatio = 0.8;
  static const sideContentRatio = 0.2;
  static const trailerRatio = 0.65;

  static const blackColor = Color(0xFF0D0D0D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadData(context),
    );
  }

  Widget _loadData(BuildContext context) {
    const loadingScreen = Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator(), Text('Loading')]),
    );

    return FutureBuilder(
      future: Api.search(titleMovie: 'whisper'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildBody(context, topMovie: snapshot.data![0]);
        }
        return loadingScreen;
      },
    );
  }

  Widget _buildBody(BuildContext context, {required Movie topMovie}) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    final blackGradient = Container(
      width: screenWidth,
      height: mainContentRatio * screenHeight,
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: blackColor),
        color: blackColor,
        gradient: const LinearGradient(
            colors: [blackColor, Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            stops: [.35, .6]),
      ),
    );

    final mainContent = Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.04 * screenWidth),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMovieBanner(topMovie,
                width: screenWidth, height: screenHeight)
          ]),
    );

    final trailer = Align(
      alignment: Alignment.centerRight,
      child: _buildVideo(context, movie: topMovie),
    );

    return ListView(children: [
      _buildTextBox(context),
      SizedBox(
        width: screenWidth,
        height: mainContentRatio * screenHeight,
        child: Stack(children: [
          trailer,
          blackGradient,
          mainContent,
        ]),
      ),
      // List of others movies
      _buildMoviesList(context),
    ]);
  }

  Widget _buildTextBox(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.symmetric(
          horizontal: 0.04 * MediaQuery.sizeOf(context).width, vertical: 12),
      height: searchHeight,
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: blackColor),
        color: blackColor,
      ),
      child: const SearchField(),
    );
  }

  Widget _buildMovieBanner(Movie movie, {required width, required height}) {
    final stars = SmoothStarRating(
      allowHalfRating: true,
      onRatingChanged: (_) {},
      starCount: 5,
      rating: movie.score / 2,
      size: 20.0,
      filledIconData: Icons.star_rounded,
      halfFilledIconData: Icons.star_half_rounded,
      color: Colors.white,
      borderColor: Colors.white,
      spacing: 2.0,
    );

    return SizedBox(
      width: 0.35 * width,
      height: 0.55 * height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            movie.posterTitle,
            fit: BoxFit.fitWidth,
            height: 0.2 * height,
          ),
          const SizedBox(height: 24),
          stars,
          const SizedBox(height: 8),
          Text(
            '${movie.title} / ${movie.originalTitle}',
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
            maxLines: 4,
          )),
          const SizedBox(height: 24),
          FittedBox(
            child: ElevatedButton(
              onPressed: () {},
              style: CustomStyle.mainButtonStyle,
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.play_arrow_rounded, size: 32),
                    SizedBox(width: 12),
                    Text('WATCH', style: CustomStyle.buttonText),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoviesList(BuildContext context) {
    final movies = ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        separatorBuilder: (context, index) =>
            SizedBox(width: 0.02 * MediaQuery.sizeOf(context).width),
        itemBuilder: (context, index) => const SmallMovieBanner(),
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 0.04 * MediaQuery.sizeOf(context).width),
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: blackColor),
        color: blackColor,
      ),
      width: MediaQuery.sizeOf(context).width,
      //height: sideContentRatio * MediaQuery.sizeOf(context).height,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [
          Text('You might like', style: CustomStyle.listText),
          Icon(Icons.chevron_right_sharp, color: Colors.white, size: 32),
        ]),
        const SizedBox(height: 16),
        SizedBox(
          height: sideContentRatio * MediaQuery.sizeOf(context).height,
          child: movies,
        ),
        const SizedBox(height: 16),
      ]),
    );
  }

  Widget _buildVideo(BuildContext context, {required Movie movie}) {
    return Image.network(
      movie.backgroundPoster,
      fit: BoxFit.fill,
      width: trailerRatio * MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
    );
  }
}
