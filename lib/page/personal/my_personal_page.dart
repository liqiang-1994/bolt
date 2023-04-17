import 'package:bolt/constant/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPersonalPage extends StatefulWidget {
  const MyPersonalPage({Key? key}) : super(key: key);

  @override
  State<MyPersonalPage> createState() => _MyPersonalPageState();
}

class _MyPersonalPageState extends State<MyPersonalPage>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  TabController? _tabController;
  bool isShowBlackTitle = false;
  final _tabs = [ "主页","动态"];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, initialIndex: 0, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification && notification.depth ==0) {
                _showScroll(notification.metrics.pixels);
              }
              return true;
            },
            child: Stack(
              children: [
                NestedScrollView(
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                      return [
                        SliverOverlapAbsorber(
                          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                          sliver: SliverAppBar(
                            leading: IconButton(
                              iconSize: 30,
                              icon: const Icon(Icons.arrow_back_ios_new, size: 30, color: Colors.grey),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            title: Text("小提琴", style: TextStyle(color: Colors.black),),
                            centerTitle: false,
                            pinned: true,
                            floating: false,
                            snap: false,
                            primary: true,
                            expandedHeight: 200,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            //是否显示阴影，直接取值innerBoxIsScrolled，展开不显示阴影，合并后会显示
                            forceElevated: innerBoxIsScrolled,
                            actions: [
                              IconButton(
                                iconSize: 30,
                                icon: const Icon(Icons.search_sharp, size: 30, color: Colors.grey),
                                onPressed: () {
                                },
                              ),
                              IconButton(
                                iconSize: 30,
                                icon: const Icon(Icons.more_horiz_sharp, size: 30, color: Colors.grey),
                                onPressed: () {
                                },
                              ),
                            ],
                            flexibleSpace: FlexibleSpaceBar(
                              collapseMode: CollapseMode.pin,
                              background: Column(
                                children: [
                                  // Stack(
                                  //   children: [
                                  //
                                  //   ],
                                  // ),
                                  Container(
                                    height: 130,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                Constants.ASSETS_IMG+"ic_personinfo_bg.png"
                                            ),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 25),

                                        )
                                      ],
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage('${Constants.ASSETS_IMG}my.png'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ];
                    },
                    body: TabBarView(
                      controller: _tabController,
                      children: [
                        Text("data"),
                        Text("1")
                      ],
                    ))
              ],
            ),
          )
        ],
      ),

    );
  }
}
