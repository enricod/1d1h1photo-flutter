import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/consts.dart';
import '../ui/event.dart';
import '../ui/bottom_bar.dart';
import '../model/appconfs.dart';
import '../model/events.dart';

class MyHomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String title;
  final AppConfs appConfs;

  MyHomePage({Key key, this.title, this.cameras, this.appConfs})
      : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

/*
 * ================== STATE MANAGEMENT =========================================
 */
class _MyHomePageState extends State<MyHomePage> {
  Event futureEvent = new Event();
  List<Event> closedEvents = new List();

  Future<Map<String, dynamic>> _scaricaEventi(AppConfs appConfs) async {
    http.Response res = await http.get(
        Consts.API_BASE_URL + '/events/summary/list',
        headers: {'Authorization': appConfs.appToken});

    print(res.statusCode);
    print(res.body);
    return json.decode(res.body);
  }

  @override
  void initState() {
    super.initState();
    var scaricaEventi = _scaricaEventi(widget.appConfs);
    scaricaEventi.then((onValue) {
      if (onValue['body']['futureEvents'] != null) {
        var eventoFuturo = onValue['body']['futureEvents'][0];
        var closedEventsJson = onValue['body']['closedEvents'];
        List<Event> closed = new List();
        for (var evn in closedEventsJson) {
          Event e = Event.fromJson(evn);
          e.futuro = false;
          closed.add(e);
        }
        setState(() {
          futureEvent = new Event.fromJson(eventoFuturo);
          closedEvents = closed;
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
        body: new ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              new EventEntryItem(closedEvents[index]),
          itemCount: closedEvents.length,
        ),


      bottomNavigationBar: new BottomBar(widget.cameras),
    );
  }
}
