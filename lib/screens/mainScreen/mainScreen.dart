import 'dart:io';

import 'package:camera/screens/mainScreen/providers/cameraScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String imagePath = '';

  Future<File> getImg() async {
    final imageProviderFile = Provider.of<CameraScreenProvider>(context);
    final image = imageProviderFile.pickedImage;
    imagePath = imageProviderFile.imagePath;
    return image;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Consumer<CameraScreenProvider>(
            builder: (context, value, child) {
              return Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Image',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 80,
                      child: FutureBuilder<File>(
                        future: getImg(),
                        builder: (context, AsyncSnapshot<File?> snapshot) {
                          //File imageFile = snapshot.data!;
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Image.file(
                              snapshot.data!,
                              fit: BoxFit.cover,
                            );
                          } else {
                            return Container(
                              child: const Text('Please Pick An Image'),
                            );
                          }
                        },
                      )),
                  Expanded(
                    flex: 8,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              value.galleryImage();
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.image_outlined,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              value.cameraImage();
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.camera,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                value.saveToGallery();
                                QuickAlert.show(
                                  type: QuickAlertType.success,
                                  context: context,
                                  title: 'Image Saved',
                                  backgroundColor: Colors.green.shade800,
                                  text: 'Saved Location:\n$imagePath',
                                  barrierColor: Colors.transparent,
                                  titleColor: Colors.white,
                                  textColor: Colors.black,
                                );
                              });
                            },
                            child: const Icon(
                              Icons.save_outlined,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
