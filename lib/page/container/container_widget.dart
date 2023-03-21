import 'package:bolt/page/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerWidget extends StatefulWidget {

  ContainerWidget({Key? key}) : super(key: key);

  @override
  State createState() => _ContainerState();
}

class _Item {
  String name, activeIcon, normalIcon;
  _Item(this.name, this.activeIcon, this.normalIcon);
}

class _ContainerState extends State<ContainerWidget> {

  List<Widget> pages =  [HomePageWidget()];
  final defaultItemColor = const Color.fromARGB(255, 125, 125, 125);

  int _selectIndex = 0;

  final itemNames = [
    _Item('首页', 'assets/images/tab_home_active.png',
        'assets/images/tab_home_normal.png'),
    _Item('书影', 'assets/images/tab_profile_active.png',
        'assets/images/tab_profile_normal.png'),
  ];
  late List<BottomNavigationBarItem> itemList;


  @override
  void initState() {
    super.initState();
    if (pages == null) {
      pages = [HomePageWidget()];
    }
    //pages ??= [HomePageWidget()];
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
          _getPagesWidget(0)
        ],
      ),
    backgroundColor: const Color.fromARGB(255, 248, 248, 248),

    );
  }

  Widget _getPagesWidget(int index) {
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
        child: pages[index],
      ),
    );
  }
}