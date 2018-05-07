import 'dart:async';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'model/apptoken_storage.dart';
import 'model/appconfs.dart';
import 'model/consts.dart';

Future<Null> main() async {
  AppTokenStorage storage = new AppTokenStorage();
  var readConfs = storage.readConfs();
  readConfs.then((onValue) {
    runApp(new MyApp(onValue, storage));
  });
}

class MyApp extends StatelessWidget {

  final AppConfs appConfs;
  final AppTokenStorage storage;
  MyApp(this.appConfs, this.storage);

  Widget _getStartPage() {
    return appConfs.appToken == '' ?
      new LoginPage( storage):
      new MyHomePage(title: Consts.APP_TITLE, appConfs: appConfs, storage: storage);
      //new EventPage(new Event());
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _getStartPage(),
    );
  }
}


