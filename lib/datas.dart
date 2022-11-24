import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isolate_app/user.dart';

class MainClient {
  int someBigBigData(int k) {
    var sum = 0;
    for (var i = 0; i < 1000; i++) {
      for (var j = 0; j < 1000; j++) {
        sum = i + j + k;
      }
    }

    return sum;
  }

  Future<List<User>> readJsonWithSirialization(String filePath) async {
    WidgetsFlutterBinding.ensureInitialized();
    print('resad! $filePath');
    List<User> users = List.empty(growable: true);
    final json = await rootBundle.loadString('assets/users.json');
    print(json);

    var map = jsonDecode(json);
    for (var user in map['users']) {
      users.add(User(
        user['id'],
        user['age'],
        user['firstName'],
        user['lastName'],
        user['username'],
      ));
    }

    return users;
  }

  Future<void> printJson(String filePath) async {
    final json = await rootBundle.loadString(filePath);
    // print(json);
  }

  Future<List<User>> computeReadJson() async {
    print('readJson!');
    const path = 'assets/users.json';
    await printJson(path);
    return await compute(readJsonWithSirialization, path);
  }

  Future<int> computeCalcBigData() async {
    return await compute(someBigBigData, 10);
  }
}
