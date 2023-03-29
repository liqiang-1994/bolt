
import 'package:bolt/constant/constants.dart';
import 'package:flustars/flustars.dart';

/// Log utility class
class Log {

  static const String tag = 'DEER-LOG';

  static void init() {
    LogUtil.init(isDebug: !Constants.inProduction, maxLen: 512);
  }

  static void d(String msg, {String tag = tag}) {
    if (!Constants.inProduction) {
      LogUtil.v(msg, tag: tag);
    }
  }

  static void e(String msg, {String tag = tag}) {
    if (!Constants.inProduction) {
      LogUtil.e(msg, tag: tag);
    }
  }


}