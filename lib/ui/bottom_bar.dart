import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../model/appconfs.dart';
import '../model/apptoken_storage.dart';
import '../pages/mysettings_page.dart';
import '../pages/camera_page.dart';
import '../pages/myphotos_page.dart';

class BottomBar extends StatelessWidget {

  final AppConfs appConfs;

  final AppTokenStorage storage;

  BottomBar(   this.appConfs, this.storage);

  @override
  Widget build(BuildContext context) {
   return new BottomNavigationBar(
          currentIndex: 0,
          onTap: (int index) { 
            if (index == 1) {
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (context) => new CameraPage( )
                )
              );
            } else if (index==2) {
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (context) => new MyPhotosPage(this.appConfs)
                )
              );
            
            } else if (index==3) {
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (context) => new MySettingsPage(this.appConfs, this.storage)
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
            new BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              title: new Text("My Settings"),
            ),
        ],
      );
 }
}