import 'package:flutter/material.dart';
import 'package:ghibli_movie_site/components/small_movie_banner.dart';
import 'package:ghibli_movie_site/custom_widgets/custom_scroll.dart';
import 'package:ghibli_movie_site/models/movie.dart';
import 'package:ghibli_movie_site/services/api.dart';
import 'package:ghibli_movie_site/styles.dart';

class HorizontalMoviePanel extends StatelessWidget {
  const HorizontalMoviePanel({super.key, required this.ratio});

  final double ratio;

  static const blackColor = Color(0xFF0D0D0D);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Api.all(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data!;
          movies.shuffle();
          return _buildBody(context, movies: movies.getRange(0, 5).toList());
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _buildBody(BuildContext context, {required List<Movie> movies}) {
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
        Row(children: [
          Text('You might like', style: CustomStyle.listText),
          const Icon(Icons.chevron_right_sharp, color: Colors.white, size: 32),
        ]),
        const SizedBox(height: 16),
        SizedBox(
          height: ratio * MediaQuery.sizeOf(context).height,
          child: _buildListMovies(movies: movies),
        ),
        const SizedBox(height: 24),
      ]),
    );
  }

  Widget _buildListMovies({required List<Movie> movies}) {
    return ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: 0.02 * MediaQuery.sizeOf(context).width),
        itemBuilder: (context, index) => SmallMovieBanner(movie: movies[index]),
      ),
    );
  }
}
