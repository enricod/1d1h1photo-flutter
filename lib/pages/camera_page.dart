import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';



class CameraPage extends StatefulWidget {

  final List<CameraDescription> _cameras;
  CameraPage( this._cameras );

   @override
  _CameraState createState() => new _CameraState();

}

class _CameraState extends State<CameraPage> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = new CameraController(widget._cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.initialized) {
      return new Container();
    }
    return new AspectRatio(
        aspectRatio:
        controller.value.aspectRatio,
        child: new CameraPreview(controller));
  }
}