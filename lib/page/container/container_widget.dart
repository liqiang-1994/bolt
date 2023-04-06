import 'package:bolt/page/circle/circle_page.dart';
import 'package:bolt/page/home/blog_detail_page.dart';
import 'package:bolt/page/home/home_page.dart';
import 'package:bolt/page/mine/mine_page.dart';
import 'package:bolt/page/personal/my_page.dart';
import 'package:bolt/page/personal/personal_page.dart';
import 'package:bolt/page/poems/poems_page.dart';
import 'package:bolt/page/search/search_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../model/subject_entity.dart';
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
  Subject subject = Subject(false, '123', 'https://img1.baidu.com/it/u=3759622882,4011695855&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
      '殷桃小丸子','这个人很懒', '3小时前', 1000000, '尊敬的@曹国伟  先生：中午好！给新浪爸爸请安了[老师好][老师好][老师好]'
          '@爱淇毅生517forever  用户本月严格遵守网络规则，无不良操作，希望给其增加阳光信用及qz，恢复其gct。'
          '本人至始至终都是守法积极向上的五好青年，从未发表激进言论。传播世界和平与爱，日行一善积善成德，我始终谨记在心 。希望您能给我一个上gc的机会 我一定会好好珍惜好好把握每一个让大家倾听我发言的机会 传播真善美共同营造一个和谐美满的社会氛围，谢谢！@曹国伟'
          '同时为表达对您的极大尊敬和支持，特此说明如下。'
          '第一，该用户积极参加公益活动，积极捐款，关爱大自然，关爱动物，积极传播“人地和谐”的理念，做到共融共生；'
          '第二，该用户主动参加“每日一善”活动，秉承以爱国主义为核心的民族精神和已科技创新为的时代精神，以个人博爱传播和善精神，积极营造“清宜和谐”的网络氛围');

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
      const MinePageWidget()
     // SearchPage()
      //const MyPage(),
      //const PersonalPageWidget()
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
          _getPagesWidget(2),
          _getPagesWidget(3)
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