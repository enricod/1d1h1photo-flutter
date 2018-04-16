import 'dart:async';
import 'dart:io';
import 'appconfs.dart';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class AppTokenStorage {
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
      return json.decode(contents);
    } catch (e) {
      return new AppConfs();
    }
  }

  Future<File> writeConfs(AppConfs counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(json.encode(counter));
  }
}
