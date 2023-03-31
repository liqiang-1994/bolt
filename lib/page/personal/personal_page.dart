import 'package:bolt/constant/constants.dart';
import 'package:bolt/page/personal/personal_collect_widget.dart';
import 'package:bolt/page/personal/personal_img_widget.dart';
import 'package:flutter/material.dart';

class PersonalPageWidget extends StatelessWidget {
  const PersonalPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: false,
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                flexibleSpace: PersonalImgWidget(Image.asset('${Constants.ASSETS_IMG}bg_person_center_default.webp')),
                expandedHeight: 200.0,
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 15),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('https://img1.baidu.com/it/u=3948230997,3769144542&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=503'),
                        radius: 50,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '消息',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),

                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 100.0,
                  alignment: Alignment.center,
                  child: const Text(
                    '暂无消息',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              _divider(),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, top: 10, bottom: 20),
                  child: Text(
                    '我的收藏',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  child: const PersonalCollectWidget(),
                ),
              )
            ],
          ),
        )
    );
  }

  SliverToBoxAdapter _divider() {
    return SliverToBoxAdapter(
      child: Container(
        height: 10.0,
        color: const Color.fromARGB(255, 247, 247, 247),
      ),
    );
  }
}

