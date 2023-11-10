import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShowVideos extends StatefulWidget {
  final List<dynamic>? output;

  const ShowVideos({Key? key, required this.output}) : super(key: key);

  @override
  State<ShowVideos> createState() => _ShowVideosState();
}

class _ShowVideosState extends State<ShowVideos> {
  late YoutubePlayerController _controller;
  Map<String, String> emotionToVideo = {
    'Happy': 'https://www.youtube.com/watch?v=5qap5aO4i9A',
    'Sad': 'https://www.youtube.com/watch?v=i1jSCpo1Vq0',
    'Surprise': 'https://www.youtube.com/watch?v=5qap5aO4i9A',
    'Angry': 'https://www.youtube.com/watch?v=i1jSCpo1Vq0',
    'Unknown': 'https://www.youtube.com/watch?v=5qap5aO4i9A',
  };

  @override
  void initState() {
    super.initState();

    String? emotion = widget.output != null && widget.output!.isNotEmpty
        ? widget.output![0]["label"]
        : null;

    String? videoUrl = emotion != null ? emotionToVideo[emotion] : '';

    if (videoUrl != null && videoUrl.isNotEmpty) {
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(videoUrl),
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 200,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
