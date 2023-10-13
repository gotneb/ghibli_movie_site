import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ghibli_movie_site/models/movie.dart';
import 'package:ghibli_movie_site/views/movie_detail.dart';

class SmallMovieBanner extends StatefulWidget {
  const SmallMovieBanner({super.key, required this.movie});

  final Movie movie;

  @override
  State<SmallMovieBanner> createState() => _SmallMovieBannerState();
}

class _SmallMovieBannerState extends State<SmallMovieBanner> {
  static const maxScale = 1.3;
  static const normalScale = 1.0;

  static const onEnterCurve = Curves.easeOutExpo;
  static const onExitCurve = Curves.slowMiddle;

  Curve curve = onEnterCurve;
  double scale = 1.0;
  double padding = 0.0;

  bool isInside = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _loadMovieScreen,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: EdgeInsets.symmetric(horizontal: isInside ? 30 : 0),
        decoration: BoxDecoration(
          border: Border.all(
            color: !isInside ? Colors.white : Colors.transparent,
            width: !isInside ? 2 : 0,
          ),
        ),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(seconds: 1),
          curve: curve,
          child: MouseRegion(
            cursor:
                isInside ? SystemMouseCursors.click : SystemMouseCursors.basic,
            onEnter: onEnter,
            onExit: onExit,
            child: AspectRatio(
              aspectRatio: 12 / 7,
              child: Image.network(widget.movie.alternativePoster, fit: BoxFit.fitHeight),
            ),
          ),
        ),
      ),
    );
  }

  void onEnter(PointerEnterEvent event) {
    setState(() {
      isInside = true;
      scale = scale == normalScale ? maxScale : normalScale;
      curve = curve == onEnterCurve ? onEnterCurve : onExitCurve;
      padding = padding == 0.0 ? 30.0 : 0.0;
    });
  }

  void onExit(PointerExitEvent event) {
    setState(() {
      isInside = false;
      scale = scale == normalScale ? maxScale : normalScale;
      curve = curve == onEnterCurve ? onEnterCurve : onExitCurve;
      padding = padding == 0.0 ? 0.0 : 0.0;
    });
  }

  void _loadMovieScreen() {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MovieDetail(movie: widget.movie)),
  );
  }
}
