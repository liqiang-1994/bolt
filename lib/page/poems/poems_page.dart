import 'package:bolt/router.dart';
import 'package:bolt/page/home/poems_tab_bar_widget.dart';
import 'package:bolt/widget/search_text_field_widget.dart';
import 'package:flutter/material.dart';

var _tabNameList = ['唐诗', '宋词', '文集', '元曲', '成语', '歇后语'];
TabController? _tabController;
List<Widget>? tabList;

class PoemsPageWidget extends StatefulWidget {
  const PoemsPageWidget({super.key});

  @override
  State createState() => _PoemsPageState();
}

class _PoemsPageState extends State<PoemsPageWidget> with SingleTickerProviderStateMixin {

  var tabBar;

  @override
  void initState() {
    super.initState();
    tabBar = const PoemsPageTabBar();
    tabList = getTabList();
    _tabController = TabController(length: tabList!.length, vsync: this);

  }

  List<Widget> getTabList() {
    return _tabNameList.map((item) => Text(item, style: TextStyle(fontSize: 15))).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      child: SafeArea(
        child: DefaultTabController(
          length: _tabNameList.length,
          child: _getNestedScrollView(tabBar),
        ),
      ),
    );
  }
}

class PoemsPageTabBar extends StatefulWidget {
  const PoemsPageTabBar({super.key});

  @override
  State createState() => _PoemsPageTabBarState();
}

class _PoemsPageTabBarState extends State<PoemsPageTabBar> {

  late Color selectColor, unSelectColor;
  late TextStyle selectStyle, unSelectStyle;


  @override
  void initState() {
    super.initState();
    selectColor = Colors.black;
    unSelectColor = const Color.fromARGB(255, 177, 177, 176);
    selectStyle = TextStyle(fontSize: 18, color: selectColor);
    unSelectStyle = TextStyle(fontSize: 18, color: unSelectColor);
  }


  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: TabBar(
        tabs: tabList!,
        isScrollable: true,
        controller: _tabController,
        indicatorColor: selectColor,
        labelColor: selectColor,
        labelStyle: selectStyle,
        unselectedLabelColor: unSelectColor,
        unselectedLabelStyle: unSelectStyle,
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }
}

Widget _getNestedScrollView(Widget tabBar) {
  String hintText = '领略中华传统文化的魅力';
  return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: Container(
              color: Colors.brown,
              padding: const EdgeInsets.all(10),
              child: SearchTextFieldWidget(
                hintText: hintText,
                onTab: () {
                  MyRouter.push(context, MyRouter.searchPage, hintText);
                },
                margin: const EdgeInsets.only(left: 5.0, right: 5.0),
              ),
            ),
          ),
          SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: _SliverAppBarDelegate(
                maxHeight: 49,
                minHeight: 49,
                child: Container(
                  color: Colors.white70,
                  child: tabBar,
                )
              ))
        ];
      },
      body: PoemsTabBarView(
        tabController: _tabController!,
      ));
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({required this.minHeight, required this.maxHeight, required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return minHeight != oldDelegate.minHeight ||
    maxHeight != oldDelegate.maxHeight ||
    child != oldDelegate.child;
  }
  
}