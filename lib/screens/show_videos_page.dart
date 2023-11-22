import 'package:flutter/material.dart';
import 'package:video_filter/screens/home_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShowVideos extends StatefulWidget {
  final String? output;

  const ShowVideos({Key? key, required this.output}) : super(key: key);

  @override
  State<ShowVideos> createState() => _ShowVideosState();
}

class _ShowVideosState extends State<ShowVideos> with WidgetsBindingObserver {
  late YoutubePlayerController _controller;

  Map<String, List<String>> emotionToVideo = {
    'Sad': [
      'https://www.youtube.com/watch?v=hBzP8MtJf04',
      'https://www.youtube.com/watch?v=ZebSXPUCPFc',
      'https://www.youtube.com/watch?v=LtQyEDvdNxs',
      'https://www.youtube.com/watch?v=Dd7FixvoKBw',
      'https://www.youtube.com/watch?v=i1jSCpo1Vq0',
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
      'https://www.youtube.com/watch?v=H8ZH_mkfPUY',
    ],
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    String videoUrl = emotionToVideo[widget.output]![0];
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
    final size = MediaQuery.of(context).size;
    List<String> videos = emotionToVideo[widget.output!]!;
    return WillPopScope(
      onWillPop: () async {
        _controller
            .pause(); // Pause the video when the user tries to leave the page
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
        _controller.pause();

        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  aspectRatio: 16 / 9),
              Expanded(
                child: ListView.builder(
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Video ${index + 1}'),
                      onTap: () {
                        String videoUrl = videos[index];
                        _controller
                            .load(YoutubePlayer.convertUrlToId(videoUrl)!);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Future<bool> didPopRoute() async {
    _controller.pause();
    return super.didPopRoute();
  }
}
