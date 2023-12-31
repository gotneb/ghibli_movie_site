import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ghibli_movie_site/components/footer.dart';
import 'package:ghibli_movie_site/models/movie.dart';
import 'package:ghibli_movie_site/styles.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final extraSpace = ImagePixels(
      imageProvider: NetworkImage(movie.promotionalImage),
      builder: (_, img) {
        if (img.hasImage) {
          return Container(
            height: 80,
            color: img.pixelColorAtAlignment!(Alignment.bottomCenter)
          );
        }
        return const Placeholder();
      },
    );

    return Scaffold(
      body: ListView(
        children: [
          Stack(children: [
            _buildBackgroundImage(context),
            _buildMainContent(context),
          ]),
          _buildGallery(context),
          extraSpace,
          Footer(movie: movie),
        ],
      ),
    );
  }

  Widget _buildGallery(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    final gallery = movie.gallery.map((img) {
      return Material(
        elevation: 12,
        child: Image.network(img, fit: BoxFit.fill),
      );
    }).toList();

    final gridGallery = GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 12 / 7,
      mainAxisSpacing: 0.01 * width,
      crossAxisSpacing: 0.01 * width,
      children: gallery,
    );

    final padding = 0.04 * width;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          ImagePixels(
            imageProvider: NetworkImage(movie.promotionalImage),
            builder: (context, img) {
              return Container(
                width: width,
                height: height,
                color: loadImgColor(img),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(padding, 0, padding, 20),
            child: gridGallery,
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    final padding = 0.04 * width;

    final title = Image.network(
      movie.titleImage,
      width: 0.3 * width,
      fit: BoxFit.fitWidth,
    );

    final poster = Material(
      elevation: 12,
      borderRadius: BorderRadius.circular(12),
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child:
            Image.network(movie.poster, height: 0.3 * height, fit: BoxFit.fill),
      ),
    );

    final genresBox = movie.genres
        .map((genre) => Container(
              margin: EdgeInsets.only(right: 0.01 * width),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: const ShapeDecoration(
                shape: StadiumBorder(side: BorderSide(color: Colors.white)),
              ),
              child: Text(genre, style: CustomStyle.description2),
            ))
        .toList();

    final about = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(movie.title, style: CustomStyle.movieTitle2),
          const SizedBox(height: 8),
          SizedBox(
            width: 0.35 * width,
            child: Text(movie.description, style: CustomStyle.description2),
          ),
          const SizedBox(height: 12),
          Row(children: genresBox),
        ]);

    final rating = SizedBox(
      width: 0.1 * width,
      height: 0.1 * width,
      child: Stack(
        children: [
          SizedBox(
            width: 0.1 * width,
            height: 0.1 * width,
            child: SimpleCircularProgressBar(
              size: 0.1 * width,
              backStrokeWidth: 12,
              progressStrokeWidth: 18,
              backColor: Colors.grey[850]!,
              animationDuration: 6,
              maxValue: 10.0,
              progressColors: const [Colors.yellow],
              valueNotifier: ValueNotifier<double>(movie.score),
            ),
          ),
          Center(
              child: Text(
            (movie.score).toStringAsFixed(1),
            style: CustomStyle.ratingText,
          )),
        ],
      ),
    );

    const time = Duration(milliseconds: 2000);
    final galleryText = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: width),
          Text('GALLERY', style: CustomStyle.galleryText),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white,
          ),
        ]
            .animate(
              onPlay: (controller) => controller.repeat(),
            )
            .moveY(begin: 0, end: -16, duration: time, curve: Curves.ease));

    return Container(
      padding: EdgeInsets.fromLTRB(padding, 0, 0, 12),
      width: width,
      height: height,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            const SizedBox(height: 24),
            Text(
              '${movie.year} | ${movie.ageIndication} | ${movie.formatedHour}',
              style: CustomStyle.description2,
            ),
            const SizedBox(height: 16),
            Text(
              '${movie.originalTitle} (${movie.alternativeTitle})',
              style: CustomStyle.movieTitle3,
            ),
            const SizedBox(height: 4),
            Container(width: width, height: 1, color: Colors.grey),
            const SizedBox(height: 32),
            Row(children: [
              poster,
              SizedBox(width: 0.02 * width),
              about,
              const Spacer(),
              rating,
              const Spacer(),
            ]),
            galleryText,
          ]),
    );
  }

  Widget _buildBackgroundImage(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    final image = Image.network(
      movie.promotionalImage,
      fit: BoxFit.fill,
      width: width,
      height: height,
    );

    gradient(ImgDetails img) => LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            loadImgColor(img),
            Colors.transparent,
          ],
          stops: const [.1, 1],
        );

    return SizedBox(
      width: width,
      height: height,
      child: Stack(children: [
        image,
        Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 0.7 * height,
              child: ImagePixels(
                  imageProvider: NetworkImage(movie.promotionalImage),
                  builder: (context, img) {
                    return Container(
                        decoration: BoxDecoration(gradient: gradient(img)));
                  }),
            ))
      ]),
    );
  }

  Color loadImgColor(ImgDetails img) {
    return img.hasImage
        ? img.pixelColorAtAlignment!(Alignment.bottomCenter)
        : Colors.transparent;
  }
}
