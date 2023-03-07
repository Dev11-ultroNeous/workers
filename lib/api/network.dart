// import 'dart:convert';
// import 'dart:isolate';
//
// import 'package:workers/injection.dart';
// import 'package:workers/sql/database_helper.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'package:http/http.dart' as http;
//
//  class NetworkApi {
//   static final DatabaseHelper databaseHelper = injection<DatabaseHelper>();
//
//  static Future apiOne() async {
//     print("Call API One");
//     final data = await http
//         .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
//     final dataList = jsonDecode(data.body);
//    await databaseHelper.insertUsers(dataList);
//   }
//
//
//   static Future apiTwo() async {
//     print("Call API Two");
//     final data = await http
//         .get(Uri.parse('https://random-data-api.com/api/v2/banks?size=20'));
//     final dataList = jsonDecode(data.body);
//   }
//
//   static Future apiThree() async {
//     print("Call API Three");
//     await http.get(
//         Uri.parse('https://random-data-api.com/api/v2/appliances?size=20'));
//   }
//   static Future apiFour() async {
//     print("Call API Four");
//     final data = await http
//         .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
//     final dataList = jsonDecode(data.body);
//     print(dataList);
//   }
//
//   static Future apiFive() async {
//     print("Call API Five");
//     final data = await http
//         .get(Uri.parse('https://random-data-api.com/api/v2/banks?size=20'));
//     final dataList = jsonDecode(data.body);
//   }
//
//   static Future apiSix() async {
//     print("Call API Six");
//     await http.get(
//         Uri.parse('https://random-data-api.com/api/v2/appliances?size=20'));
//   }
//
//
//   static Future apiSeven() async {
//     print("Call API Seven");
//     final data = await http.get(Uri.parse(
//         'https://newsapi.org/v2/top-headlines?country=in&apiKey=40a99afefc5c4312a7fd02a620f5848a&pageSize=20'));
//     final dataList = jsonDecode(data.body);
//     await databaseHelper.insertArticles(dataList["articles"]);
//   }
//
//
//   static Future apiEight() async {
//     print("Call API Eight");
//     await http.get(
//         Uri.parse('https://random-data-api.com/api/v2/appliances?size=20'));
//   }
//
//   static Future apiNine() async {
//     print("Call API Nine");
//     await http
//         .get(Uri.parse('https://random-data-api.com/api/v2/banks?size=20'));
//   }
//   static Future apiTen() async {
//     print("Call API Ten");
//     final data = await http
//         .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
//     final dataList = jsonDecode(data.body);
//   }
// }
import 'dart:convert';
import 'dart:isolate';

import 'package:workers/injection.dart';
import 'package:workers/sql/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class NetworkApi {
  static final DatabaseHelper databaseHelper = injection<DatabaseHelper>();
  @pragma('vm:entry-point')
  static void apiOne(SendPort sendPort) async {
    print("Call API One");
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
    final dataList = jsonDecode(data.body);
   await databaseHelper.insertUsers(dataList);
    sendPort.send("Add succeed");
  }

  @pragma('vm:entry-point')
  static void apiTwo(SendPort sendPort) async {
    print("Call API Two");
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/banks?size=20'));
    final dataList = jsonDecode(data.body);
    sendPort.send("Add succeed");
  }

  @pragma('vm:entry-point')
  static void apiThree(SendPort sendPort) async {
    print("Call API Three");
    await http.get(
        Uri.parse('https://random-data-api.com/api/v2/appliances?size=20'));
    sendPort.send("Add succeed");
  }

  @pragma('vm:entry-point')
  static void apiFour(SendPort sendPort) async {
    print("Call API Four");
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
    final dataList = jsonDecode(data.body);
    sendPort.send("Add succeed");
  }

  @pragma('vm:entry-point')
  static void apiFive(SendPort sendPort) async {
    print("Call API Five");
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/banks?size=20'));
    final dataList = jsonDecode(data.body);
    sendPort.send("Add succeed");
  }

  @pragma('vm:entry-point')
  static void apiSix(SendPort sendPort) async {
    print("Call API Six");
    await http.get(
        Uri.parse('https://random-data-api.com/api/v2/appliances?size=20'));
    sendPort.send("Add succeed");
  }

  @pragma('vm:entry-point')
  static void apiSeven(SendPort sendPort) async {
    print("Call API Seven");
    final data = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=40a99afefc5c4312a7fd02a620f5848a&pageSize=20'));
    final dataList = jsonDecode(data.body);
    databaseHelper.insertArticles(dataList["articles"]);
    sendPort.send("Add succeed");
  }

  @pragma('vm:entry-point')
  static void apiEight(SendPort sendPort) async {
    print("Call API Eight");
    await http.get(
        Uri.parse('https://random-data-api.com/api/v2/appliances?size=20'));
    sendPort.send("Add succeed");
  }

  @pragma('vm:entry-point')
  static void apiNine(SendPort sendPort) async {
    print("Call API Nine");
    await http
        .get(Uri.parse('https://random-data-api.com/api/v2/banks?size=20'));
    sendPort.send("Add succeed");
  }

  @pragma('vm:entry-point')
  static apiTen(SendPort sendPort) async {
    print("Call API Ten");
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
    final dataList = jsonDecode(data.body);
    sendPort.send("Add succeed");
  }
}