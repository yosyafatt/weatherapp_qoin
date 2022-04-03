import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherapp_qoin/cubit/forecast_cubit.dart';
import 'package:weatherapp_qoin/models/DailyWeatherInfo.dart';
import 'package:weatherapp_qoin/utils/constants.dart';
import 'package:weatherapp_qoin/utils/sizeconfig.dart';
import 'package:intl/intl.dart';
import './widgets/tomorrowforecast_widget.dart';

class DailyForecastScreen extends StatelessWidget {
  const DailyForecastScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider<DailyForecastCubit>(
      create: (context) => DailyForecastCubit()..getDailyForecastInfo(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<DailyForecastCubit, DailyWeatherInfo>(
              builder: (dwctx, dwstate) {
                return Column(
                  children: [
                    TomorrowForecastWidget(dwstate),
                    dwstate != null
                        ? ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                              horizontal: propWidth(32),
                            ),
                            separatorBuilder: (context, index) =>
                                Divider(height: 8),
                            itemCount: dwstate.daily.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '${DateFormat('EEE').format(DateTime.fromMillisecondsSinceEpoch(dwstate.daily[index].dt * 1000))}',
                                      style: TextStyle(
                                        fontSize: propWidth(16),
                                        color: qTextColor4,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Image.network(
                                          'http://openweathermap.org/img/wn/${dwstate.daily[index].weather.first.icon}@2x.png',
                                          fit: BoxFit.cover,
                                          height: propWidth(64),
                                        ),
                                        Text(
                                          '${dwstate.daily[index].weather.first.main}',
                                          style: TextStyle(
                                            fontSize: propWidth(16),
                                            color: qTextColor4,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                        text:
                                            '${dwstate.daily[index].temp.day.toStringAsFixed(0)}°',
                                        children: [
                                          TextSpan(
                                            text:
                                                '/${dwstate.daily[index].temp.night.toStringAsFixed(0)}°',
                                            style: TextStyle(
                                              color: qTextColor4,
                                            ),
                                          ),
                                        ],
                                        style: TextStyle(
                                          fontSize: propWidth(16),
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ],
                              );
                            },
                          )
                        : AspectRatio(
                            aspectRatio: 2 / 1,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
