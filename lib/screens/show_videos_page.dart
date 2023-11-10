import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShowVideos extends StatefulWidget {
  final String? output;

  const ShowVideos({Key? key, required this.output}) : super(key: key);

  @override
  State<ShowVideos> createState() => _ShowVideosState();
}

class _ShowVideosState extends State<ShowVideos> {
  late YoutubePlayerController _controller;
  Map<String, List<String>> emotionToVideo = {
    'Happy': [
      'https://www.youtube.com/watch?v=CvaPziI1SPc',
      'https://www.youtube.com/watch?v=JxJsai5nkGI',
      'https://www.youtube.com/watch?v=kIF3BYBXZWA',
      'https://www.youtube.com/watch?v=ec-02EGPWS8',
      'https://www.youtube.com/watch?v=5qap5aO4i9A',
    ],
    'Sad': [
      'https://www.youtube.com/watch?v=hBzP8MtJf04',
      'https://www.youtube.com/watch?v=ZebSXPUCPFc',
      'https://www.youtube.com/watch?v=LtQyEDvdNxs',
      'https://www.youtube.com/watch?v=Dd7FixvoKBw',
      'https://www.youtube.com/watch?v=i1jSCpo1Vq0',
    ],
    'Suprise': [
      'https://www.youtube.com/watch?v=viEagTfpoeQ',
      'https://www.youtube.com/watch?v=5qap5aO4i9A',
      'https://www.youtube.com/watch?v=06bnVPhgxVs',
      'https://www.youtube.com/watch?v=tmDsz3RsQNs',
      'https://www.youtube.com/watch?v=_6oCKJK_5Xs',
    ],
    'Angry': [
      'https://www.youtube.com/watch?v=Jx6H_mq8c9o',
      'https://www.youtube.com/watch?v=wAQtBS4zhy0',
      'https://www.youtube.com/watch?v=rFpjIsJxXZk',
      'https://www.youtube.com/watch?v=AWCmOsxcHEg',
      'https://www.youtube.com/watch?v=5qap5aO4i9A',
    ],
    'Unknown': [
      'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'https://www.youtube.com/watch?v=LLFhKaqnWwk',
      'https://www.youtube.com/watch?v=lpiB2wMc49g',
      'https://www.youtube.com/watch?v=5qap5aO4i9A',
    ],
  };

  @override
  void initState() {
    super.initState();
    String videoUrl = emotionToVideo[widget.output]![0] ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> videos = emotionToVideo[widget.output!]!;
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
