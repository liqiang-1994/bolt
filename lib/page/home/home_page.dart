import 'package:bolt/model/recommend_entity.dart';
import 'package:bolt/model/subject_entity.dart';
import 'package:bolt/page/home/blog_conent_widget.dart';
import 'package:bolt/page/home/blog_detail_page.dart';
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
      child: RefreshIndicator(
          onRefresh: () async {
            return Future<void>.delayed(const Duration(seconds: 1));
            },
          notificationPredicate: (notifaction) {
            return true;
            },
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
                        tabs: _homeTabs.map((name) => Container(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            name, style: const TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )).toList()
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
          )
      )
  );
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
      list = [Subject(true, '123', 'https://img1.baidu.com/it/u=3759622882,4011695855&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
          '殷桃小丸子','这个人很懒', '3小时前', 12,     '本人至始至终都是守法积极向上的五好青年，从未发表激进言论。传播世界和平与爱，日行一善积善成德，我始终谨记在心 。希望您能给我一个上gc的机会 我一定会好好珍惜好好把握每一个让大家倾听我发言的机会 传播真善美共同营造一个和谐美满的社会氛围，谢谢！@曹国伟'),
        Subject(false, '123', 'https://img1.baidu.com/it/u=3759622882,4011695855&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
            '殷桃小丸子','这个人很懒', '3小时前', 1000000000, '尊敬的@曹国伟  先生：中午好！给新浪爸爸请安了[老师好][老师好][老师好]'
    '@爱淇毅生517forever  用户本月严格遵守网络规则，无不良操作，希望给其增加阳光信用及qz，恢复其gct。'
    '本人至始至终都是守法积极向上的五好青年，从未发表激进言论。传播世界和平与爱，日行一善积善成德，我始终谨记在心 。希望您能给我一个上gc的机会 我一定会好好珍惜好好把握每一个让大家倾听我发言的机会 传播真善美共同营造一个和谐美满的社会氛围，谢谢！@曹国伟'
    '同时为表达对您的极大尊敬和支持，特此说明如下。'
    '第一，该用户积极参加公益活动，积极捐款，关爱大自然，关爱动物，积极传播“人地和谐”的理念，做到共融共生；'
    '第二，该用户主动参加“每日一善”活动，秉承以爱国主义为核心的民族精神和已科技创新为的时代精神，以个人博爱传播和善精神，积极营造“清宜和谐”的网络氛围'),
        Subject(true, '123', 'https://img1.baidu.com/it/u=3759622882,4011695855&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
            '殷桃小丸子','这个人很懒', '3小时前', 12,     '本人至始至终都是守法积极向上的五好青年，从未发表激进言论。传播世界和平与爱，日行一善积善成德，我始终谨记在心 。希望您能给我一个上gc的机会 我一定会好好珍惜好好把握每一个让大家倾听我发言的机会 传播真善美共同营造一个和谐美满的社会氛围，谢谢！@曹国伟'),
        Subject(false, '123', 'https://img1.baidu.com/it/u=3759622882,4011695855&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
            '殷桃小丸子','这个人很懒', '3小时前', 1000, '尊敬的@曹国伟  先生：中午好！给新浪爸爸请安了[老师好][老师好][老师好]'
                '@爱淇毅生517forever  用户本月严格遵守网络规则，无不良操作，希望给其增加阳光信用及qz，恢复其gct。'
                '本人至始至终都是守法积极向上的五好青年，从未发表激进言论。传播世界和平与爱，日行一善积善成德，我始终谨记在心 。希望您能给我一个上gc的机会 我一定会好好珍惜好好把握每一个让大家倾听我发言的机会 传播真善美共同营造一个和谐美满的社会氛围，谢谢！@曹国伟'
                '同时为表达对您的极大尊敬和支持，特此说明如下。'
                '第一，该用户积极参加公益活动，积极捐款，关爱大自然，关爱动物，积极传播“人地和谐”的理念，做到共融共生；'
                '第二，该用户主动参加“每日一善”活动，秉承以爱国主义为核心的民族精神和已科技创新为的时代精神，以个人博爱传播和善精神，积极营造“清宜和谐”的网络氛围')

      ];

      // if (_home_tabs[0] == widget.name) {
      //  todo
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return getContentSliver(context, list);
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
                //return getItemList(list, index);
                print(index.toString() +'---' + list.length.toString());
                return BlogContentWidget(subject: list[index]);
              })))
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
