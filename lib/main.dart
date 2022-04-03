import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp_qoin/cubit/forecast_cubit.dart';
import 'package:weatherapp_qoin/cubit/weather_cubit.dart';
import 'package:weatherapp_qoin/cubit/location_cubit.dart';
import 'package:weatherapp_qoin/utils/constants.dart';
import './screens/homescreen.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Open Sauce Sans',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: qBaseBackground,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CurrentWeatherCubit>(
            create: (_) => CurrentWeatherCubit()..getCurrentWeatherInfo(),
          ),
          BlocProvider<HourlyForecastCubit>(
            create: (_) => HourlyForecastCubit()..getHourlyForecastInfo(),
          ),
          BlocProvider<LocationCubit>(
            create: (_) => LocationCubit()..getLocation(),
          ),
        ],
        child: HomeScreen(),
      ),
    );
  }
}
