
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


IconData cameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw new ArgumentError('Unknown lens direction');
}

class CameraPage extends StatefulWidget {

  //final List<CameraDescription> _cameras;
  // CameraPage( this._cameras );


  
   @override
   _CameraExampleHomeState createState() => new _CameraExampleHomeState();

}

class _CameraExampleHomeState extends State<CameraPage> {

  List<CameraDescription> cameras  = new List();

  bool opening = false;

  CameraController controller;

  String imagePath;

  int pictureCount = 0;

  void loadCameras() async {
      cameras = await availableCameras();
  }

  @override
  void initState() {
    super.initState();
    loadCameras();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> headerChildren = <Widget>[];

    final List<Widget> cameraList = <Widget>[];

    if (this.cameras.isEmpty) {
      cameraList.add(const Text('No cameras found'));
    } else {
      for (CameraDescription cameraDescription in this.cameras) {
        cameraList.add(
          new SizedBox(
            width: 90.0,
            child: new RadioListTile<CameraDescription>(
              title: new Icon(cameraLensIcon(cameraDescription.lensDirection)),
              groupValue: controller?.description,
              value: cameraDescription,
              onChanged: (CameraDescription newValue) async {
                final CameraController tempController = controller;
                controller = null;
                await tempController?.dispose();
                controller =
                new CameraController(newValue, ResolutionPreset.high);
                await controller.initialize();
                setState(() {});
              },
            ),
          ),
        );
      }
    }

    headerChildren.add(new Column(children: cameraList));
    if (controller != null) {
      headerChildren.add(playPauseButton());
    }
    if (imagePath != null) {
      headerChildren.add(imageWidget());
    }

    final List<Widget> columnChildren = <Widget>[];
    columnChildren.add(new Row(children: headerChildren));
    if (controller == null || !controller.value.initialized) {
      columnChildren.add(const Text('Tap a camera'));
    } else if (controller.value.hasError) {
      columnChildren.add(
        new Text('Camera error ${controller.value.errorDescription}'),
      );
    } else {
      columnChildren.add(
        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.all(5.0),
            child: new Center(
              child: new AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: new CameraPreview(controller),
              ),
            ),
          ),
        ),
      );
    }
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Camera example'),
      ),
      body: new Column(children: columnChildren),
      floatingActionButton: (controller == null)
          ? null
          : new FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: controller.value.isStarted ? capture : null,
      ),
    );
  }

  Widget imageWidget() {
    return new Expanded(
      child: new Align(
        alignment: Alignment.centerRight,
        child: new SizedBox(
          child: new Image.file(new File(imagePath)),
          width: 64.0,
          height: 64.0,
        ),
      ),
    );
  }

  Widget playPauseButton() {
    return new FlatButton(
      onPressed: () {
        setState(
              () {
            if (controller.value.isStarted) {
              controller.stop();
            } else {
              controller.start();
            }
          },
        );
      },
      child:
      new Icon(controller.value.isStarted ? Icons.pause : Icons.play_arrow),
    );
  }

  Future<Null> capture() async {
    if (controller.value.isStarted) {
      final Directory tempDir = await getTemporaryDirectory();
      if (!mounted) {
        return;
      }
      final String tempPath = tempDir.path;
      final String path = '$tempPath/picture${pictureCount++}.jpg';
      print("salvataggio immagine " + path);
      await controller.capture(path);
      if (!mounted) {
        return;
      }
      setState(
            () {
          imagePath = path;
        },
      );
    }
  }
}