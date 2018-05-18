import 'dart:async';
import 'dart:io';
import 'appconfs.dart';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

/// singleton implementation
class AppTokenStorage {
  static final AppTokenStorage _singleton = new AppTokenStorage._internal();

  factory AppTokenStorage() {
    return _singleton;
  }

  AppTokenStorage._internal();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return new File('$path/appToken.txt');
  }

  Future<AppConfs> readConfs() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      Map userMap = json.decode(contents);
      return new AppConfs.fromJson(userMap);
    } catch (e) {
      return new AppConfs();
    }
  }

  Future<File> writeConfs(AppConfs appConfs) async {
    final file = await _localFile;
    // print(file.path);
    // Write the file
    return file.writeAsString(json.encode(appConfs));
  }
}
