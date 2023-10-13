import 'package:flutter/material.dart';
import 'package:ghibli_movie_site/components/horizontal_movie_panel.dart';
import 'package:ghibli_movie_site/components/search_field.dart';
import 'package:ghibli_movie_site/models/movie.dart';
import 'package:ghibli_movie_site/services/api.dart';
import 'package:ghibli_movie_site/views/movie_detail.dart';
import 'package:ghibli_movie_site/views/search.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import 'package:ghibli_movie_site/styles.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const searchHeight = 65.0;
  static const mainContentRatio = 0.8;
  static const sideContentRatio = 0.2;
  static const trailerRatio = 0.65;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var hasSearched = false;
  Widget searchContent = const Placeholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomStyle.blackColor,
        leading: IconButton(
          onPressed: () => setState(() {
            hasSearched = false;
          }),
          icon: const Icon(Icons.home_rounded, size: 32, color: CustomStyle.primaryColor),
        ),
        title: _buildTextBox(context),
        titleSpacing: 0,
      ),
      backgroundColor: CustomStyle.blackColor,
      body: hasSearched ? searchContent : loadMainScreen(context),
      // body: SearchView(searchTerm: 'whisper'),
    );
  }

  Widget loadMainScreen(BuildContext context) {
    const loadingScreen = Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator()]),
    );

    return FutureBuilder(
      future: Api.random(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildBody(context, topMovie: snapshot.data!);
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
      height: HomeView.mainContentRatio * screenHeight,
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
      const SizedBox(height: 8),
      SizedBox(
        width: screenWidth,
        height: HomeView.mainContentRatio * screenHeight,
        child: Stack(children: [
          trailer,
          blackGradient,
          mainContent,
        ]),
      ),
      // List of others movies
      const HorizontalMoviePanel(ratio: HomeView.sideContentRatio),
    ]);
  }

  Widget _buildTextBox(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.fromLTRB(
          0, 12, 0.04 * MediaQuery.sizeOf(context).width, 12),
      height: HomeView.searchHeight,
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: CustomStyle.blackColor),
        color: CustomStyle.blackColor,
      ),
      child: SearchField(onSubmitted: onSubmitted),
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
          FittedBox(
            child: ElevatedButton(
              onPressed: () => _loadMovieScreen(context, movie: movie),
              style: CustomStyle.mainButtonStyle,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.play_arrow_rounded, size: 32),
                    const SizedBox(width: 12),
                    Text('Play', style: CustomStyle.buttonText),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideo(BuildContext context, {required Movie movie}) {
    return Image.network(
      movie.promotionalImage,
      fit: BoxFit.fill,
      width: HomeView.trailerRatio * MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
    );
  }

  void onSubmitted(String searchTerm) {
    setState(() {
      hasSearched = true;
      searchContent = SearchView(searchTerm: searchTerm);
    });
  }

  void _loadMovieScreen(BuildContext context, {required Movie movie}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetail(movie: movie),
        ));
  }
}
