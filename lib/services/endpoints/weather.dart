import 'dart:developer';
import 'package:dio/dio.dart';
import '../../models/CurrentWeatherInfo.dart';
import '../client.dart';

class WeatherApi {
  Dio d = Client().init();

  Future<CurrentWeatherInfo> currentWeather(
      double longitude, double latitude) async {
    try {
      final res = await d.get('&lon=$longitude&lat=$latitude');
      final data = CurrentWeatherInfo.fromJson(res.data);
      return data;
    } on DioError catch (e) {
      String err = e.response.data['message'];
      throw Exception(err);
    }
  }
}
