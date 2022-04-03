import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weatherapp_qoin/cubit/forecast_cubit.dart';
import 'package:weatherapp_qoin/cubit/location_cubit.dart';
import 'package:weatherapp_qoin/cubit/weather_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp_qoin/models/HourlyWeatherInfo.dart';
import 'package:weatherapp_qoin/screens/dailyforecastscreen.dart';
import '../models/CurrentWeatherInfo.dart';
import '../utils/sizeconfig.dart';
import '../utils/constants.dart';
import './widgets/currentweather_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<LocationCubit>().getLocation();
            context.read<CurrentWeatherCubit>().getCurrentWeatherInfo();
            context.read<HourlyForecastCubit>().getHourlyForecastInfo();
          },
          backgroundColor: qBaseBackground,
          child: SingleChildScrollView(
            child: SizedBox(
              height: SizeConfig.sch,
              child: Column(
                children: [
                  BlocBuilder<CurrentWeatherCubit, CurrentWeatherInfo>(
                    builder: (cwctx, cwstate) {
                      return CurrentWeatherWidget(cwstate);
                    },
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: propWidth(32),
                              vertical: propHeight(12),
                            ).copyWith(
                              bottom: propHeight(24),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Today',
                                  style: TextStyle(
                                    fontSize: propWidth(18),
                                    fontWeight: FontWeight.w800,
                                    height: 1,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DailyForecastScreen(),
                                      ),
                                    );
                                  },
                                  customBorder: StadiumBorder(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '7 days',
                                        style: TextStyle(
                                          fontSize: propWidth(12),
                                          color: qTextColor2,
                                          height: 1,
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        size: propWidth(16),
                                        color: qTextColor2,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: BlocBuilder<HourlyForecastCubit,
                                HourlyWeatherInfo>(
                              builder: (hwctx, hwstate) {
                                if (hwstate == null) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.blue[300]),
                                    ),
                                  );
                                } else {
                                  return HourlyForecastListWidget(hwstate);
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HourlyForecastListWidget extends StatelessWidget {
  final HourlyWeatherInfo hwstate;
  const HourlyForecastListWidget(
    this.hwstate, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, index) => SizedBox(
        width: propWidth(12),
      ),
      itemCount: hwstate.hourly.length,
      itemBuilder: (_, index) {
        return Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(propWidth(27)),
              side: BorderSide(
                color: Color(0xFF272727),
              ),
            ),
            // color: Colors.white30,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: propWidth(6),
            vertical: propHeight(12),
          ),
          margin: EdgeInsets.only(left: index == 0 ? propWidth(32) : 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${hwstate.hourly[index].temp.toStringAsFixed(0)}°',
                style: TextStyle(
                  fontSize: propWidth(20),
                  fontWeight: FontWeight.w700,
                ),
              ),
              Expanded(
                child: Container(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      'http://openweathermap.org/img/wn/${hwstate.hourly[index].weather.first.icon}@2x.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(
                '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(hwstate.hourly[index].dt * 1000))}',
                style: TextStyle(
                  fontSize: propWidth(12),
                  color: qTextColor2,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
