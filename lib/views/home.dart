import 'package:flutter/material.dart';
import 'package:ghibli_movie_site/components/horizontal_movie_panel.dart';
import 'package:ghibli_movie_site/components/main_content.dart';
import 'package:ghibli_movie_site/components/search_field.dart';
import 'package:ghibli_movie_site/models/movie.dart';
import 'package:ghibli_movie_site/services/api.dart';
import 'package:ghibli_movie_site/views/search.dart';
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

  var showTrailer = false;
  var movies = <Movie>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomStyle.blackColor,
        leading: IconButton(
          onPressed: () => setState(() {
            hasSearched = false;
          }),
          icon: const Icon(Icons.home_rounded,
              size: 32, color: CustomStyle.primaryColor),
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

    if (showTrailer) {
      return _buildBody(context);
    }

    return FutureBuilder(
      // I know loading all cost a lot...
      // But I'm too lazy to implement a new route for the api ;)
      future: Api.all(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          movies = snapshot.data!;
          movies.shuffle();
          return _buildBody(context);
        }
        return loadingScreen;
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(children: [
      const SizedBox(height: 8),
      MainContent(
        ratio: HomeView.mainContentRatio,
        movie: movies[0],
        trailerRatio: HomeView.trailerRatio,
      ),
      // List of others movies
      HorizontalMoviePanel(
        ratio: HomeView.sideContentRatio,
        movies: movies.getRange(1, 6).toList(),
      ),
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

  void onSubmitted(String searchTerm) {
    setState(() {
      hasSearched = true;
      searchContent = SearchView(searchTerm: searchTerm);
    });
  }
}
