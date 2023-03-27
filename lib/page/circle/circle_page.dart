
import 'package:bolt/constant/constants.dart';
import 'package:bolt/widget/search_text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bean/subject_entity.dart';
import '../../router.dart';

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

  late List<Subject> items;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return const Text("data");
  }


}
