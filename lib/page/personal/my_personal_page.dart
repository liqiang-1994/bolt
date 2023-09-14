import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:bolt/constant/constants.dart';
import 'package:flutter/material.dart';

class MyPersonalPage extends StatelessWidget {
  const MyPersonalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Scaffold(
      body: Container(
        child: MyPersonal(
          rpx: rpx,
        ),
      ),
    );
  }
}


class MyPersonal extends StatefulWidget {
  const MyPersonal({Key? key, required this.rpx}) : super(key: key);
  final double rpx;

  @override
  State<MyPersonal> createState() => _MyPersonalPageState();
}

class _MyPersonalPageState extends State<MyPersonal>
    with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  TabController? _tabController;
  bool isShowBlackTitle = false;
  final _tabs = [ "主页","动态"];
  double extraPicHeight = 0;
  double expandHeight = 300;
  late BoxFit fitType;
  late double prev;
  late AnimationController animationController;
  late Animation<double> animation;
  late double rpx = 0;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, initialIndex: 0, vsync: this);
    prev = 0;
    fitType = BoxFit.fitWidth;
    animationController = AnimationController(vsync: this, duration: const Duration(microseconds: 300));
    animation = Tween(begin: 0.0, end: 0.0).animate(animationController);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  updatePicHeight(changed) {
    if (prev == 0) {
      prev = changed;
    }
    extraPicHeight += changed - prev;
    if (extraPicHeight >= 200 * widget.rpx) {
      fitType = BoxFit.fitHeight;
    } else {
      fitType = BoxFit.fitWidth;
    }
    setState(() {
      prev = changed;
      extraPicHeight = extraPicHeight;
      fitType = fitType;
    });
  }

  updateExpandedHeight(height) {
    setState(() {
      print("expandHeight... ${height}");
      expandHeight = height;
    });
  }

  void _showScroll(double offset) {
    if (offset > 100) {
      setState(() {
        isShowBlackTitle = true;
      });
    } else {
      setState(() {
        isShowBlackTitle = false;
      });
    }
  }

  runAnimate() {
    setState(() {
      animation = Tween(begin: extraPicHeight, end: 0.0).animate(animationController)
          ..addListener(() {
            if (extraPicHeight >= widget.rpx * 200) {
              fitType = BoxFit.fitHeight;
            } else {
              fitType = BoxFit.fitWidth;
            }
            setState(() {
              extraPicHeight = animation.value;
              fitType = fitType;
            });
          });
      prev = 0;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerMove: (result){
          updatePicHeight(result.position.dy);
          },
        onPointerUp: (_) {
          runAnimate();
          animationController.forward(from: 0);
        },
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: false ,
              floating: true,
              backgroundColor: Colors.yellow,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              bottom: PreferredSize(
                  preferredSize:  Size.fromHeight(100),
                  child: TabBar(
                    isScrollable: false,
                    indicatorColor: Colors.red,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 2
                      ),
                    ),
                    labelColor: Colors.black,
                    labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    unselectedLabelColor: Colors.black87,
                    unselectedLabelStyle: const TextStyle(fontSize: 13),
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: _tabController,
                    tabs: [
                      Tab(text: _tabs[0]),
                      Tab(text: _tabs[1]),
                    ],
                  )
              ),
              expandedHeight: expandHeight + extraPicHeight,
              flexibleSpace: TopBarWithCallback(
                extraPicHeight: extraPicHeight,
                fitType: fitType,
                updateHeight: updateExpandedHeight,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  color: Colors.blueAccent,
                  child: Text("This is itm $index"),
                  margin: EdgeInsets.symmetric(
                      horizontal: 20 * rpx, vertical: 10 * rpx),
                );
              }, childCount: 80),
            )
          ],
        )
    );
  }
}

class TopBarWithCallback extends StatefulWidget {
  final double extraPicHeight;
  final BoxFit fitType;
  final Function(double) updateHeight;

