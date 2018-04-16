import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../ui/next_event.dart';
import 'package:camera/camera.dart';
import '../ui/bottom_bar.dart';


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
      bottomNavigationBar:  new BottomBar(widget.cameras),
    );
  }
}