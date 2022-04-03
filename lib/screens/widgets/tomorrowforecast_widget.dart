import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherapp_qoin/models/DailyWeatherInfo.dart';
import 'package:weatherapp_qoin/utils/constants.dart';
import 'package:weatherapp_qoin/utils/sizeconfig.dart';

class TomorrowForecastWidget extends StatelessWidget {
  final DailyWeatherInfo dwstate;
  const TomorrowForecastWidget(
    this.dwstate, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: qLinearGradientBackground,
          border: Border.all(color: Colors.white38, width: 2),
          borderRadius: BorderRadius.circular(propWidth(65)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: propWidth(30),
              ).copyWith(
                top: propHeight(30),
                bottom: propHeight(11),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/icons/apps-fill.svg',
                    width: propWidth(24),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/calendar-line.svg',
                            height: propWidth(18),
                          ),
                          SizedBox(width: propWidth(8)),
                          Flexible(
                            child: Text(
                              '7 Days',
                              style: TextStyle(
                                fontSize: propWidth(22),
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/more-fill.svg',
                    width: propWidth(24),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Image.network(
                      'http://openweathermap.org/img/wn/${dwstate != null ? dwstate.daily[1].weather.first.icon : "10d"}@4x.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tomorrow',
                          style: TextStyle(
                            fontSize: propWidth(18),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: propHeight(8)),
                        Padding(
                          padding: EdgeInsets.only(
                            right: propWidth(15),
                          ),
                          child: Text.rich(
                            TextSpan(
                              text: dwstate != null
                                  ? '${dwstate.daily[1].temp.day.toStringAsFixed(0)}'
                                  : "--",
                              children: [
                                TextSpan(
                                  text: dwstate != null
                                      ? '/${dwstate.daily[1].temp.night.toStringAsFixed(0)}°'
                                      : "/--°",
                                  style: TextStyle(
                                    fontSize: propWidth(36),
                                    color: Colors.white54,
                                  ),
                                ),
                              ],
                            ),
                            style: TextStyle(
                              fontSize: propHeight(66),
                              height: 1,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          dwstate != null
                              ? '${toBeginningOfSentenceCase(dwstate.daily[1].weather.first.description)}'
                              : '',
                          style: TextStyle(
                            fontSize: propWidth(16),
                            color: Colors.white54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: propWidth(30),
              ).copyWith(
                top: propHeight(11),
                bottom: propHeight(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/windy-line.svg',
                            height: propWidth(19),
                          ),
                          SizedBox(height: propHeight(6)),
                          Text(
                            '${dwstate != null ? dwstate.daily[1].windSpeed.toStringAsFixed(1) : "--"}km/h',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: propWidth(13),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Wind',
                            style: TextStyle(
                              color: qTextColor1,
                              fontSize: propWidth(12),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/drop-fill.svg',
                            height: propWidth(19),
                          ),
                          SizedBox(height: propHeight(6)),
                          Text(
                            '${dwstate != null ? dwstate.daily[1].humidity : "--"}%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: propWidth(13),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Humidity',
                            style: TextStyle(
                              color: qTextColor1,
                              fontSize: propWidth(12),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/rainy-line.svg',
                            height: propWidth(19),
                          ),
                          SizedBox(height: propHeight(6)),
                          Text(
                            '${dwstate != null ? (dwstate.daily[1].pop * 100).toStringAsFixed(0) : "--"}%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: propWidth(13),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Chance of Rain',
                            style: TextStyle(
                              color: qTextColor1,
                              fontSize: propWidth(12),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
