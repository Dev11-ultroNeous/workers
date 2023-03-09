import 'dart:convert';
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
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
    final dataList = jsonDecode(data.body);
    print("Response API 10 >> $dataList");
    await databaseHelper.insertUsers(dataList);
    print("Insert API 10 >> Done");
    sendPort.send("Add succeed 10");
  }
}