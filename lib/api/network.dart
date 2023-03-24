import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:workers/injection.dart';
import 'package:workers/sql/database_helper.dart';

class NetworkApi {
  static final DatabaseHelper databaseHelper = injection<DatabaseHelper>();

  @pragma('vm:entry-point')
  static void apiOne(SendPort sendPort) async {
    init();
    print("Call API 1");
    print("Isolate Id 1 ${Service.getIsolateID(Isolate.current)}");
    print("Process Id 1 $pid");
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
    final dataList = jsonDecode(data.body);
    print("Response API 1 >> $dataList");
    await databaseHelper.insertUsers(dataList);
    print("Insert API 1 >> Done");
    sendPort.send("Add succeed 1");
  }

  @pragma('vm:entry-point')
  static void apiTwo(SendPort sendPort) async {
    init();
    print("Call API 2");
    print("Isolate Id 2 ${Service.getIsolateID(Isolate.current)}");
    print("Process Id 2 $pid");
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/banks?size=20'));
    final dataList = jsonDecode(data.body);
    print("Response API 2 >> $dataList");
    await databaseHelper.insertBanks(dataList);
    print("Insert API 2 >> Done");
    sendPort.send("Add succeed 2");
  }

  @pragma('vm:entry-point')
  static void apiThree(SendPort sendPort) async {
    init();
    print("Call API 3");
    print("Isolate Id 3 ${Service.getIsolateID(Isolate.current)}");
    print("Process Id 3 $pid");
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
    final dataList = jsonDecode(data.body);
    print("Response API 3 >> $dataList");
    await databaseHelper.insertUsers(dataList);
    print("Insert API 3 >> Done");
    sendPort.send("Add succeed 3");
  }

  @pragma('vm:entry-point')
  static void apiFour(SendPort sendPort) async {
    init();
    print("Call API 4");
    print("Isolate Id 4 ${Service.getIsolateID(Isolate.current)}");
    print("Process Id 4 $pid");
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
    final dataList = jsonDecode(data.body);
    print("Response API 4 >> $dataList");
    await databaseHelper.insertUsers(dataList);
    print("Insert API 4 >> Done");
    sendPort.send("Add succeed 4");
  }

  @pragma('vm:entry-point')
  static void apiFive(SendPort sendPort) async {
    init();
    print("Call API 5");
    print("Isolate Id 5 ${Service.getIsolateID(Isolate.current)}");
    print("Process Id 5 $pid");
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/banks?size=20'));
    final dataList = jsonDecode(data.body);
    print("Response API 5 >> $dataList");
    await databaseHelper.insertBanks(dataList);
    print("Insert API 5 >> Done");
    sendPort.send("Add succeed 5");
  }

  @pragma('vm:entry-point')
  static void apiSix(SendPort sendPort) async {
    init();
    print("Call API 6");
    print("Isolate Id 6 ${Service.getIsolateID(Isolate.current)}");
    print("Process Id 6 $pid");
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
    final dataList = jsonDecode(data.body);
    print("Response API 6 >> $dataList");
    await databaseHelper.insertUsers(dataList);
    print("Insert API 6 >> Done");
    sendPort.send("Add succeed 6");
  }

  @pragma('vm:entry-point')
  static void apiSeven(SendPort sendPort) async {
    init();
    print("Call API 7");
    print("Isolate Id 7 ${Service.getIsolateID(Isolate.current)}");
    print("Process Id 7 $pid");
    final data = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=40a99afefc5c4312a7fd02a620f5848a&pageSize=20'));
    final dataList = jsonDecode(data.body);
    print("Response API 7 >> $dataList");
    await databaseHelper.insertArticles(dataList["articles"]);
    print("Insert API 7 >> Done");
    sendPort.send("Add succeed 7");
  }

  @pragma('vm:entry-point')
  static void apiEight(SendPort sendPort) async {
    init();
    print("Call API 8");
    print("Isolate Id 8 ${Service.getIsolateID(Isolate.current)}");
    print("Process Id 8 $pid");
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
    final dataList = jsonDecode(data.body);
    print("Response API 8 >> $dataList");
    await databaseHelper.insertUsers(dataList);
    print("Insert API 8 >> Done");
    sendPort.send("Add succeed 8");
  }

  @pragma('vm:entry-point')
  static void apiNine(SendPort sendPort) async {
    init();
    print("Call API 9");
    print("Isolate Id 9 ${Service.getIsolateID(Isolate.current)}");
    print("Process Id 9 $pid");
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/banks?size=20'));
    final dataList = jsonDecode(data.body);
    print("Response API 9 >> $dataList");
    await databaseHelper.insertBanks(dataList);
    print("Insert API 9 >> Done");
    sendPort.send("Add succeed 9");
  }

  @pragma('vm:entry-point')
  static apiTen(SendPort sendPort) async {
    init();
    print("Call API 10");
    print("Isolate Id 10 ${Service.getIsolateID(Isolate.current)}");
    print("Process Id 10 $pid");
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
    final dataList = jsonDecode(data.body);
    print("Response API 10 >> $dataList");
    await databaseHelper.insertUsers(dataList);
    print("Insert API 10 >> Done");
    sendPort.send("Add succeed 10");
  }
}