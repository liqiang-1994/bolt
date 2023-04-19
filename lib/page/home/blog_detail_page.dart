import 'dart:math';

import 'package:bolt/model/subject_entity.dart';
import 'package:bolt/page/home/blog_detail_head_widget.dart';
import 'package:bolt/page/home/blog_detail_top_widget.dart';
import 'package:flutter/material.dart';

import '../../model/comment_model.dart';

class BlogDetailWidget extends StatefulWidget {
  const BlogDetailWidget({Key? key, required this.subject}) : super(key: key);
  final Subject subject;

  @override
  State<BlogDetailWidget> createState() => _BlogDetailWidgetState(subject: subject);
}

class _BlogDetailWidgetState extends State<BlogDetailWidget> with SingleTickerProviderStateMixin {
  final List<String> _tabList = ['点赞', '评论'];

  Subject subject;
  TabController? _tabController;
  ScrollController scrollController = ScrollController();
  List<CommentModel> commentList = [];
  bool commentLoding = false;
  bool commentHasMore = true;
  double opacity = 0.0;
  int commentCurrPage = 1;

  _BlogDetailWidgetState({required this.subject});

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);
    scrollController.addListener(() {
      setState(() {
        if (scrollController.offset > 50) {
          opacity = 1.0;
        } else {
          opacity = 0.0;
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
            body: Column(
                children: [
                  Container(color: Colors.white, child: BlogDetailHeadWidget('ceff', opacity: opacity)),
                  Expanded(child: NestedScrollView(
                    controller: scrollController,
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                          child: Container(height: 8, color: const Color(0xffEFEFEF))),
                      SliverToBoxAdapter(
                        child: Container(
                          color: Colors.white,
                          child: BlogDetailTopWidget(subject: subject),
                        ),
                      ),
                      SliverPersistentHeader(
                          pinned: true,
                          floating: false,
                          delegate: _SliverCommentBarDelegate(
                              minHeight: 51,
                              maxHeight: 51,
                              child:Container(
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          color: Colors.white,
                                          height: 50,
                                          child: TabBar(
                                            isScrollable: true,
                                            indicatorColor: Colors.red,
                                            indicator: const UnderlineTabIndicator(
                                              borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 1
                                              ),
                                            ),
                                            labelColor: Colors.black,
                                            labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                            unselectedLabelColor: Colors.black87,
                                            unselectedLabelStyle: const TextStyle(fontSize: 13),
                                            indicatorSize: TabBarIndicatorSize.label,
                                            controller: _tabController,
                                            tabs: [
                                              Tab(text: '${_tabList[0]} ${widget.subject.up}'),
                                              Tab(text: '${_tabList[1]} ${widget.subject.up}'),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          margin: const EdgeInsets.only(right: 5),
                                          child: Row(
                                            children: [
                                              const Text('转发', style: TextStyle(color: Colors.black, fontSize: 14)),
                                              Text(widget.subject.up.toString(), style: const TextStyle(color: Colors.black, fontSize: 14))
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                          )
                      )
                    ];
                  },
                    body: Text('ce'),
                    // body: TabBarView(
                    //   controller: _tabController,
                    //   children: [
                    //
                    //   ],
                    // ),
                  ))
                ]
            )
        ),
      )
    );
  }

  Widget commentWidget() {
    return NotificationListener<ScrollNotification>(
        child: ListView.builder(
          padding: const EdgeInsets.all(0.0),
          itemBuilder: (BuildContext context, int index) {

            },
          itemCount: commentList.isEmpty ? 1 : commentList.length + 2,
        )
    );
  }

  // Widget commentItemWidget(BuildContext context, int index) {
  //   return Switch(value: , onChanged: onChanged)
  // }

  // Widget upWidget() {
  //   return NotificationListener<ScrollNotification>(
  //       child: ListView.builder(itemBuilder: itemBuilder)
  //   )
  // }
}

class _SliverCommentBarDelegate extends SliverPersistentHeaderDelegate {

  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverCommentBarDelegate({required this.minHeight, required this.maxHeight, required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => max(minHeight, maxHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant _SliverCommentBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight
        || minHeight != oldDelegate.minHeight
        || child != oldDelegate.child;
  }
}

