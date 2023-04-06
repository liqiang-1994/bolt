
import 'package:bolt/main.dart';
import 'package:bolt/model/subject_entity.dart';
import 'package:bolt/page/container/container_widget.dart';
import 'package:bolt/page/home/blog_conent_widget.dart';
import 'package:bolt/page/home/blog_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  static final GoRouter router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return HomeScreen();
          },
        ),
        GoRoute(
          path: '/blog_detail',
          builder: (BuildContext context, GoRouterState state) {
            return BlogDetailWidget(subject: state.extra as Subject);
          },
        )
      ]
  );
}