import 'package:flutter/material.dart';
import '../ui/next_event.dart';
import 'package:camera/camera.dart';
import 'camera_page.dart';
import 'myphotos_page.dart';

class MyHomePage extends StatefulWidget {

  final List<CameraDescription> cameras;
  final String title;

  MyHomePage({Key key, this.title, this.cameras}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new NextEvent(),
            new Text(
              'You have premuto the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar:  new BottomNavigationBar(
          currentIndex: 0,
          onTap: (int index) { 
            if (index == 1) {
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (context) => new CameraPage(widget.cameras)
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
      ),
    );
  }
}