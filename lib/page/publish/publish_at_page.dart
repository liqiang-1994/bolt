
import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/at_user_model.dart';

class PublishAtPage extends StatefulWidget {
  const PublishAtPage({Key? key}) : super(key: key);

  @override
  State<PublishAtPage> createState() => _PublishAtPageState();
}

class _PublishAtPageState extends State<PublishAtPage> {
  List<AtUserModel> recommendList = [];
  List<AtUserModel> otherList = [];

  int itemHeight = 60;
  int suspensionHeight = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Color(0xffffffff),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, size: 20) ,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('选择好友', style: TextStyle(fontSize: 15, color: Colors.black)),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 8),
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 5, top: 2),
                        child: Icon(Icons.search_rounded, size: 10),
                      ),
                      const Text('搜索', maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Color(0xffee565656), fontSize: 15))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: AzListView(
              data: otherList,
              itemCount: otherList.length,
              susItemHeight: 20,
              itemBuilder: (BuildContext context, int index) {
                return _buildListView(otherList[index]);
              },
              susItemBuilder: (BuildContext context, int index) {
                return _buildListView(recommendList[index]);
              },
              indexBarData: SuspensionUtil.getTagIndexList(otherList),
            ),
          )
        ],
      )
    );
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      height: suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 15),
      color: Colors.white,
      alignment: Alignment.centerLeft,
      child: Text(
        susTag,
        softWrap: false,
        style: const TextStyle(fontSize: 14, color: Color(0xff999999)),
      ),
    );
  }
  
  Widget _buildListView(AtUserModel userModel) {
    return Column(
      children: [
        Offstage(
          offstage: userModel.isShowSuspension !=  true,
          child: _buildSusWidget(userModel.id),
        ),
        SizedBox(
          height: itemHeight.toDouble(),
          child: ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(userModel.id),
                  ),
                ),
                Container(
                  child: Text(userModel.avatarUrl,
                      style: TextStyle(letterSpacing: 5, color: Colors.black, fontSize: 15)),
                )
              ],
            ),
            onTap: () {
              Navigator.of(context).pop(userModel);
            },
          ),
        )
      ],
    );
  }
}
