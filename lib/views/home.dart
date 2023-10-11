import 'package:flutter/material.dart';
import 'package:ghibli_movie_site/models/movie.dart';
import 'package:ghibli_movie_site/services/api.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadData(context),
    );
  }

  Widget _loadData(BuildContext context) {
    // return Center(
    //   child: ElevatedButton(
    //     onPressed: () async {
    //       final movie = await Api.findByID(id: 'a5f2f6dbbd5a2753a4ee50434669f650ae4d5f6c742b7da63ec502372f340b97');
    //       print(movie.title);
    //     },
    //     child: Text('Hi'),
    //   ),
    // );

    const loadingScreen = Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator(), Text('Loading')]),
    );

    return FutureBuilder(
      future: Api.findByID(
          id: '74110f0e3c7e847150907204a213de2d173c9fbac8535660c4669fb710ee580e'),
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
      height: .75 * screenHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.black, Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            stops: [.25, 1]),
      ),
    );

    return Column(children: [
      Container(
        color: Colors.red,
        width: screenWidth,
        height: .75 * screenHeight,
        child: Stack(children: [
          // Video player
          Align(
            alignment: Alignment.centerRight,
            child: _buildVideo(context, movie: topMovie),
          ),
          // Gradient
          blackGradient,
          // Main content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.04 * screenWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextBox(context),
                const Spacer(),
                _buildMovieBanner(topMovie,
                    width: screenWidth, height: screenHeight),
                const Spacer(),
              ],
            ),
          ),
        ]),
      ),
      // List of others movies
      Container(
        color: Colors.green,
        width: screenWidth,
        height: .25 * screenHeight,
      ),
    ]);
  }

  Widget _buildTextBox(BuildContext context) {
    return Container(
      color: Colors.blue,
      margin: EdgeInsets.only(top: 0.04 * MediaQuery.sizeOf(context).height),
      width: MediaQuery.sizeOf(context).width,
      height: 50,
    );
  }

  Widget _buildMovieBanner(Movie movie, {required width, required height}) {
    return Container(
      color: Colors.red,
      width: 0.3 * width,
      height: 0.4 * height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(movie.posterTitle),
          const SizedBox(height: 16),
          Text('${movie.title} / ${movie.originalTitle}'),
          const SizedBox(height: 8),
          Text(
              '${movie.year} | ${movie.formatedHour} | ${movie.formatedGenres}'),
          const SizedBox(height: 8),
          Flexible(
              child: Text(
            movie.description,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          )),
          const SizedBox(height: 16),
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Icon(Icons.play_arrow), Text('Watch')]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideo(BuildContext context, {required Movie movie}) {
    return Image.network(
      movie.backgroundPoster,
      fit: BoxFit.fill,
      width: .8 * MediaQuery.sizeOf(context).width,
    );
  }
}
