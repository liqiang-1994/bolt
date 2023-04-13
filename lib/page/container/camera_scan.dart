import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraScanPage extends StatefulWidget {
  const CameraScanPage({Key? key}) : super(key: key);

  @override
  State<CameraScanPage> createState() => _CameraScanPageState();
}

class _CameraScanPageState extends State<CameraScanPage> {
  CameraController? cameraController;
  //fl.FlCameraEvent? event;
  bool hasImageStream = false;
  int time = 0;
  int currentTime = 0;

  @override
  void initState() {
    super.initState();
    //initEvent();
    initCamera();
  }


  // Future<void> initEvent() async {
  //   event = fl.FlCameraEvent();
  //   final bool state = await event!.initialize();
  //   if (!state) return;
  //   event?.addListener((dynamic value) {
  //     print(value);
  //     if (value != null && hasImageStream) {
  //
  //     }
  //   });
  // }

  Future<void> initCamera() async {
    final List<CameraDescription> cameras = await availableCameras();
    print(cameras.length.toString()+'---');
    CameraDescription? description;
    for (CameraDescription item in cameras) {
      if (item.lensDirection == CameraLensDirection.back) {
        description = item;
      }
    }
    if (description == null) return;
    cameraController = CameraController(description, ResolutionPreset.high, enableAudio: false);
    await cameraController?.initialize();
    setState(() {});
    time = DateTime.now().microsecondsSinceEpoch;
    startImageStream();
  }

  void startImageStream() {
    hasImageStream = true;
    currentTime = DateTime.now().microsecond;
    cameraController?.startImageStream((CameraImage image) {
      if ((DateTime.now().microsecond - currentTime) > 400) {
        if (image.planes.isEmpty || image.planes[0].bytes.isEmpty) {
           return;
        }
        if (Platform.isAndroid && image.format.group != ImageFormatGroup.yuv420) {
          return;
        }
      }
    });
  }

  @override
  void dispose() {
    cameraController?.dispose();
    cameraController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget child = Container();
    if (cameraController != null) child = CameraPreview(cameraController!);
    return Scaffold(
        backgroundColor: Colors.white, body: Center(child: child));
  }
}
