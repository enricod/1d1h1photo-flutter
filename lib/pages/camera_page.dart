
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../model/appconfs.dart';
import '../model/consts.dart';


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
  
  final AppConfs appConfs;
  
  CameraPage(this.appConfs);

   @override
   _CameraExampleHomeState createState() => new _CameraExampleHomeState();

}

class _CameraExampleHomeState extends State<CameraPage> {

  List<CameraDescription> cameras  = new List();

  bool opening = false;

  CameraController controller;

  String imagePath;

  int pictureCount = 0;

  Future<List<CameraDescription>> loadCameras() async {
      return await availableCameras() ;
  }

  @override
  void initState() {
    super.initState();
    loadCameras().then( (c) {
      setState(() {
              this.cameras = c;
            });
      
    });
    
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
                controller = new CameraController(newValue, ResolutionPreset.low);
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
        title: const Text('Camera'),
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

  Future<Null> uploadImage(String path) async  {
    Uri url = Uri.parse(Consts.API_BASE_URL + '/images/upload');
    var request = new http.MultipartRequest("POST", url);
    request.headers['Authorization'] = widget.appConfs.appToken;

    http.MultipartFile.fromPath(
          'image',
          path,
          contentType: new MediaType('image/jpeg', 'jpeg'),
      ).then( (f) {
            request.files.add( f);
            request.send().then((response) {
              if (response.statusCode == 200) {
                print("upload successuful");
              } else {
                print("error in image upload ${response.statusCode}");
              }
            });
      });

    
      
  }

  Future<Null> capture() async {
    if (controller.value.isStarted) {
      final Directory tempDir = await  getTemporaryDirectory();
      if (!mounted) {
        return;
      }
      final String tempPath = tempDir.path;
      final String path = '$tempPath/picture${pictureCount++}.jpg';
      //print("salvataggio immagine " + path);
      await controller.capture(path);
      if (!mounted) {
        return;
      }
      
      setState(() {
          imagePath = path;
        });

      File imageFile = new File(path);
      imageFile.length().then( (dim) => print("$path, dim in bytes = " + dim.toString()));
      

      await uploadImage(path);
    }
  }
}