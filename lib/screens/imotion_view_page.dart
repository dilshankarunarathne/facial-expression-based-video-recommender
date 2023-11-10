import 'package:flutter/material.dart';
import 'package:video_filter/custom-widgets/custom_button.dart';
import 'package:video_filter/custom-widgets/custom_text.dart';
import 'package:video_filter/screens/show_videos_page.dart';

class EmotionViewPage extends StatefulWidget {
  final List<dynamic>? output;

  const EmotionViewPage({Key? key, this.output}) : super(key: key);

  @override
  State<EmotionViewPage> createState() => _EmotionViewPageState();
}

class _EmotionViewPageState extends State<EmotionViewPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final emotion = widget.output != null && widget.output!.isNotEmpty
        ? widget.output![0]["label"]
        : "Unknown";

    return SafeArea(
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
                        Icon(
                          Icons.emoji_emotions_rounded,
                          color: Colors.amber.shade500,
                          size: 80,
                        ),
                        CustomPoppinsText(
                            text: emotion,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShowVideos(),
                          ));
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
    );
  }
}
