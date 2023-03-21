

import 'package:bolt/bean/subject_entity.dart';
import 'package:bolt/router.dart';
import 'package:bolt/widget/search_text_field_widget.dart';
import 'package:flutter/material.dart';

class HomePageWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return getTabWeight();
  }
}

var _home_tabs = ['动态', '推荐'];

DefaultTabController getTabWeight() {
  return DefaultTabController(
      initialIndex: 1,
      length: _home_tabs.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                pinned: true,
                expandedHeight: 5.0,
                primary: true,
                titleSpacing: 20.0,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                    color: Colors.white,
                    alignment: const Alignment(0.2, 0.2),
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: SearchTextFieldWidget(
                      hintText: '以诗会友',
                      margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                      onTab: () {
                        MyRouter.push(context, MyRouter.searchPage, '以诗会友');
                      },
                    ),
                  ),
                ),
                bottom: TabBar(
                  tabs: _home_tabs
                      .map((name) => Container(
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    //padding: const EdgeInsets.only(bottom: 40.0),
                  ))
                      .toList()
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          children: _home_tabs.map((name) {
            return SliverContainer(
              name: name
            );
          }).toList(),
        ),
      ));
}

class SliverContainer extends StatefulWidget {
  final String name;

  SliverContainer({Key? key, required this.name}) : super(key: key);

  @override
  State createState() => _SliverContainerState();
}

class _SliverContainerState extends State<SliverContainer> {

  List<Subject>? list;

  @override
  void initState() {
    super.initState();
    if (list == null) {

      // if (_home_tabs[0] == widget.name) {
      //  todo
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return getContentSliver(context, list);
  }

  getContentSliver(BuildContext context, List<Subject>? list) {
    if (list == null || list.isEmpty) {
      return Text('暂无数据');
    }
  }
}
