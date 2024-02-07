// Create stateful videoplayer widget with given url

import 'dart:developer';

import 'package:fiteens/src/util/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class VideoPlayerElement extends StatefulWidget{
  final String url;
  final bool autoplay;
  final bool loop;

  const VideoPlayerElement({required this.url, this.autoplay = true, this.loop = false, super.key});

  @override
  VideoPlayerElementState createState() => VideoPlayerElementState();

}
class VideoPlayerElementState extends State<VideoPlayerElement> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(widget.url
      ),
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(kDebugMode){
      log('video player element build for video ${widget.url}');
    }
  return PodVideoPlayer(controller: controller);


  }
}