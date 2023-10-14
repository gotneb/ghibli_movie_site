import 'package:flutter/material.dart';
import 'package:ghibli_movie_site/models/movie.dart';
import 'package:ghibli_movie_site/styles.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class IframeMovie extends StatefulWidget {
  const IframeMovie({
    super.key,
    required this.movie,
    required this.ratio,
    required this.showTrailer,
  });

  final Movie movie;
  final bool showTrailer;
  final double ratio;

  @override
  State<IframeMovie> createState() => IframeMovieState();
}

class IframeMovieState extends State<IframeMovie> {
  late final YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController.fromVideoId(
      autoPlay: true,
      videoId: getVideoID(widget.movie),
      params: const YoutubePlayerParams(
        mute: false,
        showControls: false,
        showFullscreenButton: false,
        pointerEvents: PointerEvents.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var player = YoutubePlayer(
      controller: controller,
      aspectRatio: 5 / 2,
    );

    final videoBox = SizedBox(
      //color: Colors.red,
      width: widget.ratio * MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: player,
    );

    final image = Image.network(
      widget.movie.promotionalImage,
      fit: BoxFit.fill,
      width: widget.ratio * MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
    );

    final radialGrad = Container(
      width: widget.ratio * MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.1, 0.0), // near the top right
          radius: 0.7,
          colors: <Color>[
            Colors.transparent, // yellow sun
            CustomStyle.blackColor, // blue sky
          ],
          stops: [0.8, 1.0],
        ),
      ),
    );

    return SizedBox(
        width: widget.ratio * MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Stack(children: [
          if (widget.showTrailer) ...[videoBox, radialGrad] else ...[image]
        ]));
  }

  String getVideoID(Movie movie) => movie.trailer.split('/').last;
}
