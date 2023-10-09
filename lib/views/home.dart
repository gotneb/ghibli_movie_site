import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static const url =
      'https://gemootest.s3.us-east-2.amazonaws.com/s/res/514885813225336832/90c28ce7cddf057bd0dbdc1cf19ad968.mp4?X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARLZICB6QQHKRCV7K%2F20231009%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20231009T151630Z&X-Amz-SignedHeaders=host&X-Amz-Expires=7200&X-Amz-Signature=d25263d35750b61ab43782c8b6147ba6f068c11ee560eeda6ad047c257b615a0';

  VideoPlayerController? videoController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayers();
  }

  Future<void> initializePlayers() async {
    videoController = VideoPlayerController.networkUrl(Uri.parse(url));
    await videoController!.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoController!,
      showControls: false,
      aspectRatio: 16 / 9,
      fullScreenByDefault: true,
      allowFullScreen: true,
      //autoPlay: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return chewieController != null &&
            chewieController!.videoPlayerController.value.isInitialized
        ? Stack(
            children: [
              // Video Player
              Container(
                color: Colors.blue,
                child: Chewie(controller: chewieController!),
              ),
              // Main presentation
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0.05 * screenWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    _movieBanner(screenWidth, screenHeight),
                    const Spacer(),
                    const Text('You Might Like'),
                    const SizedBox(height: 20),
                    _buildListMovies(screenWidth, screenHeight),
                  ],
                ),
              ),
            ],
          )
        : const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Loading'),
            ],
          );
  }

  Widget _movieBanner(double screenWidth, double screenHeight) {
    return Container(
      color: Colors.red,
      width: 0.4 * screenWidth,
      height: 0.44 * screenHeight,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Image.network(
            'https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/LmEnxtiAuzezXBjYXPuDgfZ4zZQ/AAAABWWyvMGriEaB0oV3gVDqqsKI7-I5VmkJXqbF0LwN1_f003lJFZmTAdaYJxcXDTKp-rKaEptUNgvLckaPC9S259j5yI-gVhlfJu3yZ4_vZcAy.png?r=9dc',
            height: 0.2 * screenHeight),
        Text('耳をすませば (Whisper of Hearts)'),
        Text('2017 | 1h 51min | Romance / Drama / Anime'),
        const Text(
            "Shizuku lives a simple life, dominated by her love for stories and writing. One day she notices that all the library books she has have been previously checked out by the same person: 'Seiji Amasawa'."),
        SizedBox(
          width: 0.1 * screenWidth,
          child: ElevatedButton(
            onPressed: () {},
            child: Row(children: [
              Icon(Icons.play_arrow_rounded),
              Text('Watch'),
            ],),
          ),
        ),
      ]),
    );
  }

  Widget _buildListMovies(double screenWidth, double screenHeight) {
    return Container(
      width: .9 * screenWidth,
      height: .25 * screenHeight,
      color: Colors.white,
    );
  }

  @override
  void dispose() {
    videoController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }
}
