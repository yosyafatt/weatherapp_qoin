import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import '../../cubit/location_cubit.dart';
import '../../models/CurrentWeatherInfo.dart';
import '../../utils/constants.dart';
import '../../utils/sizeconfig.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final CurrentWeatherInfo cwstate;

  const CurrentWeatherWidget(
    this.cwstate, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 8,
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
                            'assets/icons/map-pin-fill.svg',
                            height: propWidth(18),
                          ),
                          SizedBox(width: propWidth(8)),
                          BlocBuilder<LocationCubit, Placemark>(
                            builder: (plctx, plstate) {
                              return Flexible(
                                child: Text(
                                  plstate != null ? plstate.subLocality : '-',
                                  style: TextStyle(
                                    fontSize: propWidth(22),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
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
            Container(
              decoration: ShapeDecoration(
                shape: StadiumBorder(
                  side: BorderSide(color: Colors.white),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: propWidth(8),
                vertical: propHeight(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 6,
                    width: 6,
                    margin: EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    'Updated at --',
                    style: TextStyle(
                      fontSize: propWidth(11),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      'http://openweathermap.org/img/wn/${cwstate != null ? cwstate.current.weather.first.icon : "10d"}@4x.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: propWidth(20),
                        height: propWidth(20),
                        decoration: ShapeDecoration(
                          color: Colors.transparent,
                          shape: CircleBorder(
                            side: BorderSide(
                              color: qTextColor3,
                              width: propWidth(5),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: propWidth(20),
                        ),
                        child: Text(
                          cwstate != null
                              ? cwstate.current.temp.toStringAsFixed(1)
                              : '--',
                          style: TextStyle(
                            fontSize: propHeight(100),
                            height: 1,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${cwstate != null ? cwstate.current.weather.first.main : ''}',
                    style: TextStyle(
                      fontSize: propWidth(22),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '${cwstate != null ? DateFormat('EEEE, MMMM d').format(DateTime.fromMillisecondsSinceEpoch(cwstate.current.dt)) : ''}',
                    style: TextStyle(
                      fontSize: propWidth(12),
                      color: qTextColor3,
                    ),
                  ),
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
                            '${cwstate != null ? (cwstate.current.windSpeed * 3.6).toStringAsFixed(1) : "--"}km/h',
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
                            '${cwstate != null ? (cwstate.current.humidity) : "--"}%',
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
                            'assets/icons/sun-fill.svg',
                            height: propWidth(19),
                          ),
                          SizedBox(height: propHeight(6)),
                          Text(
                            '${cwstate != null ? (cwstate.current.uvi) : "--"}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: propWidth(13),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'UV Index',
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
