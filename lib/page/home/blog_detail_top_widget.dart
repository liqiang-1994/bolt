import 'package:bolt/model/subject_entity.dart';
import 'package:bolt/page/home/blog_conent_widget.dart';
import 'package:flutter/material.dart';

class BlogDetailTopWidget extends StatefulWidget {
  BlogDetailTopWidget({Key? key, required this.subject}) : super(key: key);

  final Subject subject;

  @override
  State<BlogDetailTopWidget> createState() => _BlogDetailTopWidgetState(subject: subject);
}

class _BlogDetailTopWidgetState extends State<BlogDetailTopWidget> {
  Subject subject;

  _BlogDetailTopWidgetState({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlogContentWidget(subject:subject),
        //shareIdeaWidget(context, subject),
        Container(
          margin: const EdgeInsets.only(top: 15),
          height: 15,
        )
      ],
    );
  }
}

Widget shareIdeaWidget(BuildContext context, Subject subject) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(30, 15, 0, 0),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('分享'),
        InkWell(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            child: const Icon(Icons.share, size: 30),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            child: const Icon(Icons.share, size: 30),
          ),
        )
      ],
    ),
  );
}
