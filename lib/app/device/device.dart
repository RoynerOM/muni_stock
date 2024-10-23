import 'package:flutter/material.dart';
import 'package:muni_stock/core/utils/helpers.dart';

class Device {
  static void getInfo(context) {
    double w = widthContainer(context);
    if (w == 540) return console('SM'); //sm
    if (w == 720) return console('MD'); //md
    if (w == 960) return console('LG'); //lg
    if (w == 1140) return console('XL'); //xl
    if (w == 1320) return console('SM'); //xxl
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenDensity(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  static bool isSmallScreen(BuildContext context) {
    return screenWidth(context) < 600;
  }

  static bool isMediumScreen(BuildContext context) {
    return screenWidth(context) >= 600 && screenWidth(context) < 1024;
  }

  static bool isLargeScreen(BuildContext context) {
    return screenWidth(context) >= 1024;
  }

  static Orientation orientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  static double widthContainer(BuildContext context) {
    double w = Device.screenWidth(context);
    if (w < 576) return w;
    if (w >= 576 && w < 768) return 540;
    if (w >= 768 && w < 992) return 720;
    if (w >= 992 && w < 1200) return 960;
    if (w >= 1200 && w < 1400) return 1140;
    if (w >= 1400) return 1320;
    return w;
  }

  static double? span(
    BuildContext context, {
    int? xs = 12,
    int? sm = 12,
    int? md = 12,
    int? lg = 12,
    int? xl = 12,
    int? xxl = 12,
    double? gutter = 24,
  }) {
    double w = widthContainer(context);
    double percent = (w / 12);
    if (w == 540) return percent * sm! - gutter!; //sm
    if (w == 720) return percent * md! - gutter!; //md
    if (w == 960) return percent * lg! - gutter!; //lg
    if (w == 1140) return percent * xl! - gutter!; //xl
    if (w == 1320) return (percent * xxl!) - gutter!; //xxl
    return percent * xs! - gutter!; //col
  }
}
