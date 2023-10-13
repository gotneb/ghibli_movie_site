import 'package:flutter/material.dart';
import 'package:ghibli_movie_site/models/movie.dart';
import 'package:ghibli_movie_site/services/api.dart';
import 'package:ghibli_movie_site/styles.dart';

class SearchView extends StatelessWidget {
  const SearchView({
    super.key,
    required this.searchTerm,
  });

  final String searchTerm;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Api.search(titleMovie: searchTerm),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://i.pinimg.com/originals/ab/5d/39/ab5d39528bbe450927c3f07edc37c95c.png',
                      width: 0.1 * MediaQuery.sizeOf(context).width,
                    ),
                    const SizedBox(height: 12),
                    Text('Movie not found', style: CustomStyle.listText)
                  ]),
            );
          }
          return _buildResults(context, movies: snapshot.data!);
        }
        return const Center(
            child: SizedBox(
          child: CircularProgressIndicator(),
        ));
      },
    );
  }

  Widget _buildResults(BuildContext context, {required List<Movie> movies}) {
    return Container(
      //color: const Color(0xFF202020),
      margin: EdgeInsets.only(
        top: 0.04 * MediaQuery.sizeOf(context).height,
        bottom: 0.04 * MediaQuery.sizeOf(context).height,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: 0.04 * MediaQuery.sizeOf(context).width),
      width: MediaQuery.sizeOf(context).width,
      child: GridView.count(
        childAspectRatio: 9 / 14,
        crossAxisCount: 4,
        mainAxisSpacing: 0.05 * MediaQuery.sizeOf(context).height,
        crossAxisSpacing: 0.05 * MediaQuery.sizeOf(context).height,
        children:
            movies.map((movie) => _buildBanner(context, movie: movie)).toList(),
      ),
    );
  }

  Widget _buildBanner(BuildContext context, {required Movie movie}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Image.network(movie.poster, fit: BoxFit.fill),
    );
  }
}
