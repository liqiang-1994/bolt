
//Screen utils
import 'package:flutter/cupertino.dart';

class ScreenUtils {

  // 宽度
  static double screenWidth(BuildContext context) {
    MediaQueryData query = MediaQuery.of(context);
    return query.size.width;
  }

  // 高度
  static double screenHeight(BuildContext context) {
    MediaQueryData query = MediaQuery.of(context);
    return query.size.height;
  }
}