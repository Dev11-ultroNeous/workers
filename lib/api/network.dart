import 'dart:convert';

import 'package:workers/injection.dart';
import 'package:workers/sql/database_helper.dart';
import 'package:workers/worker_manager/src/port/send_port.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class NetworkApi {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final DatabaseHelper databaseHelper = injection<DatabaseHelper>();

  Future<List> apiOne(int n, TypeSendPort port) async {
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
    final dataList = jsonDecode(data.body);
    databaseHelper.insertUsers(dataList);
    return dataList;
  }

  Future<List> apiTwo(int n, TypeSendPort port) async {
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/banks?size=20'));
    final dataList = jsonDecode(data.body);
    return dataList;
  }

  void apiThree(int n, TypeSendPort port) async {
    await http.get(
        Uri.parse('https://random-data-api.com/api/v2/appliances?size=20'));
  }

  Future<List> apiFour(int n, TypeSendPort port) async {
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
    final dataList = jsonDecode(data.body);
    return dataList;
  }

  void apiFive(int n, TypeSendPort port) async {
    final SharedPreferences prefs = await _prefs;

    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/banks?size=20'));
    final dataList = jsonDecode(data.body);
    prefs.setStringList("bank", dataList);
  }

  void apiSix(int n, TypeSendPort port) async {
    await http.get(
        Uri.parse('https://random-data-api.com/api/v2/appliances?size=20'));
  }

  Future<List> apiSeven(int n, TypeSendPort port) async {
    final data = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=40a99afefc5c4312a7fd02a620f5848a&pageSize=20'));
    final dataList = jsonDecode(data.body);
    return dataList["articles"];
  }

  void apiEight(int n, TypeSendPort port) async {
    await http.get(
        Uri.parse('https://random-data-api.com/api/v2/appliances?size=20'));
  }

  void apiNine(int n, TypeSendPort port) async {
    await http
        .get(Uri.parse('https://random-data-api.com/api/v2/banks?size=20'));
  }

  Future<List> apiTen(int n, TypeSendPort port) async {
    final data = await http
        .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
    final dataList = jsonDecode(data.body);
    return dataList;
  }
}
