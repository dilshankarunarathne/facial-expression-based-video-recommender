import 'package:flutter/material.dart';
import 'package:video_filter/screens/home_page.dart';

class ShowVideos extends StatefulWidget {
  const ShowVideos({super.key});

  @override
  State<ShowVideos> createState() => _ShowVideosState();
}

<<<<<<< Updated upstream
class _ShowVideosState extends State<ShowVideos> {
=======
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

>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  HomePage(),
            ));
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 100,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Card(elevation: 8, child: Text("Videos")),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
<<<<<<< Updated upstream
=======

  @override
  Future<bool> didPopRoute() async {
    _controller.pause();
    return super.didPopRoute();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
>>>>>>> Stashed changes
}
