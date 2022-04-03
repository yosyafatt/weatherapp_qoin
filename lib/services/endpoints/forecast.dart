import 'package:dio/dio.dart';
import 'package:weatherapp_qoin/services/client.dart';
import '../../models/DailyWeatherInfo.dart';
import '../../models/HourlyWeatherInfo.dart';

class ForecastApi {
  Dio d = Client().init();

  Future<DailyWeatherInfo> dailyForecast(
      double longitude, double latitude) async {
    try {
      final res = await d.get('&lon=$longitude&lat=$latitude');
      final data = DailyWeatherInfo.fromJson(res.data);
      return data;
    } on DioError catch (e) {
      String err = e.response.data['message'];
      throw Exception(err);
    }
  }

  Future<HourlyWeatherInfo> hourlyForecast(
      double longitude, double latitude) async {
    try {
      final res = await d.get('&lon=$longitude&lat=$latitude');
      final data = HourlyWeatherInfo.fromJson(res.data);
      return data;
    } on DioError catch (e) {
      String err = e.response.data['message'];
      throw Exception(err);
    }
  }
}
