
import 'package:flutter/foundation.dart';

class Constants {

  static const String ASSETS_IMG = 'assets/images/';

  static const String accessToken = 'accessToken';

  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction  = kReleaseMode;

}