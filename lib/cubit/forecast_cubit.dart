import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp_qoin/cubit/location_cubit.dart';
import 'package:weatherapp_qoin/models/DailyWeatherInfo.dart';
import 'package:weatherapp_qoin/models/HourlyWeatherInfo.dart';
import 'package:weatherapp_qoin/services/endpoints/forecast.dart';

class DailyForecastCubit extends Cubit<DailyWeatherInfo> {
  ForecastApi fc = ForecastApi();
  DailyForecastCubit() : super(null);

  void getDailyForecastInfo() async {
    final co = await determineLocation();
    if (co is Position) {
      emit(await fc.dailyForecast(co.longitude, co.latitude));
    }
  }
}

class HourlyForecastCubit extends Cubit<HourlyWeatherInfo> {
  ForecastApi fc = ForecastApi();
  HourlyForecastCubit() : super(null);

  void getHourlyForecastInfo() async {
    final co = await determineLocation();

    if (co is Position) {
      emit(await fc.hourlyForecast(co.longitude, co.latitude));
    }
  }
}
