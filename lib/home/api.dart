import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'modelweather.dart';

Future<Weather> fetchWeather() async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=Tegal&appid=a9192d54a79db76b09f92bbb3deddfe2&units=metric'));

  if (response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load weather');
  }
}

Future<Daily> fetchDaily() async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=-6.8694&lon=109.1402&exclude=alerts,minutely&appid=a9192d54a79db76b09f92bbb3deddfe2'));

  if (response.statusCode == 200) {
    return Daily.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load weather');
  }
}
