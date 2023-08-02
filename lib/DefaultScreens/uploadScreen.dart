import 'dart:io';

import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sk/Constants/ButtonBuilder.dart';
import 'package:sk/Constants/constants.dart';
import 'package:tflite/tflite.dart';

class UploadScreen extends StatefulWidget {
  static String id = 'Upload Screen';

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? image;
  List? result;
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  bool isLoading = false;

  Future pickImage(ImageSource source) async {
    var pickedimage = await ImagePicker().pickImage(source: source);
    if (pickedimage != null) {
      image = File(pickedimage.path);
      // setState(() => this.image = imageTemporary);
      classifyImage();
      showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kPrimaryColor,
                    width: 7,
                  ),
                ),
                child: CircularSeekBar(
                  width: double.infinity,
                  height: 200,
                  progress: 100.0,
                  barWidth: 8,
                  startAngle: 45,
                  sweepAngle: 360,
                  strokeCap: StrokeCap.butt,
                  progressGradientColors: const [
                    kGreenColor,
                    kDGreenColor
                  ],
                  innerThumbRadius: 5,
                  innerThumbStrokeWidth: 3,
                  innerThumbColor: Colors.white,
                  outerThumbRadius: 5,
                  outerThumbStrokeWidth: 10,
                  outerThumbColor: kPrimaryColor,
                  dashWidth: 1,
                  dashGap: 2,
                  animation: true,
                  curves: Curves.bounceOut,
                  valueNotifier: _valueNotifier,
                  child: Center(
                    child: ValueListenableBuilder(
                        valueListenable: _valueNotifier,
                        builder: (_, double value, __) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('${value.round()}',
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            )),
                  ),
                ),
              ),
            ),
          );
        },
      );
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.pop(context);
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: ButtonBuilder(

                        text: 'OK', ontap: () { Navigator.pop(context); },

                      ),
                    ),
                  ],
                ),
              ],
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.file(
                    image!,
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  const Text('the Result is :'),
                  const SizedBox(height: 10),
                  Text(
                    result![0]['label'].toString(),
                    style: const TextStyle(
                      color: Color(0xff00c400),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'with ${result![0]['confidence'] * 100}% confidence',
                    style: const TextStyle(
                      color: Color(0xff00c400),
                      fontSize:14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      });
    }
    else {}
  }

  Future classifyImage() async {
    await Tflite.loadModel(
      model: 'assets/tfliteModel/vgg16.tflite',
      labels: 'assets/tfliteModel/vgg.txt',
    );
    final List? output = await Tflite.runModelOnImage(
      path: image!.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    print(output);
    setState(() {
      result = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Container(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: CircleAvatar(
              child: image != null
                  ? Image.file(image!)
                  : Image.asset('assets/logo/logo.png'),
              radius: 80,
              backgroundColor: kPrimaryColor,
            ),),
            Expanded(
              child: ButtonBuilder(
                text: 'Upload Image',
                ontap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (builder) => Container(
                            height: height * 0.15,
                            width: width,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Choose Picture Provider',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              pickImage(ImageSource.camera);
                                            },
                                            icon: Icon(
                                              Icons.camera_alt,
                                            )),
                                        Text('Camera')
                                      ],
                                    ),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              pickImage(ImageSource.gallery);
                                            },
                                            icon: Icon(
                                              Icons.photo,
                                            )),
                                        Text('Gallery'),
                                      ],
                                    ),
                                    Spacer(
                                      flex: 12,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
