import 'package:bolt/config/interceptor.dart';
import 'package:bolt/page/container/camera_scan.dart';
import 'package:bolt/page/splash/splash_widget.dart';
import 'package:bolt/router.dart';
import 'package:bolt/util/permission_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool initAd = false;
  MyApp({super.key}) {
    initDio();
    _initRegister();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: MyRouter.router,
    );
  }

  void initDio() {
    //DioManager.instance.init();
    final List<Interceptor> interceptorList = <Interceptor>[];
    //Add authentication request headers
    interceptorList.add(AuthInterceptor());
  }

  void _initRegister() async {
    initAd = await FlutterUnionad.register(
      //穿山甲广告 Android appid 必填
        androidAppId: "5381145",
        //穿山甲广告 ios appid 必填
        iosAppId: "5381145",
        //使用TextureView控件播放视频,默认为SurfaceView,当有SurfaceView冲突的场景，可以使用TextureView 选填
        useTextureView: false,
        //appname 必填
        appName: '诗友',
        //"unionad_test",
        //是否允许sdk展示通知栏提示 选填
        allowShowNotify: true,
        //是否在锁屏场景支持展示广告落地页 选填
        allowShowPageWhenScreenLock: true,
        //是否显示debug日志
        debug: true,
        //是否支持多进程，true支持 选填
        supportMultiProcess: true,
        //是否开启个人性推荐 选填
        personalise: FlutterUnionadPersonalise.open,
        //允许直接下载的网络状态集合 选填
        directDownloadNetworkType: [
          FlutterUnionadNetCode.NETWORK_STATE_2G,
          FlutterUnionadNetCode.NETWORK_STATE_3G,
          FlutterUnionadNetCode.NETWORK_STATE_4G,
          FlutterUnionadNetCode.NETWORK_STATE_WIFI
        ]
    );
    print("sdk初始化 $initAd");
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          backgroundColor: Colors.white,
          //colorScheme: ColorScheme
        ),
        home: const Scaffold(
          body: SplashWidget(),
        )
    );
  }
}