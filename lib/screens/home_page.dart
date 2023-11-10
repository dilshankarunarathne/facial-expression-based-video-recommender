import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:video_filter/controllers/auth_controlller.dart';
import 'package:video_filter/custom-widgets/circular_indicator.dart';
import 'package:video_filter/custom-widgets/custom_button.dart';
import 'package:video_filter/custom-widgets/custom_text.dart';
import 'package:video_filter/screens/imotion_view_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  late String output;
  final imagePicker = ImagePicker();

  Future getImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();

    (await Tflite.loadModel(
        model: 'lib/assets/model.tflite', labels: 'lib/assets/labels.txt'))!;
  }

  Future imageClassification(File image) async {
    var recognitions = await Tflite.runModelOnImage(
        path: _image!.path,
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.1,
        asynch: true,
        numResults: 1);
    for (var element in recognitions!) {
      setState(() {
        output = element['label'];
      });
    }

    print(output);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.grey.shade900,
            title: Center(
              child: CustomPoppinsText(
                  text: "Home Page",
                  color: Colors.white,
                  fsize: 25,
                  fweight: FontWeight.w600),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    AuthController.signOutUser(context);
                  },
                  icon: const Icon(Icons.logout))
            ],
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _image == null
                      ? Center(
                          child: SizedBox(
                              height: size.height * 0.5,
                              width: size.width * 0.9,
                              child: const Center(
                                  child: Text("No Captured Image"))),
                        )
                      : Center(
                          child: SizedBox(
                              height: size.height * 0.5,
                              width: size.width * 0.9,
                              child: Image.file(_image!)),
                        ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: getImage,
                    child: Container(
                        width: size.width * 0.8,
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade600),
                        child: const Center(
                          child: Icon(
                            Icons.camera_alt,
                            size: 35,
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    size: size,
                    ontap: () {
                      _image == null
                          ? Fluttertoast.showToast(
                              msg: "Please Capture Image",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0)
                          : showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: CircularIndicator(isVisible: true),
                                );
                              },
                            );
                      loadModel();
                      imageClassification(_image!);
                      Future.delayed(
                        const Duration(seconds: 4),
                        () {
                          CircularIndicator(isVisible: false);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmotionViewPage(
                                  output: output,
                                ),
                              ));
                        },
                      );
                    },
                    text: "Check Image",
                    buttonColor: Colors.grey.shade900,
                    textColor: Colors.white,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