  TopBarWithCallback({Key? key, required this.extraPicHeight, required this.fitType, required this.updateHeight}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TopBarWithCallbackState();
}

class _TopBarWithCallbackState extends State<TopBarWithCallback> with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return MySliverTopBar(
      extraPicHeight: widget.extraPicHeight,
      fitType: widget.fitType,
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    RenderBox box = context.findRenderObject() as RenderBox;
    double height = box.getMaxIntrinsicHeight(MediaQuery.of(context).size.width);
    widget.updateHeight(height);
  }
}

class MySliverTopBar extends StatelessWidget {
  final double extraPicHeight;
  final BoxFit fitType;
  const MySliverTopBar({Key? key, required this.extraPicHeight, required this.fitType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("${Constants.ASSETS_IMG}temple.jpg",
                width: 750 * rpx,
                height: 300 * rpx + extraPicHeight,
                fit: fitType
            ),
            // Container(
            //     padding: EdgeInsets.only(top: rpx * 20),
            //     height: 120 * rpx,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         IconButton(onPressed: () {},
            //             icon: Icon(Icons.edit_calendar)
            //         ),
            //         Align(
            //           alignment: FractionalOffset.centerRight,
            //           child: GestureDetector(
            //             child: Container(
            //               margin: const EdgeInsets.only(right: 20),
            //               padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
            //               decoration: BoxDecoration(
            //                   color: Colors.orange,
            //                   border: Border.all(color: Colors.orange),
            //                   borderRadius: BorderRadius.circular(12)
            //               ),
            //               child: const Text(
            //                 '+ 关注',
            //                 style: TextStyle(fontSize: 12, color: Colors.black),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //   )
            // ),
            // Flexible(
            //   child: Container(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Align(
            //           alignment: Alignment.centerLeft,
            //           child: Text(
            //             '小提琴与厨师',
            //             style: TextStyle(
            //                 fontSize: 35 * rpx,
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold
            //             ),
            //           ),
            //         ),
            //         Align(
            //           alignment: Alignment.centerLeft,
            //           child: Text("简介：走走停停，不知几何",
            //               style: TextStyle(
            //                 fontSize: 25 * rpx,
            //                 color: Colors.black,
            //               )
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // Expanded(child: Container(
            //  // padding: EdgeInsets.symmetric(horizontal: 40 * rpx, vertical: 30 * rpx),
            //   child: Row(
            //     children: [
            //       NumWithDesc(numm: "100.2w", desc: "获赞",),
            //       NumWithDesc(numm: "15", desc: "关注",),
            //       NumWithDesc(numm: "10.8w", desc: "粉丝",),
            //     ],
            //   ),
            // ))
          ],
        ),
        Positioned(
          top: 200 * rpx + extraPicHeight,
          left: 30 * rpx,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(200 * rpx)
            ),
            width: 200 * rpx,
            height: 200 * rpx,
            padding: EdgeInsets.all(10 * rpx),
            child: CircleAvatar(
            backgroundImage: NetworkImage(
            "https://pic2.zhimg.com/v2-a88cd7618933272ca681f86398e6240d_xll.jpg")
            ),
          ),
        )
      ],
    );
  }
}

class NumWithDesc extends StatelessWidget {
  const NumWithDesc({Key? key, required this.numm, required this.desc}) : super(key: key);
  final String numm;
  final String desc;
  @override
  Widget build(BuildContext context) {
    double rpx=MediaQuery.of(context).size.width / 750;
    double textSize=25*rpx;
    return Padding(
        padding: EdgeInsets.only(right: 20 * rpx),
        child: Row(
          children: <Widget>[
            Text(numm,style: TextStyle(fontSize: textSize, color: Colors.black ,fontWeight: FontWeight.bold)),
            SizedBox(width: 10*rpx),
            Text(desc,style: TextStyle(fontSize: textSize,color: Colors.grey))
          ],
        )
    );
  }
}



