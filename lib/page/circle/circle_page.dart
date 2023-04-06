import 'package:bolt/constant/constants.dart';
import 'package:bolt/page/circle/title_view.dart';
import 'package:bolt/widget/search_text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/subject_entity.dart';
import '../../router.dart';
import 'my_circle_widget.dart';

class CirclePageWidget extends StatelessWidget {
  const CirclePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String hintText = "加入圈子，追寻共同的理想";
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
            children: <Widget>[
              SearchTextFieldWidget(
                margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                hintText: hintText,
                onTab: () {
                  MyRouter.push(context, MyRouter.searchPage, hintText);
                },
              ),
              Expanded(
                child: _CircleWidget(),
              )
            ],
          )
      ),
    );
  }
}

class _CircleWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CircleWidgetState();
}

class _CircleWidgetState extends State<_CircleWidget> {

  late List<Subject> items = [Subject(true, 1, '1', '2', 1, '23', 1, '233')];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _buildMyCircleBar(),
        ),
        SliverToBoxAdapter(
          child: MyCircleWidget(),
        ),
        SliverToBoxAdapter(
          child: _buildMoreCircleBar(),
        ),
        SliverList(delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return _buildMoreCircle();
            },childCount: 10)
        ),
      ],
    );
  }


  Widget _buildMyCircleBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
      child: Column(
        children: [
          TitleView(
              titleTxt: '我的小组',
              subTxt: '全部',
              onTab: (){}
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildMoreCircleBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          TitleView(
              titleTxt: '探索小组',
              subTxt: '更多',
              onTab: (){}
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 0.2),
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  Widget _buildMoreCircle() {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                width: 50,
                height: 50,
                child: Image.asset(
                  '${Constants.ASSETS_IMG}my.png',
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        '2023年大变革',
                        style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        child: Text(
                          '百年未有之大变局',
                          style: TextStyle(fontSize: 12, color: Color(0xff595959)),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      ),
                      Row(
                        children: [
                          Text('170组员'),
                          Text('80话题')
                        ],
                      )
                    ],
                  )
              ),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                      color: Colors.tealAccent,
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: const Text(
                    '+ 加入',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
              )
            ],
          )
        ],
      )
    );
  }

}
