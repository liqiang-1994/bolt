import 'package:bolt/model/recommend_entity.dart';
import 'package:bolt/model/subject_entity.dart';
import 'package:bolt/page/home/recommend_list_view.dart';
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

const _homeTabs = ['动态', '推荐'];

DefaultTabController getTabWeight() {
  return DefaultTabController(
      initialIndex: 1,
      length: _homeTabs.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                pinned: true,
                expandedHeight: 25.0,
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
                  tabs: _homeTabs
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
          children: _homeTabs.map((name) {
            return SliverContainer(
              name: name
            );
          }).toList(),
        ),
      ));
}

class SliverContainer extends StatefulWidget {
  final String name;

  const SliverContainer({Key? key, required this.name}) : super(key: key);

  @override
  State createState() => _SliverContainerState();
}

class _SliverContainerState extends State<SliverContainer> with TickerProviderStateMixin {

  List<Subject>? list;
  AnimationController? animationController;
  List<RecommendEntity> recommendList = RecommendEntity.recommendList;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    if (list == null) {
      list = [Subject(1, true)];

      // if (_home_tabs[0] == widget.name) {
      //  todo
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('1'),
        Text('2')
      ],
    );
   // return getContentSliver(context, list);
  }


  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
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
          }), childCount: recommendList.length))
            ],
          );
        },
      ),
    );
  }

  getItemList(List<Subject> list, int index) {
    //Subject item = list[index];
    final count = 5;
    final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController!,
            curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn)));
    animationController!.forward();
    return RecommendListView(
        callback: (){},
    recommendEntity: recommendList[index],
    animation: animation,
    animationController: animationController,);
  }

  getItemCenterImg(Subject item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

      ],
    );
  }
}
