import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData mq;
  static double scw;
  static double sch;
  static Orientation or;

  init(BuildContext c) {
    mq = MediaQuery.of(c);
    scw = mq.size.width;
    sch = mq.size.height;
    or = mq.orientation;
  }
}

double propHeight(double h) {
  final double sch = SizeConfig.sch;
  return (h / 812) * sch;
}

double propWidth(double w) {
  final double scw = SizeConfig.scw;
  return (w / 375) * scw;
}
