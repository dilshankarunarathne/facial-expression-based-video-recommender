import 'package:flutter/material.dart';
import 'package:video_filter/custom-widgets/circular_indicator.dart';
import 'package:video_filter/custom-widgets/custom_button.dart';
import 'package:video_filter/custom-widgets/custom_text.dart';
import 'package:video_filter/screens/home_page.dart';
import 'package:video_filter/screens/show_videos_page.dart';

import '../custom-widgets/emotion_icon.dart';

// ignore: must_be_immutable
class EmotionViewPage extends StatelessWidget {
  EmotionViewPage({super.key, required this.output});
  String output;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey.shade900,
          ),
          body: Stack(
            children: [
              Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * 0.5,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          EmotionIcon(output: output),
                          CustomPoppinsText(
                              text: output,
                              color: Colors.white,
                              fsize: 35,
                              fweight: FontWeight.w500)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      size: size,
                      ontap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: CircularIndicator(isVisible: true),
                            );
                          },
                        );
                        Future.delayed(
                          const Duration(seconds: 4),
                          () {
                            CircularIndicator(isVisible: false);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ShowVideos(),
                                ));
                          },
                        );
                      },
                      text: "Next",
                      buttonColor: Colors.white,
                      textColor: Colors.grey.shade900,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
