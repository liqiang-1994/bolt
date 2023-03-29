import 'package:bolt/page/circle/circle_page.dart';
import 'package:bolt/page/home/home_page.dart';
import 'package:bolt/page/poems/poems_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../model/tabicon_entity.dart';

class ContainerWidget extends StatefulWidget {

  const ContainerWidget({Key? key}) : super(key: key);

  @override
  State createState() => _ContainerState();
}

class _ContainerState extends State<ContainerWidget> {

  late List<Widget> pages;
  final defaultItemColor = const Color.fromARGB(255, 125, 125, 125);
  int _selectIndex = 0;
  List<TabIconEntity> itemNames = TabIconEntity.tabIconsList;
  late List<BottomNavigationBarItem> itemList;

  @override
  void initState() {
    super.initState();
    for (var tab in itemNames) {
      tab.isSelected = false;
    }
    itemNames[0].isSelected = true;
    pages = [
      const HomePageWidget(),
      const PoemsPageWidget(),
      const CirclePageWidget(),
    ];
    itemList = itemNames
          .map((item) => BottomNavigationBarItem(
          icon: Image.asset(
            item.normalIcon,
            width: 30,
            height: 30,
          ),
        activeIcon: Image.asset(item.activeIcon, width: 30, height: 30),
        label: item.name
      )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _getPagesWidget(0),
          _getPagesWidget(1),
          _getPagesWidget(2)
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      bottomNavigationBar: BottomNavigationBar(
        items: itemList,
        onTap: (int index) {
          setState(() {
            _selectIndex = index;
          });
        },
        iconSize: 25,
        currentIndex: _selectIndex,
        fixedColor: Colors.cyan,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  //Stack(层叠布局)+Offstage组合，解决状态被重置问题
  Widget _getPagesWidget(int index) {
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
        child: pages[index],
      ),
    );
  }

  @override
  void didUpdateWidget(ContainerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (kDebugMode) {
      print('didUpdateWidget');
    }
  }
}