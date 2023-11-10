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
  Map<String, List<String>> emotionToVideo = {
    'Happy': [
      'https://www.youtube.com/watch?v=5qap5aO4i9A',
      'https://www.youtube.com/watch?v=5qap5aO4i9A',
      'https://www.youtube.com/watch?v=5qap5aO4i9A',
      'https://www.youtube.com/watch?v=5qap5aO4i9A',
      'https://www.youtube.com/watch?v=5qap5aO4i9A',
    ],
    'Sad': [
      'https://www.youtube.com/watch?v=i1jSCpo1Vq0',
      // Add 4 more URLs for 'Sad'
    ],
    // Add more mappings
  };

  @override
  void initState() {
    super.initState();
    String videoUrl = emotionToVideo[widget.output![0]["label"]]![0] ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> videos = emotionToVideo[widget.output![0]["label"]]!;
    return Scaffold(
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Video ${index + 1}'),
                  onTap: () {
                    String videoUrl = videos[index];
                    _controller.load(YoutubePlayer.convertUrlToId(videoUrl)!);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
