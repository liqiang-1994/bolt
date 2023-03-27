
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PoemsTabBarView extends StatelessWidget {

  final TabController tabController;


  PoemsTabBarView({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewList = [
      Page1(),
      Page2(),
      Page1(),
      Page2(),
      Page1(),
      Page2()
    ];
    return TabBarView(
      children: viewList,
      controller: tabController,
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build Page1');

    return Center(
      child: Text('Page1'),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build Page2');
    return Center(
      child: Text('Page2'),
    );
  }
}