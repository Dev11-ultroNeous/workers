import 'dart:convert';

import 'package:worker_manager/worker_manager.dart';
import 'package:http/http.dart' as http;


class NetworkApi{
  Future<List> apiOne(int n, TypeSendPort port) async {
    final data= await http
        .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
    final dataList = jsonDecode(data.body);
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
    final data= await http
        .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
    final dataList = jsonDecode(data.body);
    return dataList;
  }

  void apiFive(int n, TypeSendPort port) async {
    await http
        .get(Uri.parse('https://random-data-api.com/api/v2/banks?size=20'));
  }

  void apiSix(int n, TypeSendPort port) async {
    await http
        .get(Uri.parse('https://random-data-api.com/api/v2/appliances?size=20'));
  }

  Future<List> apiSeven(int n, TypeSendPort port) async {
  final data =  await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=40a99afefc5c4312a7fd02a620f5848a&pageSize=20'));
  final dataList = jsonDecode(data.body);
  return dataList["articles"];
  }

  void apiEight(int n, TypeSendPort port) async {
    await http
        .get(Uri.parse('https://random-data-api.com/api/v2/appliances?size=20'));
  }

  void apiNine(int n, TypeSendPort port) async {
    await http
        .get(Uri.parse('https://random-data-api.com/api/v2/banks?size=20'));
  }

  Future<List> apiTen(int n, TypeSendPort port) async {
    final data= await http
        .get(Uri.parse('https://random-data-api.com/api/v2/users?size=20'));
    final dataList = jsonDecode(data.body);
    return dataList;
  }
}
