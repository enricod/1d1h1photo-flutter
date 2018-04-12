import 'package:flutter/material.dart';
import '../pages/camera_page.dart';

import '../pages/myphotos_page.dart';
import 'package:camera/camera.dart';

class BottomBar extends StatelessWidget {

  final List<CameraDescription> cameras;

  BottomBar( this.cameras);

  @override
  Widget build(BuildContext context) {
   return new BottomNavigationBar(
          currentIndex: 0,
          onTap: (int index) { 
            if (index == 1) {
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (context) => new CameraPage(this.cameras)
                )
              );
            } else if (index==2) {
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (context) => new MyPhotosPage()
                )
              );
            }
            print("hai premuto " + index.toString());
              //setState((){  }); 
            },
            type: BottomNavigationBarType.fixed,

          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home"),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.camera),
              title: new Text("Camera"),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              title: new Text("My Photos"),
            ),
        ],
      );
 }
}