import 'package:flutter/material.dart';
import 'package:video_filter/screens/home_page.dart';

class ShowVideos extends StatefulWidget {
  const ShowVideos({super.key});

  @override
  State<ShowVideos> createState() => _ShowVideosState();
}

class _ShowVideosState extends State<ShowVideos> {
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
}
