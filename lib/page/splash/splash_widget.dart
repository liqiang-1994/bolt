import 'dart:async';

import 'package:bolt/constant/constants.dart';
import 'package:bolt/page/container/container_widget.dart';
import 'package:bolt/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State createState() => _SplashWidget();
}

class _SplashWidget extends State<SplashWidget> {

  bool showAd = false;
  var container = const ContainerWidget();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Offstage(
          offstage: showAd,
          child: container,
        ),
        Offstage(
          offstage: !showAd,
          child: Stack(
            children: [
              FlutterUnionad.splashAdView(
                  mIsExpress: true,
                  androidCodeId: '888200049',
                  iosCodeId: '888200049',
                  //是否支持Deeplink
                  supportDeepLink: true,
                  expressViewHeight: MediaQuery.of(context).size.height,
                  expressViewWidth: MediaQuery.of(context).size.width,
                  //控制下载APP前是否弹出二次确认弹窗
                  downloadType: FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
                  //用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，
                  adLoadType: FlutterUnionadLoadType.PRELOAD,
                  //是否隐藏跳过按钮(当影藏的时候显示自定义跳过按钮) 默认显示
                  hideSkip: false,
                  callBack: FlutterUnionadSplashCallBack(
                      onShow: () {
                        print('on show');
                        setState(() => showAd = false);
                      },
                      onFinish: () {
                        print('on finish');
                        setState(() => showAd = false);
                      },
                      onClick: () {
                        print('on click');
                      },
                      onFail: (err) {
                        print('on fail $err');
                        setState(() => showAd = false);
                      },
                      onSkip: () {
                        print('on skip');
                      }
                  )
              ),
            ]
          ),
        ),
        // Offstage(
        //   offstage: !showAd,
        //   child: Container(
        //     color: Colors.white,
        //     width: ScreenUtils.screenWidth(context),
        //     height: ScreenUtils.screenHeight(context),
        //     child: Stack(
        //       children: [
        //         Align(
        //           alignment: const Alignment(0.0, 0.0),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               CircleAvatar(
        //                 radius: ScreenUtils.screenWidth(context) / 3,
        //                 backgroundColor: Colors.white,
        //                 backgroundImage: const AssetImage('${Constants.ASSETS_IMG}home.png'),
        //               ),
        //               const Padding(
        //                 padding: EdgeInsets.only(top: 20),
        //                 child: Text(
        //                   '诗词好助手',
        //                   style: TextStyle(fontSize: 15, color: Colors.black),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         SafeArea(
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Align(
        //                   alignment: const Alignment(1.0, 0.0),
        //                   child: Container(
        //                     margin: const EdgeInsets.only(right: 30.0, top: 20.0),
        //                     padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
        //                     decoration: const BoxDecoration(
        //                       color: Color(0xffEDEDED),
        //                       borderRadius: BorderRadius.all(Radius.circular(10.0))
        //                     ),
        //                     child: CountDownWidget(
        //                       whenCountDownFinishCall: (bool value) {
        //                         if (value) {
        //                           setState(() {
        //                             showAd = false;
        //                           });
        //                         }
        //                       },
        //                     ),
        //                   ),
        //                 ),
        //                 const Padding(
        //                   padding: EdgeInsets.only(left: 10.0),
        //                   child: Text(
        //                     'Hi,您好',
        //                     style: TextStyle(
        //                       color: Colors.cyan,
        //                       fontSize: 30.0,
        //                       fontWeight: FontWeight.bold
        //                     ),
        //                   ),
        //                 )
        //               ],
        //             ))
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }
}

class CountDownWidget extends StatefulWidget {
  final whenCountDownFinishCall;

  const CountDownWidget({Key? key, required this.whenCountDownFinishCall}) : super(key: key);

  @override
  State createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {

  var _seconds = 5;
  late Timer _timer;


  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          widget.whenCountDownFinishCall(true);
          _cancelTimer();
        },
        child: Text(
          '跳过 $_seconds',
          style: const TextStyle(fontSize: 17.0),

        ),
      // style: ButtonStyle(
      //   shape: MaterialStateProperty.all(
      //     RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(50)
      //     )
      //   )
      // ),
    );
    return Text(
      '$_seconds',
      style: const TextStyle(fontSize: 17.0),

    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
      if (_seconds <= 1) {
        widget.whenCountDownFinishCall(true);
        _cancelTimer();
        return;
      }
      _seconds--;
    });
  }

  void _cancelTimer() {
    _timer.cancel();
  }
}