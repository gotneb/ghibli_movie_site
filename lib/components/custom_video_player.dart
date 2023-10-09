import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({super.key});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
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
    return chewieController != null &&
            chewieController!.videoPlayerController.value.isInitialized
        ? Chewie(controller: chewieController!)
        : const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Loading'),
            ],
          );
  }

  @override
  void dispose() {
    videoController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }
}
