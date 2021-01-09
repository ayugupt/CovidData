import 'package:http/http.dart';

import 'dart:convert';

class GetData{
 Future<Map<String, dynamic>> getData() async {
  String url = "https://raw.githubusercontent.com/pomber/covid19/master/docs/timeseries.json";
  Response response = await get(url);
  Map<String, dynamic> map = jsonDecode(response.body);
  //print(map["Worldwide"]);
  return map;
 }  
}