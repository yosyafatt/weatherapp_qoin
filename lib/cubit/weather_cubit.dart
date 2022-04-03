import 'package:geolocator/geolocator.dart';
import 'package:weatherapp_qoin/models/CurrentWeatherInfo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp_qoin/services/endpoints/weather.dart';
import './location_cubit.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherInfo> {
  final w = WeatherApi();

  CurrentWeatherCubit() : super(null);

  void getCurrentWeatherInfo() async {
    final co = await determineLocation();
    if (co is Position) {
      emit(await w.currentWeather(co.longitude, co.latitude));
    }
  }
}
