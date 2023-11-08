import 'package:flutter/material.dart';

class ShowVideos extends StatefulWidget {
  const ShowVideos({super.key});

  @override
  State<ShowVideos> createState() => _ShowVideosState();
}

class _ShowVideosState extends State<ShowVideos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
