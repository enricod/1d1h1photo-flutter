import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/consts.dart';
import '../ui/next_event.dart';
import '../ui/bottom_bar.dart';
import '../model/appconfs.dart';
import '../model/events.dart';


class MyHomePage extends StatefulWidget {

  final List<CameraDescription> cameras;
  final String title;
  final AppConfs appConfs;

  MyHomePage({Key key, this.title, this.cameras, this.appConfs}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}


/*
 * ================== STATE MANAGEMENT =========================================
 */
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Event futureEvent = new Event();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<Map<String, dynamic>> _scaricaEventi(AppConfs appConfs) async {
    http.Response res = await http
        .get( Consts.API_BASE_URL + '/events/summary/list', headers: {'Authorization': appConfs.appToken});

    print (res.statusCode);
    print( res.body);
      return json.decode(res.body);

  }

  @override
  void initState() {
    super.initState();
    var scaricaEventi = _scaricaEventi(widget.appConfs);
    scaricaEventi.then( (onValue) {
        if (onValue['body']['futureEvents'] != null) {
          var eventoFuturo = onValue['body']['futureEvents'][0];
          setState(() {
            futureEvent = new Event.fromJson(eventoFuturo);
          });
        }
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
            new Text("Welcome " + widget.appConfs.username),
            new NextEvent(futureEvent),
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
      ),
      bottomNavigationBar:  new BottomBar(widget.cameras),
    );
  }
}