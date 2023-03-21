
import 'package:bolt/page/container/container_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRouter {
  static const homePage = 'app://';
  static const searchPage = 'app://SearchPage';

  MyRouter.push(BuildContext context, String url, dynamic params) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }

  Widget _getPage(String url, dynamic params) {
    if (url.startsWith('https') || url.startsWith('http')) {
      //todo
      return ContainerWidget();
    } else {
      switch(url) {
        case homePage:
          return ContainerWidget();
      }
    }
    return ContainerWidget();
  }
}