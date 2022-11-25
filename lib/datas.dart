import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:isolate_app/user.dart';

// 응답 결과를 List<Photo>로 변환하는 함수.

class MainClient {
  List<int> randomIntList = List.empty(growable: true);

  int someBigBigData(int k) {
    var sum = 0;
    for (var i = 0; i < 1000; i++) {
      for (var j = 0; j < 1000; j++) {
        sum = i + j + k;
      }
    }

    return sum;
  }

  List<User> parseJsonUser(String json) {
    List<User> users = List.empty(growable: true);

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

  void _fillRandomList(_) {
    for (var i = 0; i < 10000; i++) {
      final r = Random().nextInt(100);
      randomIntList.add(r);
    }
    print('listforloop Length => ${randomIntList.length}');
  }

  void fillRandomList() async {
    print('list Length => ${randomIntList.length}');
    await compute(_fillRandomList, null);
    print('list Length done=> ${randomIntList.length}');
  }

  Future<List<User>> loadJson(String path) async {
    final json = await rootBundle.loadString(path);
    return compute(parseJsonUser, json);
  }

  Future<List<User>> computeReadJson() async {
    const path = 'assets/users.json';
    // await printJson(path);
    return loadJson(path);
  }

  Future<int> computeCalcBigData() async {
    return await compute(someBigBigData, 10);
  }
}
