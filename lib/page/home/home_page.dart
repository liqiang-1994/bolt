import 'package:bolt/bean/subject_entity.dart';
import 'package:bolt/constant/constants.dart';
import 'package:bolt/router.dart';
import 'package:bolt/widget/search_text_field_widget.dart';
import 'package:flutter/material.dart';

class HomePageWidget extends StatelessWidget {

  const HomePageWidget({super.key});

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
                titleSpacing: 0,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                    color: Colors.white,
                    alignment: const Alignment(0.2, 0.2),
                    padding: const EdgeInsets.only(left: 50, right: 50, bottom: 10),
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
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ))
                      .toList()
                ),
                actions: [
                  IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.add,size: 40),
                    tooltip: '创作',
                    color: Colors.red,
                  )
                ],
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
      list = [Subject(1, true)];

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
      return const Text('暂无数据');
    }
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            key: PageStorageKey<String>(widget.name),
            slivers: [
              SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
              SliverList(delegate: SliverChildBuilderDelegate(((BuildContext context, int index) {
                return getItemList(list, index);
          }), childCount: list.length))
            ],
          );
        },
      ),
    );
  }

  getItemList(List<Subject> list, int index) {
    Subject item = list[index];
    return Container(
      height: 300,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(
        left: 13,
        right: 13,
        top: 13,
        bottom: 11
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: const [
              CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage('${Constants.ASSETS_IMG}home.png'),
                backgroundColor: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('test'),
              ),
              Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.grey,
                      size: 18,
                    ),
                  )
              )
            ],
          ),
          // Expanded(
          //   child: Container(
          //     child: ,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  '${Constants.ASSETS_IMG}ic_vote.png',
                  width: 25.0,
                  height: 25.0,
                ),
                Image.asset(
                  '${Constants.ASSETS_IMG}ic_vote.png',
                  width: 20.0,
                  height: 20.0,
                ),
                Image.asset(
                  '${Constants.ASSETS_IMG}ic_vote.png',
                  width: 25.0,
                  height: 25.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  getItemCenterImg(Subject item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

      ],
    );
  }
}
